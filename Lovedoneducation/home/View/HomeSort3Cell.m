//
//  HomeSort3Cell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeSort3Cell.h"

@implementation HomeSort3Cell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self greenPot];
    }
    return self;
}

- (UILabel *)textL{
    if (!_textL) {
        _textL = [[UILabel alloc] init];
        [self addSubview:_textL];
        [_textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(self.greenPot.mas_right).equalTo(10);
            make.right.equalTo(0);
            make.height.equalTo(15);
        }];
        _textL.font = [UIFont systemFontOfSize:14];
        _textL.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    }
    return _textL;
}

- (UIImageView *)greenPot{
    if (!_greenPot) {
        _greenPot = [[UIImageView alloc] init];
        [self addSubview:_greenPot];
        [_greenPot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(12);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(4, 4));
        }];
        _greenPot.image = [UIImage imageNamed:@"sanjitixing_icon_xuanzetimu"];
    }
    return _greenPot;
}

@end
