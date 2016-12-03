//
//  ProgressBar.swift
//  Doooge
//
//  Created by VicChan on 2016/11/26.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

// Progress : 124*16 / 70 * 9

class ProgressBar: UIView {

    var levelLabel: UILabel!
    var imageView: UIImageView!
    var progressLayer: CAShapeLayer!
    
    var growth: Int
    var level: Int
    
    init(_ frame: CGRect, _ value: Int, lv: Int) {
        growth = value
        level = lv
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(30,2,70,9))
        imageView.image = UIImage(named: "progress")
        addSubview(imageView)
        
        levelLabel = UILabel(frame: CGRect(0,0,30,13))
        levelLabel.font = UIFont.systemFont(ofSize: 10)
        levelLabel.textAlignment = .right
        addSubview(levelLabel)
        
        let ceiling = ScoreManager.manager.getCeiling(level)
        progressLayer = CAShapeLayer()
        progressLayer.frame = CGRect(1,1, CGFloat(growth)*68/CGFloat(ceiling),7)
        progressLayer.backgroundColor = UIColor(red: 86/255.0, green: 184/255.0, blue: 182/255.0, alpha: 1).cgColor
        progressLayer.lineWidth = 7
        progressLayer.strokeColor = UIColor(red: 86/255.0, green: 184/255.0, blue: 182/255.0, alpha: 1).cgColor
        imageView.layer.addSublayer(progressLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func update(_ value: Float) {
        // progressLayer.frame = ()
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
