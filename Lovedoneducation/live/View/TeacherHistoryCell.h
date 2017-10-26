//
//  TeacherHistoryCell.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTKStarView.h"

@interface TeacherHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (nonatomic, strong) WTKStarView *starV;
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet UILabel *fenL;
@property (weak, nonatomic) IBOutlet UILabel *renL;
@property (weak, nonatomic) IBOutlet UIImageView *img_naozhong;

@end
