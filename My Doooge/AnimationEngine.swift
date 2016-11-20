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
    
    case normal = 0
    case sleep  = 1
    case eat    = 2
    case play   = 3
    case touch  = 4
    
}



class AnimationEngine {

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
    
    
    public func switchAnimation(_ mode: DooogeAnimationType) {
        
    
        
        
        
    
    }
    
    
    
    
    
    

}

