//
//  rankingCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rankingCell.h"
#import "WTKStarView.h"
@interface rankingCell()
@property (nonatomic,strong) UIImageView *infoimg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) WTKStarView *startView;
@property (nonatomic,strong) UILabel *scoringLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation rankingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.infoimg];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.introduceLabel];
        [self.contentView addSubview:self.startView];
        [self.contentView addSubview:self.scoringLabel];
        [self.contentView addSubview:self.contentLabel];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    
    [self.contentView sd_addSubviews:@[self.infoimg,self.nameLabel,self.introduceLabel,self.contentLabel,self.startView,self.scoringLabel]];
    
    __weak typeof (self) weakSelf = self;
    self.infoimg.sd_layout.leftSpaceToView(weakSelf.contentView, 18)
    .topSpaceToView(weakSelf.contentView, 33)
    .widthIs(65)
    .heightIs(65);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(weakSelf.infoimg, 20)
    .topSpaceToView(weakSelf.contentView, 33)
    .heightIs(18)
    .rightSpaceToView(weakSelf.contentView, 18);
    
    self.startView.sd_layout
    .leftEqualToView(weakSelf.nameLabel)
    .topSpaceToView(weakSelf.introduceLabel, 14)
    .widthIs(80*HEIGHT_SCALE)
    .heightIs(20*HEIGHT_SCALE);
    
    self.scoringLabel.sd_layout
    .leftSpaceToView(weakSelf.startView, 15)
    .topEqualToView(weakSelf.startView)
    .widthIs(90)
    .heightIs(20);
    
    self.introduceLabel.sd_layout
    .leftSpaceToView(weakSelf.infoimg, 20)
    .rightSpaceToView(weakSelf.contentView, 18)
    .heightIs(16)
    .topSpaceToView(weakSelf.nameLabel, 20);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .autoHeightRatio(0)
    .topSpaceToView(weakSelf.startView, 30);


    
    [self layoutIfNeeded];
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:20];
}

#pragma mark - getters


-(UIImageView *)infoimg
{
    if(!_infoimg)
    {
        _infoimg = [[UIImageView alloc] init];
        _infoimg.backgroundColor = [UIColor orangeColor];
        _infoimg.layer.masksToBounds = YES;
        _infoimg.layer.cornerRadius = 65/2;
    }
    return _infoimg;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名姓名";
        _nameLabel.textColor = [UIColor colorWithHexString:@"323232"];
        _nameLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nameLabel;
}

-(UILabel *)introduceLabel
{
    if(!_introduceLabel)
    {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.text = @"爱唐教育笔试资深名师";
        _introduceLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _introduceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _introduceLabel;
}

-(UILabel *)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"646464"];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.text = @"爱唐教育直播课程，以你的上岸为终极目标，最良心的价格，最良心的内容。在备考过程中有任何疑问，都可以随时跟客服联系。你的上岸就是我们的价值体现，让我们一起为了成公梦想加油！";
    }
    return _contentLabel;
}

-(WTKStarView *)startView
{
    if(!_startView)
    {
        _startView = [[WTKStarView alloc]initWithFrame:CGRectMake(75 / 2.0, 100, 80, 20) starSize:CGSizeZero withStyle:WTKStarTypeFloat];
        _startView.star = 2;
        _startView.isTouch = NO;
    }
    return _startView;
}

-(UILabel *)scoringLabel
{
    if(!_scoringLabel)
    {
        _scoringLabel = [[UILabel alloc] init];
        _scoringLabel.text = @"9.2分";
        _scoringLabel.textColor = [UIColor colorWithHexString:@"FF9B19"];
        _scoringLabel.font = [UIFont systemFontOfSize:12];
    }
    return _scoringLabel;
}





@end
