//
//  HomeSort3View.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeSort3View.h"

@implementation HomeSort3View

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, 48)];
    if (self) {
        [self textL];
    }
    return self;
}


- (UILabel *)textL{
    if (!_textL) {
        _textL = [[UILabel alloc] init];
        [self addSubview:_textL];
        [_textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.greenPot);
            make.left.equalTo(self.greenPot.mas_right).equalTo(10);
            make.right.equalTo(0);
            make.height.equalTo(17);
        }];
        _textL.font = [UIFont systemFontOfSize:14];
        _textL.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    }
    return _textL;
}

- (UIImageView *)greenPot{
    if (!_greenPot) {
        _greenPot = [[UIImageView alloc] init];
        [self addSubview:_greenPot];
        [_greenPot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(13);
            make.top.equalTo(self.line.mas_bottom).equalTo(35.5);
            make.size.equalTo(CGSizeMake(6, 6));
        }];
        _greenPot.image = [UIImage imageNamed:@"yijitixing_icon_shouye"];
    }
    return _greenPot;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(1);
        }];
        _line.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    }
    return _line;
}

@end
