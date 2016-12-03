//
//  MessageView.swift
//  Doooge
//
//  Created by VicChan on 2016/10/29.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class MessageView: UIView {

    var textLabel: UILabel!
    var imageView: UIImageView!

    open var isShow: Bool = false
    
    func setText(text: String) {
        textLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame:CGRect(0,0,97,22.5))
        textLabel = UILabel(frame: CGRect(1,1,95,20))
        imageView.image = UIImage(named: "diag")
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 7)
        addSubview(imageView)
        addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func appear(_ content: String) {
        textLabel.text = content
        
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1.0
            
        }, completion: nil)
 
        isShow = true
        
    }
    
    
    func update(_ text: String) {
        textLabel.text = text
    }
    
    func disappear() {
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0.0001
        })
        isShow = false
    }

    
    
}
