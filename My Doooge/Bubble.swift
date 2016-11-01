//
//  Bubble.swift
//  Doooge
//
//  Created by VicChan on 2016/10/30.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class Bubble: UILabel {

    
    class func show(score: Int, superView: UIView?) {
        var rect = CGRect(x: 60, y: 30, width:40, height:40)
        let view = Bubble(frame:rect)
        view.backgroundColor = UIColor.orange
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        superView?.addSubview(view)
        
        var up = 1
        
        if score > 0 {
            view.text = "+\(score)"
        } else {
            up = -1
            view.text = "\(score)"
        }

        
        UIView.animate(withDuration: 1.3, animations: {
            view.alpha = 0.0
            rect.origin.y = rect.origin.y - CGFloat(up * 20)
            view.frame = rect
        }){ finished in
            if finished {
                view.removeFromSuperview()
            }
        }
        

        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
