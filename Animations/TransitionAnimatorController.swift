//
//  TransitionAnimatorController.swift
//  Animations
//
//  Created by Miguel Angel Adan Roman on 3/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

protocol TransitionAnimatorControllerDataSource: class {
    func getOriginFrame() -> CGRect
    func overlayView() -> UIView?
}

class TransitionAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionAnimatorDataSource: TransitionAnimatorControllerDataSource?
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        let initialFrame = transitionAnimatorDataSource?.getOriginFrame() ?? CGRect.zero
        let finalFrame = toView.frame
        
        toView.transform = CGAffineTransform(scaleX: initialFrame.width / finalFrame.width, y: initialFrame.height / finalFrame.height)
        
        toView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            toView.transform = .identity
            toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { (completed) in
            transitionContext.completeTransition(true)
        })
    }
}
