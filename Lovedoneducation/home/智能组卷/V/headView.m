//
//  headView.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "headView.h"

@implementation headView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [self addSubview:self.numberlab];
        [self addSubview:self.rightbtn];
        [self addSubview:self.timelab];
        [self startlayout];
    }
    return self;
}

-(void)startlayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    [weakSelf.rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-20);
        make.top.equalTo(weakSelf).with.offset(20);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(120);
        make.right.equalTo(weakSelf).with.offset(-120);
        make.height.mas_offset(20);
        make.top.equalTo(weakSelf.numberlab);
    }];
}

#pragma mark - getters


-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
        _numberlab.font = [UIFont systemFontOfSize:15];
    }
    return _numberlab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"datika_icon"] forState:normal];
    }
    return _rightbtn;
}


-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textAlignment = NSTextAlignmentCenter;
        _timelab.font = [UIFont systemFontOfSize:19];
        _timelab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
        _timelab.text = @"00:00";
    }
    return _timelab;
}






@end
