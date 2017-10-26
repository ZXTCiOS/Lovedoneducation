//
//  TeacherHistoryCell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TeacherHistoryCell.h"

@implementation TeacherHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.starV = [[WTKStarView alloc] initWithFrame:CGRectMake(12, 45, 70, 10) starSize:CGSizeMake(10, 10) withStyle:WTKStarTypeFloat];
    self.starV.isTouch = NO;
    [self addSubview:self.starV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
