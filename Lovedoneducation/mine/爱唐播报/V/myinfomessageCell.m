//
//  myinfomessageCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfomessageCell.h"
#import "myinfomessageModel.h"

@interface myinfomessageCell()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) myinfomessageModel *infomodel;
@end

@implementation myinfomessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.timelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf).with.offset(20);
    }];
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.typelab);
        make.right.equalTo(weakSelf.typelab);
        make.height.mas_offset(125);
    }];
    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgimg);
        make.left.equalTo(weakSelf.bgimg);
        make.right.equalTo(weakSelf.bgimg);
        make.height.mas_offset(20);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgimg);
        make.right.equalTo(weakSelf.bgimg);
//        make.height.mas_offset(20);
        
        make.top.equalTo(weakSelf.bgimg.mas_bottom).with.offset(20);
    }];
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgimg);
        make.right.equalTo(weakSelf.bgimg);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(5);
    }];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"备战面试";
        _typelab.font = [UIFont systemFontOfSize:17];
        _typelab.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _typelab;
}


-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        [_bgimg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508922269774&di=ebaf47bcf40b8288e3a5306f36cd6746&imgtype=0&src=http%3A%2F%2Fstatic.xialv.com%2Fscenery%2F2014%2F07%2F19%2F65%2F14057586247055rwqlv_700X350.jpg"]];
    }
    return _bgimg;
}


-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:15];
        _namelab.text = @"泰安宁阳事业单位面试冲刺";
    }
    return _namelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.text = @"泰安宁阳事业单位面试冲刺";
        _contentlab.font = [UIFont systemFontOfSize:15];
        _contentlab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _contentlab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.text = @"2018.08.29";
        _timelab.font = [UIFont systemFontOfSize:15];
        _timelab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _timelab;
}

-(void)setdata:(myinfomessageModel *)model
{
    self.infomodel = model;
    self.timelab.text = [self timeWithTimeIntervalString:model.time];
    [self.bgimg sd_setImageWithURL:[NSURL URLWithString:model.pdurl]];
    self.contentlab.text = model.pdintro;
    self.namelab.text = model.pdintro;
    self.typelab.text = model.pdtitle;
}

-(NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    NSString *str=timeString;
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    // [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
@end
