//
//  GifImageView.swift
//  Doooge
//
//  Created by VicChan on 2016/10/29.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class GifImageView: UIImageView {

    func play(imageNames: [String],repeated: Bool) {
        self.animationImages?.removeAll()
        self.animationImages = nil
        self.contentMode = .scaleAspectFill
        let count = imageNames.count
        var images = [UIImage]()
        images = [UIImage]()
        images = imageNames.map { (name) -> UIImage in
            AnimationEngine.FileManager.manager.image(name)!
        }
        print("\(count)")
        self.animationImages = images
        self.animationDuration = Double(count) * 0.3
        self.animationRepeatCount = 1
        if repeated {
            self.animationRepeatCount = 0
        } 
        self.startAnimating()
    }
    
    func stop() {
        if self.isAnimating {
            self.stopAnimating()
        }
    }
    

    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
