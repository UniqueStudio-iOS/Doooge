//
//  Transition.swift
//  Doooge
//
//  Created by VicChan on 2016/11/22.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let destView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        let bounds = fromView.bounds
        let startFrame = bounds.offsetBy(dx: 2 * bounds.width, dy: 0)
        destView.frame = startFrame
        transitionContext.containerView.addSubview(destView)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options:.curveLinear, animations: {
            destView.frame = bounds
        }){ (finished) in
            if finished {
                transitionContext.completeTransition(true)
            }
        }
        
    }

}
