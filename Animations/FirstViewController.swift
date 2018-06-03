//
//  ViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

typealias Limits = (min: CGFloat, max: CGFloat)

class FirstViewController: UIViewController {
    
    @IBOutlet weak var optionsContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navMenuButton: UIBarButtonItem! {
        didSet {
            let icon = UIImage(named: "iconmonstr-arrow")
            let iconSize = CGRect(origin: .zero, size: CGSize(width: 24.0, height: 24.0))
            let iconButton = UIButton(frame: iconSize)
            iconButton.setBackgroundImage(icon, for: .normal)
            iconButton.addTarget(self, action: #selector(actionToggleMenu), for: .touchUpInside)
            navMenuButton.customView = iconButton
            navMenuButton.customView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1.0, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveLinear, animations: {
                self.navMenuButton.customView?.transform = .identity
            }, completion: nil)
        }
    }
    
    let menuHeightLimits: Limits = (min: 70.0, max: 200.0)
    let titleXPositionLimits: Limits = (min: -120.0, max: 0.0)
    let titleFontSizeLimits: Limits = (min: 21.0, max: 27.0)
    let avatarSizeLimits: Limits = (min: 40.0, max: 80.0)
    let transition = TransitionAnimatorController()
    
    private var isMenuOpen = false
    private var selectedOptions = [Options]()
    private var selectedOptionOriginPoint: CGPoint?
    private var selectedOption: Options?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transition.transitionAnimatorDataSource = self
        navigationController?.delegate = self
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSizeLimits.min)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 96.0
        
        menuHeightConstraint.constant = menuHeightLimits.min
        optionsContainer.alpha = 0.0
    }

    @IBAction @objc func actionToggleMenu(_ sender: Any) {
        isMenuOpen = !isMenuOpen
        titleLabel.text = isMenuOpen ? "Select item" : "Simple list"
        titleLabel.font = isMenuOpen ? UIFont.boldSystemFont(ofSize: titleFontSizeLimits.max) : UIFont.systemFont(ofSize: titleFontSizeLimits.min)
        self.view.layoutIfNeeded()
        
        // Modifying the constraints by identifier
        if let titleCenterXConstraint = try? titleLabel.superview?.getConstraintWith(id: "TitleCenterXConstraint") {
            titleCenterXConstraint?.constant = isMenuOpen ? titleXPositionLimits.min : titleXPositionLimits.max
        }
        
        // Animating by replacing the affected constraint
        if let titleCenterYConstraint = try? titleLabel.superview?.getConstraintWith(id: "TitleCenterYConstraint") {
            titleCenterYConstraint?.isActive = false
            
            let newConstraint = NSLayoutConstraint(
                item: titleLabel,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: titleLabel.superview,
                attribute: .centerY,
                multiplier: isMenuOpen ? 0.60 : 1.0,
                constant: 5.0
            )
            
            newConstraint.identifier = "TitleCenterYConstraint"
            newConstraint.isActive = true
        }
        
        //Modifying the constraints by IBOutlet
        menuHeightConstraint.constant = isMenuOpen ? menuHeightLimits.max : menuHeightLimits.min
        
        UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn, animations: {
            let angle: CGFloat = self.isMenuOpen ? .pi : 0.0
            self.menuButton.transform = CGAffineTransform(rotationAngle: angle)
            self.navMenuButton.customView?.transform = CGAffineTransform(rotationAngle: angle)
            self.optionsContainer.alpha = self.isMenuOpen ? 1.0 : 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SecondViewController, let selectedOption = sender as? Options {
            viewController.transitioningDelegate = self
            viewController.selectedOption = selectedOption
            return
        }
        
        if let viewController = segue.destination as? OptionsViewController {
            viewController.optionsDelegate = self
            return
        }
    }
}

extension FirstViewController: OptionsDelegate {
    func didSelect(imageView: UIImageView?) {
        if let imageView = imageView {
            let point = imageView.convert(imageView.bounds.origin, to: view)
            imageView.wobble(point: point, parentView: view, duration: 0.2)
        }
    }
    
    func didSelect(option: Options) {
        selectedOptions.insert(option, at: 0)
        let indexPath = IndexPath(row:0 , section:0)
        tableView.insertRows(at: [indexPath], with: .fade)
        
        if let cell = tableView.cellForRow(at: indexPath) as? SelectedOptionTableViewCell {
            cell.animateAvatarSize(min: avatarSizeLimits.min, max: avatarSizeLimits.max)
        }
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedOptionTableViewCell", for: indexPath) as! SelectedOptionTableViewCell
        
        let selectedOption = selectedOptions[indexPath.row]
        let scientificName = selectedOption.scientificName
        let image = UIImage(named: selectedOption.description)
        
        cell.customImageView.image = image
        cell.customTextLabel.text = scientificName
        
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectedOptionTableViewCell {
            selectedOptionOriginPoint = cell.customImageView.convert(cell.customImageView.bounds.origin, to: view)
        }
        
        selectedOption = selectedOptions[indexPath.row]
        self.performSegue(withIdentifier: "SecondViewControllerSegue", sender: selectedOption)
    }
}

extension FirstViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return transition
        }
        
        return nil
    }
}

extension FirstViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

extension FirstViewController: TransitionAnimatorControllerDataSource {
    func overlayView() -> UIView? {
        guard let selectedOption = selectedOption else {
            return nil
        }
        
        let overlayView = TransitionOverlayView(frame: view.frame)
        overlayView.createOverlayView(selectedOption: selectedOption)
        
        return overlayView
    }
    
    func getOriginFrame() -> CGRect {
        let initialWidth: CGFloat = 250.0
        let initialHeight: CGFloat = 200.0
        let originPoint = view.frame.origin
        let originFrame = CGRect(origin: originPoint, size: CGSize(width: initialWidth, height: initialHeight))
        return originFrame
    }
}
