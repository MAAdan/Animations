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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView.layer.cornerRadius = customImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
