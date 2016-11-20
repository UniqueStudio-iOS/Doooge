//
//  ScoreManager.swift
//  Doooge
//
//  Created by VicChan on 2016/11/19.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import Foundation


/// 成绩管理

enum ScoreRule: Int {
    case continue_3_day = 15
    case continue_7_day = 30
    case continue_21_day = 100
    case normal = 10
    case custom_late = 5
    case undo = -5
}

class ScoreManager {

    
    var growthValue: Int = 50
    var level: Int = 1
    var coin: Int = 50
    
    var ceiling = 300
    
    
    
    static let manager: ScoreManager = {
        let instance = ScoreManager()
        let tuple = instance.load()
        instance.level = tuple.level
        instance.coin = tuple.coin
        instance.growthValue = tuple.growth
        return instance
    }()
    
    // 坚持某个事件
    func keepDoing(days: Int) {
    
    
    }
    
    // 加载数据
    func load() -> (level: Int, growth: Int, coin: Int) {
        return (2,250,50)
    }
    
    //  MARK: 等级增加
    func incrementLevel() {
        ceiling = getCeiling(level)
        if growthValue > ceiling {
            level += 1
        }
    }
    
    // 设置上限
    func getCeiling(_ level: Int) -> Int{
        let ceil = ceiling + level * 50
        return ceil > 1000 ? 1000: ceil
    }
    
    // MARK: 存储数据值
    private func save() {
    
    
    }
    
    
    


}
