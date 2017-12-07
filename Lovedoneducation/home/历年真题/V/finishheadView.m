//
//  finishheadView.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "finishheadView.h"

@implementation finishheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameLab];
        [self addSubview:self.timeLab];
        [self setlayout];
    }
    return self;
}

-(void)setlayout
{
    self.nameLab.frame = CGRectMake(20, 10, kScreenW-40, 25);
    self.timeLab.frame = CGRectMake(20, 35, kScreenW-40, 20);
}

#pragma mark - getters

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
    }
    return _nameLab;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
    }
    return _timeLab;
}

@end
