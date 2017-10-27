//
//  LiveOrderCell.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIControl *kechengquanBtn;

@property (weak, nonatomic) IBOutlet UIButton *cashDiyongBtn;

@property (weak, nonatomic) IBOutlet UILabel *kechengquanNum;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *diyongquanNum;

@property (weak, nonatomic) IBOutlet UILabel *hideL;

@end
