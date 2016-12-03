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
    func touchedImage()
}

class AnimationView: UIImageView {

    typealias ImageName = String
    var tapGesture: UITapGestureRecognizer!
    var delegate: AnimationViewDelegete?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.addObserver(self, forKeyPath: #keyPath(AnimationView.isAnimating), options: [.old,.new], context: nil)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(AnimationView.tap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        
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
    

    func tap(_ sender: UITapGestureRecognizer) {
        delegate?.touchedImage()
    }
    
    
    func stop() {
        if isAnimating {
            stopAnimating()
        }
    }
    
    deinit {
       //  self.removeObserver(self, forKeyPath: #keyPath(AnimationView.isAnimating))
    }

}
