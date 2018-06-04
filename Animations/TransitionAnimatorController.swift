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
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        let initialFrame = transitionAnimatorDataSource?.getOriginFrame() ?? CGRect.zero
        let finalFrame = toView.frame
        
        let initialWidth = initialFrame.width / finalFrame.width
        let initialHeight = initialFrame.height / finalFrame.height
        
        toView.transform = CGAffineTransform(scaleX: initialWidth, y: initialHeight)
        
        toView.center = CGPoint(x: fromView.frame.width / 2.0, y: fromView.frame.height / 2.0)
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            toView.transform = .identity
            toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { (completed) in
            transitionContext.completeTransition(true)
        })
    }
}
