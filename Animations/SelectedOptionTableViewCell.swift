//
//  SelectedOptionTableViewCell.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 31/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class SelectedOptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customTextLabel: UILabel!
    @IBOutlet weak var customImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customImageViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView.layer.cornerRadius = customImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func animateAvatar() {
        customImageViewHeight.constant = 60
        customImageViewWidth.constant = 60
        self.contentView.layoutIfNeeded()
        
        customImageViewHeight.constant = 80
        customImageViewWidth.constant = 80
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: [], animations: {
            self.contentView.layoutIfNeeded()
        }, completion: nil)
    }
}
