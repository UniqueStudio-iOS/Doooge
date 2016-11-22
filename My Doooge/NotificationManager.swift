//
//  NotificationManager.swift
//  Doooge
//
//  Created by VicChan on 2016/11/19.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import Foundation

struct NotificationModel {
    
    var content: String
    
}

class NotificationManager {
    
    var timer: Timer?
    
    var queue: [NotificationModel]?
    
    var randomNotification: [NotificationModel]?
    
    
    func showRandom(content: [NotificationModel]) {
        randomNotification = content
        var interval: TimeInterval = 0
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            interval += 30
            let model = content[Int(interval)%content.count]
            print(model)
        })
    }

    
}
