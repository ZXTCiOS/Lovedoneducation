//
//  exerciseweeklyCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell0.h"

@interface exerciseweeklyCell0()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *fenshulab;
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *timelab;
@end

@implementation exerciseweeklyCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.fenshulab];
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.timelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    
    [weakSelf.fenshulab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(28);
        make.width.mas_offset(135);
        make.height.mas_offset(135);
    }];
    
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-15);
        make.left.equalTo(weakSelf).with.offset(15);
        make.height.mas_offset(20);
    }];
    
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.timelab.mas_top).with.offset(-15);
        make.left.equalTo(weakSelf).with.offset(15);
    }];
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"background_image_lianxizhoubao"];
    }
    return _bgimg;
}

-(UILabel *)fenshulab
{
    if(!_fenshulab)
    {
        _fenshulab = [[UILabel alloc] init];
        _fenshulab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _fenshulab.font = [UIFont systemFontOfSize:60];
        _fenshulab.textAlignment = NSTextAlignmentCenter;
        _fenshulab.text = @"98";
    }
    return _fenshulab;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.textAlignment = NSTextAlignmentCenter;
        _lab0.text = @"预测分数";
        _lab0.font = [UIFont systemFontOfSize:18];
        _lab0.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _lab0;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textAlignment = NSTextAlignmentCenter;
        _timelab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _timelab.text = @"练习时间:2017.07.14-2017.07.21";
        _timelab.font = [UIFont systemFontOfSize:15];
    }
    return _timelab;
}




@end
