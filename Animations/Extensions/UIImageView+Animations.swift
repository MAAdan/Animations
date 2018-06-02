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
    
    private func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
    
    private func place(imageView: UIImageView, point: CGPoint, parentView: UIView, size: CGFloat) {
        
        let widthConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: size
        )
        widthConstraint.identifier = "width"
        widthConstraint.isActive = true
        
        let heightConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: size
        )
        heightConstraint.identifier = "height"
        heightConstraint.isActive = true
        
        let leadingConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: point.x + (size / 2)
        )
        leadingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .top,
            multiplier: 1.0,
            constant: point.y + (size / 2)
        )
        topConstraint.isActive = true
        parentView.layoutIfNeeded()
        
    }
    
    func shakeIn(point: CGPoint, parentView: UIView, duration: TimeInterval, withTranslation translation: CGFloat) {
        
        guard let image = self.image else {
            return
        }
        
        let size = self.frame.height
        let animatedImage = UIImageView(image: image)
        animatedImage.layer.cornerRadius = size / 2.0
        animatedImage.clipsToBounds = true
        animatedImage.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(animatedImage)
        
        place(imageView: animatedImage, point: point, parentView: parentView, size: size)
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.25) {
            let random = CGFloat(self.randomCGFloat(min: -1.5, max: 1.5))
            
            animatedImage.transform = CGAffineTransform(
                translationX: translation * random,
                y: translation * random
            )
        }
        
        propertyAnimator.addCompletion { (animatingPosition) in
            animatedImage.removeFromSuperview()
        }
        
        propertyAnimator.addAnimations({
            animatedImage.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }

    
    func animateAvatarImageViewIn(point: CGPoint, parentView: UIView, finalScale: CGFloat) {
        guard let image = self.image else {
            return
        }
        
        let size = self.frame.height
        let animatedImage = UIImageView(image: image)
        animatedImage.layer.cornerRadius = size / 2.0
        animatedImage.clipsToBounds = true
        animatedImage.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(animatedImage)
        
        place(imageView: animatedImage, point: point, parentView: parentView, size: size)
        
        if let heightConstraint = try? animatedImage.getConstraintWith(id: "height"), let widthConstraint = try? animatedImage.getConstraintWith(id: "width") {
            heightConstraint?.constant = size * finalScale
            widthConstraint?.constant = size * finalScale
            
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [.autoreverse], animations: {
                
                animatedImage.layer.cornerRadius = (size * finalScale) / 2
                parentView.layoutIfNeeded()
            }, completion: { (completed) in
                if completed {
                    animatedImage.removeFromSuperview()
                }
            })
        } else {
            animatedImage.removeFromSuperview()
        }
    }
}
