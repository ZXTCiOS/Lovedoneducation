//
//  LiveEvalutateCell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveEvalutateCell.h"

@implementation LiveEvalutateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (WTKStarView *)starV{
    if (!_starV) {
        _starV = [[WTKStarView alloc] initWithFrame:CGRectMake(12, 45, 70, 10) starSize:CGSizeMake(10, 10) withStyle:WTKStarTypeFloat];
        self.starV.isTouch = NO;
        [self addSubview:_starV];
        [_starV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(12);
            make.bottom.equalTo(-15);
            make.size.equalTo(CGSizeMake(70, 10));
        }];
    }
    return _starV;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
