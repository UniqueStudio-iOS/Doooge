//
//  AnimationEngine.swift
//  Doooge
//
//  Created by VicChan on 2016/11/19.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit


/// 动做处理处理引擎
enum DooogeAnimationType: Int {
    
    case normal     = 0
    case sleep      = 1
    case eat        = 2
    case play       = 3
    case touch      = 4
    case sleeping   = 5 // 持续睡觉
    
}


class AnimationEngine: NSObject {

    var animationView: AnimationView!
    var state: DooogeAnimationType = .normal
    var timer: Timer?
    

    
    struct FileManager {
        var bundle: Bundle!
        
        static let manager: FileManager = {
            var instance = FileManager()
            let path = Bundle.main.path(forResource: "Movements", ofType: "bundle")
            instance.bundle = Bundle.init(path: path!)
            return instance
        }()
        
        func image(_ name: String) -> UIImage? {
            let path = self.bundle.path(forResource: name, ofType: "png")
            if let imagePath = path {
                return UIImage(contentsOfFile: imagePath)
            } else {
                return nil
            }
        }
    }
    
    static let shared: AnimationEngine = {
        let instance = AnimationEngine()
        return instance
    }()
    
    
    // 初始化动画View
    func initView(_ animationView: AnimationView) {
        self.animationView = animationView
        self.animationView.delegate = self
    }
    
    public func switchAnimation(_ mode: DooogeAnimationType) {

        timer?.invalidate()
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)

        let animationArray = Movement.move.type(mode)
        state = mode
        animationView.play(animationArray, false)
        
        if mode == .sleep {
            self.perform(#selector(AnimationEngine.sleepState), with: nil, afterDelay:Double(animationArray.count) * 0.3)
            // 进入持续睡眠状态
            state = .sleeping
        } else {
            self.perform(#selector(AnimationEngine.defaultAnimation), with: nil, afterDelay: Double(animationArray.count) * 0.3-0.2)
        }
    }
    
    
    public func defaultAnimation() {
        state = .normal
        let animationArr = Movement.move.type(.normal)
        self.animationView.play(animationArr, true)
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: {[unowned self] (timer) in
            let animationArr = Movement.move.type(.normal)
            self.animationView.play(animationArr, true)
        })
    }
    
    public func sleepState() {
        state = .sleeping
        let animationArray = Movement.move.type(.sleeping)
        animationView.play(animationArray, true)
    }
    
    // MARK: 动作模块
    struct Movement {
        var eat: [String] {
            return ["eat11","eat12","eat13","eat14","eat15","eat16","eat17","eat18","eat19","eat110","eat17","eat18","eat19","eat110"]
        }
        var sleep: [String] {
            return ["sleep1","sleep2","sleep3","sleep4","sleep5","sleep6"]
        }
        
        var sleepState:[String] {
            return ["sleep5","sleep6"]
        }
        
        var playBall: [String] {
            return ["play1","play2","play3","play4","play5","play6","play7","play8","play9","play10"]
        }
        
        var touch: [String] {
            return ["touch1","touch2","touch3","touch4"]
        }
        
        var wearHat: [String] {
            return ["wear1","wear2","wear3","wear4","wear5","wear6"]
        }
        var defaults: [String] {
            if random()%2 == 0 {
                return ["eyes1","eyes"]
            } else {
                return ["random1","random2"]
            }
        }
        private func random() -> Int {
            let num = arc4random()%10
            return Int(num)
        }
        
        func type(_ type: DooogeAnimationType)->[String] {
            switch type {
            case .eat:return eat
            case .normal:return defaults
            case .play:return playBall
            case .sleep:return sleep
            case .touch:return touch
            case .sleeping:return sleepState
            }
        }
        
        static let move:  Movement = {
            let instance = Movement()
            return instance
        }()
        
    }
    

}


extension AnimationEngine: AnimationViewDelegete {
    func didStopAnimating() {
        if state == .sleeping {
            sleepState()
        } else {
            defaultAnimation()
        }
    }
}

