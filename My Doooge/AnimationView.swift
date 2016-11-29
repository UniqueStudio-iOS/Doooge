//
//  AnimationView.swift
//  Doooge
//
//  Created by VicChan on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

protocol AnimationViewDelegete {
    func didStopAnimating()
}

class AnimationView: UIImageView {

    typealias ImageName = String
    
    var delegate: AnimationViewDelegete?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addObserver(self, forKeyPath: #keyPath(AnimationView.isAnimating), options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.animationRepeatCount = repeated ? 0 : 1
        startAnimating()
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AnimationView.isAnimating) {
            let value = change?[.newKey] as! Bool
            if !value {
                delegate?.didStopAnimating()
            }
        }
    }
    
    func stop() {
        if isAnimating {
            stopAnimating()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: #keyPath(AnimationView.isAnimating))
    }

}
