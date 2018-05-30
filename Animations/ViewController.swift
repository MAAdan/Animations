//
//  ViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionToggleMenu(_ sender: UIButton) {
        isMenuOpen = !isMenuOpen
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
        
        UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

