//
//  UIImageView+Animations.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 2/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func animateAvatarImageViewIn(point: CGPoint, parentView: UIView) {
        guard let image = self.image else {
            return
        }
        
        let size = self.frame.height
        let animatedImage = UIImageView(image: image)
        animatedImage.layer.cornerRadius = size / 2.0
        animatedImage.clipsToBounds = true
        animatedImage.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(animatedImage)
        
        let widthConstraint = NSLayoutConstraint(
            item: animatedImage,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: size
        )
        widthConstraint.isActive = true
        
        let heightConstraint = NSLayoutConstraint(
            item: animatedImage,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: size
        )
        heightConstraint.isActive = true
        
        let leadingConstraint = NSLayoutConstraint(
            item: animatedImage,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: point.x + (size / 2)
        )
        leadingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(
            item: animatedImage,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .top,
            multiplier: 1.0,
            constant: point.y + (size / 2)
        )
        topConstraint.isActive = true
        parentView.layoutIfNeeded()
        
        let finalScale: CGFloat = 1.35
        widthConstraint.constant = size * finalScale
        heightConstraint.constant = size * finalScale
        
        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [.autoreverse], animations: {
            
            animatedImage.layer.cornerRadius = (size * finalScale) / 2
            parentView.layoutIfNeeded()
        }, completion: { (completed) in
            if completed {
                animatedImage.removeFromSuperview()
            }
        })
    }
}
