//
//  TransitionOverlayView.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 3/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

class TransitionOverlayView: UIView {
    
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var avatarImageView: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createOverlayView(selectedOption: Options) {
        let imageViewSize: CGFloat = 120.0
        let overlayView = UIView(frame: self.frame)
        overlayView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(overlayView)
        
        let topConstraint = NSLayoutConstraint(item: overlayView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: overlayView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: overlayView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leftConstraint = NSLayoutConstraint(item: overlayView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        topConstraint.isActive = true
        rightConstraint.isActive = true
        bottomConstraint.isActive = true
        leftConstraint.isActive = true
        
        avatarImageView = UIImageView(image: UIImage(named: selectedOption.description))
        if let avatarImageView =  avatarImageView {
            avatarImageView.translatesAutoresizingMaskIntoConstraints = false
            avatarImageView.layer.cornerRadius = imageViewSize / 2.0
            avatarImageView.clipsToBounds = true
            overlayView.addSubview(avatarImageView)
            
            let widthConstraint = NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageViewSize)
            let heightConstraint = NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: imageViewSize)
            let centerXConstraint = NSLayoutConstraint(item: avatarImageView, attribute: .centerX, relatedBy: .equal, toItem: overlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: avatarImageView, attribute: .centerY, relatedBy: .equal, toItem: overlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            widthConstraint.isActive = true
            heightConstraint.isActive = true
            centerXConstraint.isActive = true
            centerYConstraint.isActive = true
            widthConstraint.identifier = "width"
            heightConstraint.identifier = "height"
        }
    }
}
