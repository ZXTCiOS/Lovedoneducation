//
//  essayorderCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayorderCell0.h"

@interface essayorderCell0()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UIImageView *timeimg;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation essayorderCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.timeimg];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(25);
        make.height.mas_offset(20);
    }];
    [weakSelf.timeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab);
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(20);
        make.width.mas_offset(12);
        make.height.mas_offset(12);
    }];
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeimg.mas_right).with.offset(15);
        make.top.equalTo(weakSelf.timeimg);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab);
        make.top.equalTo(weakSelf.timeimg.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-15);
        
    }];
    
    
}

#pragma mark - getters


-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"datiliang_image_shujubaogao"];
    }
    return _bgimg;
}

-(UIImageView *)timeimg
{
    if(!_timeimg)
    {
        _timeimg = [[UIImageView alloc] init];
        _timeimg.image = [UIImage imageNamed:@"timeyellow_icon_disable"];
    }
    return _timeimg;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textAlignment = NSTextAlignmentLeft;
        _typelab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
        _typelab.text = @"申论专项批改";
        _typelab.font = [UIFont systemFontOfSize:18];
    }
    return _typelab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.text = @"2017.08.14";
        _timelab.font = [UIFont systemFontOfSize:12];
        _timelab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _timelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];

        _contentlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _contentlab.font = [UIFont systemFontOfSize:15];
    }
    return _contentlab;
}


#pragma mark - 数据方法

-(void)setdatatimestr:(NSString *)timestr andnumstr:(NSString *)numstr andpricestr:(NSString *)pricestr
{
    self.timelab.text = timestr;
    self.contentlab.text = [NSString stringWithFormat:@"%@%@%@%@",@"共做",numstr,@"道题目，共计",pricestr];
}



@end
