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
    var id: Int
    var isFinished:Bool = false
    
    init(_ content: String, _ id: Int, _ isFinished: Bool = false) {
        self.content = content
        self.isFinished = isFinished
        self.id = id
    }
    
}


protocol NotificationDelegate {

    func didChangeNotification(index: Int,id: Int)
}

class NotificationManager {
    
    var timer: Timer?
    
    var delegate: NotificationDelegate?
    
    var queue: [NotificationModel]?
    
    var randomNotification: [NotificationModel]?
    
    var messageView: MessageView!
    
    init(view: MessageView) {
        self.messageView = view
    }

    
    func showRandom(content: [NotificationModel]) {
        timer?.invalidate()
        randomNotification = content
        
        self.messageView.appear((content.first?.content)!)
        var interval: TimeInterval = 0
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { [unowned self](timer) in
            interval += 3
            var index = Int(interval)/3
            index = index%content.count
            self.messageView.appear(content[index].content)
            self.delegate?.didChangeNotification(index: index,id: content[index].id)
        })
    }
    
    
    

    
}
