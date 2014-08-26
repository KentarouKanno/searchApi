//
//  AppDataTableViewCell.h
//  Review
//
//  Created by KentarOu on 2014/08/20.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDataTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (assign, nonatomic) BOOL opneFlg;

@end
