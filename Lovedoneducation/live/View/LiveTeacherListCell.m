//
//  LiveTeacherListCell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveTeacherListCell.h"

@implementation LiveTeacherListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 32.5;
    self.imgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
