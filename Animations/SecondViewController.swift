//
//  SecondViewController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 3/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var content: UIView!
    var selectedOption: Options?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedOption = selectedOption else {
            return
        }
        
        navigationController?.navigationBar.tintColor = .white
        
        headerImageView.image = UIImage(named: selectedOption.description)
        headerImageView.layer.cornerRadius = headerImageView.frame.height / 2
        header.backgroundColor = selectedOption.color
        content.backgroundColor = selectedOption.color
        content.alpha = 0.25
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        headerImageView.animateAvatarImageViewIn(point: headerImageView.frame.origin, parentView: header, finalScale: 2.0) {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
