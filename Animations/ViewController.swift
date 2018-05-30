//
//  ViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

typealias Limits = (min: CGFloat, max: CGFloat)

class ViewController: UIViewController {

    @IBOutlet weak var optionsContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    let menuHeightLimits: Limits = (min: 70.0, max: 200.0)
    let titleXPositionLimits: Limits = (min: -120.0, max: 0.0)
    
    var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuHeightConstraint.constant = menuHeightLimits.min
        optionsContainer.alpha = 0.0
    }

    @IBAction func actionToggleMenu(_ sender: UIButton) {
        isMenuOpen = !isMenuOpen
        titleLabel.text = isMenuOpen ? "Select item" : "Simple list"
        self.view.layoutIfNeeded()
        
        // Modifying the constraints by identifier
        let constraints = titleLabel.superview?.constraints.filter{ $0.identifier == "TitleCenterXConstraint" }
        if let titleCenterXConstraint = constraints?.first {
            titleCenterXConstraint.constant = isMenuOpen ? titleXPositionLimits.min : titleXPositionLimits.max
        }
        
        //Modifying the constraints by IBOutlet
        menuHeightConstraint.constant = isMenuOpen ? menuHeightLimits.max : menuHeightLimits.min
        
        UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn, animations: {
            let angle: CGFloat = self.isMenuOpen ? .pi : 0.0
            self.menuButton.transform = CGAffineTransform(rotationAngle: angle)
            self.optionsContainer.alpha = self.isMenuOpen ? 1.0 : 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

