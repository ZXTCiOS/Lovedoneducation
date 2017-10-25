//
//  LiveCourseCell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveCourseCell.h"

@implementation LiveCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.teacher1Img.layer.cornerRadius = 17.5;
    self.teacher1Img.layer.masksToBounds = YES;
    self.teacher2Img.layer.cornerRadius = 17.5;
    self.teacher2Img.layer.masksToBounds = YES;
    self.teacher3Img.layer.cornerRadius = 17.5;
    self.teacher3Img.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
