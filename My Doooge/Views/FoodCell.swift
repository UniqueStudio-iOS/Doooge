//
//  FoodCell.swift
//  Doooge
//
//  Created by VicChan on 2016/11/29.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

class FoodCell: UICollectionViewCell {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var numLabel: UILabel!
    
    func set(_ content: UIImage?) {
        imageView.image = content
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
