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
    
    private func duplicateImageView(image: UIImage, size: CGFloat) -> UIImageView {
        let duplicate = UIImageView(image: image)
        duplicate.layer.cornerRadius = size / 2.0
        duplicate.clipsToBounds = true
        duplicate.translatesAutoresizingMaskIntoConstraints = false
        
        return duplicate
    }
    
    private func degreesToRadians(x: CGFloat) -> CGFloat {
        return .pi * x / 180.0
    }
    
    func wobble(point: CGPoint, parentView: UIView, duration: TimeInterval) {
        guard let image = self.image else {
            return
        }
        let animationRotateDegres: CGFloat = 15.0
        let animationTranslateX: CGFloat = 0.0
        let animationTranslateY: CGFloat = 0.0
        let count = 1
        
        let size = self.frame.height
        let duplicate = duplicateImageView(image: image, size: size)
        parentView.addSubview(duplicate)
        isHidden = true
        
        place(imageView: duplicate, point: point, parentView: parentView, size: size)
        
        let leftOrRight: CGFloat = (count % 2 == 0 ? 1 : -1)
        let rightOrLeft: CGFloat = (count % 2 == 0 ? -1 : 1)
        let rightWobble = CGAffineTransform(rotationAngle: degreesToRadians(x: animationRotateDegres * rightOrLeft))
        let leftWobble = CGAffineTransform(rotationAngle: degreesToRadians(x: animationRotateDegres * leftOrRight))
        let moveTransform = leftWobble.translatedBy(x: -animationTranslateX, y: -animationTranslateY)
        let conCatTransform = leftWobble.concatenating(moveTransform)
        
        // starting point
        duplicate.transform = rightWobble
        
        UIView.animate(withDuration: duration, delay: 0.08, options: [.autoreverse, .repeat], animations: { () -> Void in
            UIView.setAnimationRepeatCount(3.0)
            duplicate.transform = conCatTransform
            
        }, completion: {(completed) in
            self.isHidden = false
            duplicate.removeFromSuperview()
        })
    }
    
    func shakeIn(point: CGPoint, parentView: UIView, duration: TimeInterval, translation: CGFloat) {
        
        guard let image = self.image else {
            return
        }
        
        let size = self.frame.height
        let duplicate = duplicateImageView(image: image, size: size)
        parentView.addSubview(duplicate)
        place(imageView: duplicate, point: point, parentView: parentView, size: size)
        
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.25) {
            let random = CGFloat(self.randomCGFloat(min: -1.5, max: 1.5))
            
            duplicate.transform = CGAffineTransform(
                translationX: translation * random,
                y: translation * random
            )
        }
        
        propertyAnimator.addCompletion { (animatingPosition) in
            duplicate.removeFromSuperview()
        }
        
        propertyAnimator.addAnimations({
            duplicate.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }

    
    func animateAvatarImageViewIn(point: CGPoint, parentView: UIView, finalScale: CGFloat, completion: @escaping () -> Void) {
        guard let image = self.image else {
            return
        }
        
        let size = self.frame.height
        let duplicate = duplicateImageView(image: image, size: size)
        parentView.addSubview(duplicate)
        place(imageView: duplicate, point: point, parentView: parentView, size: size)
        
        if let heightConstraint = try? duplicate.getConstraintWith(id: "height"), let widthConstraint = try? duplicate.getConstraintWith(id: "width") {
            heightConstraint?.constant = size * finalScale
            widthConstraint?.constant = size * finalScale
            
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [.autoreverse], animations: {
                
                duplicate.layer.cornerRadius = (size * finalScale) / 2
                parentView.layoutIfNeeded()
            }, completion: { (completed) in
                if completed {
                    duplicate.removeFromSuperview()
                    completion()
                }
            })
        } else {
            duplicate.removeFromSuperview()
            completion()
        }
    }
}
