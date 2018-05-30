//
//  OptionCollectionViewCell.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 30/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView.layer.cornerRadius = customImageView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
