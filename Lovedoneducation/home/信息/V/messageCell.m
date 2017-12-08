//
//  messageCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messageCell.h"
#import "messageModel.h"

@interface messageCell()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIImageView *timeimg;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) messageModel *mmodel;
@end

@implementation messageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.timeimg];
        [self.contentView addSubview:self.timelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    
    [self.contentView sd_addSubviews:@[self.leftimg,self.contentlab,self.timeimg,self.timeimg]];
    
    __weak typeof (self) weakSelf = self;
    
    weakSelf.leftimg.sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .leftSpaceToView(weakSelf.contentView, 14)
    .widthIs(18)
    .heightIs(18);
    
    weakSelf.contentlab.sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .leftSpaceToView(weakSelf.contentView, 58)
    .rightSpaceToView(weakSelf.contentView, 14)
    .autoHeightRatio(0);
    
    weakSelf.timeimg.sd_layout
    .topSpaceToView(weakSelf.contentlab, 20)
    .leftSpaceToView(weakSelf.contentView, 58)
    .widthIs(10)
    .heightIs(10);
    
    weakSelf.timelab.sd_layout
    .topSpaceToView(weakSelf.contentlab, 20)
    .leftSpaceToView(weakSelf.timeimg, 20)
    .heightIs(12)
    .widthIs(100);
    
    [self setupAutoHeightWithBottomView:self.timelab bottomMargin:20];
}
#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"message_icon_default_nav"];
    }
    return _leftimg;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:15];
        _contentlab.textColor = [UIColor colorWithHexString:@"323232"];
        _contentlab.text = @"您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信您有一封平台站内信";
    }
    return _contentlab;
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

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor colorWithHexString:@"646464"];
        _timelab.font = [UIFont systemFontOfSize:12];
    }
    return _timelab;
}

-(void)setdata:(messageModel *)model
{
    self.mmodel = model;
    self.contentlab.text = model.messageintro;
    self.timelab.text = [strisNull timeWithTimeIntervalString:model.time];
}

@end
