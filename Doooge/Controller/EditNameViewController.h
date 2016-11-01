//
//  EditNameViewController.h
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditedBlock)(NSString *);

@interface EditNameViewController : UITableViewController
@property (nonatomic, copy) EditedBlock editedBlock;
@end
