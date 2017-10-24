//
//  HomeSortCell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeSortCell.h"

@implementation HomeSortCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self arrow];
        [self imgV];
        [self titleL];
    }
    return self;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(self.titleL.mas_top).equalTo(-15);
        }];
    }
    return _imgV;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        [self addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(self.imgV.mas_bottom).equalTo(10);
            make.left.equalTo(0);
            make.right.equalTo(self.arrow.mas_left);
            make.bottom.equalTo(0);
            make.height.equalTo(16);
        }];
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textColor = krgb(50, 50, 50);
    }
    return _titleL;
}

- (UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        [self addSubview:_arrow];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-12);
            make.bottom.equalTo(0);
            make.size.equalTo(CGSizeMake(7, 13));
        }];
        
        _arrow.image = [UIImage imageNamed:@"weizhankai_button_default"]; // zhankaijiantou_icon
    }
    return _arrow;
}










@end
