//
//  AnimationView.swift
//  Doooge
//
//  Created by VicChan on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class AnimationView: UIImageView {

    typealias ImageName = String
    
    func play(_ imageNames: [ImageName], _ repeated: Bool, _ per: Double = 0.3) {
        self.animationImages?.removeAll()
        self.animationImages = nil
        contentMode = .scaleAspectFill
        let images = imageNames.map { (name) -> UIImage in
            return AnimationEngine.FileManager.manager.image(name)!
        }
        self.animationImages = images
        let count = images.count

        self.animationDuration = Double(count) * per
        self.animationRepeatCount = repeated ? 1 : 0
        startAnimating()
    }
    
    func stop() {
        if isAnimating {
            stopAnimating()
        }
    }
    


}
