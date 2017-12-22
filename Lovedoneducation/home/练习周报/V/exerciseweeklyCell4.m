//
//  exerciseweeklyCell4.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell4.h"

@interface exerciseweeklyCell4()
@property (nonatomic,strong) UIView *topbgview;
@property (nonatomic,strong) UILabel *namelabl;
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *numberlab;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation exerciseweeklyCell4

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.topbgview];
        [self.contentView addSubview:self.namelabl];
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.numberlab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;

    weakSelf.topbgview
    .sd_layout
    .leftEqualToView(weakSelf.contentView)
    .rightEqualToView(weakSelf.contentView)
    .heightIs(70)
    .topEqualToView(weakSelf.contentView);
    
    weakSelf.namelabl
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 30)
    .heightIs(20)
    .rightSpaceToView(weakSelf.contentView, 20);
    
    weakSelf.bgimg
    .sd_layout
    .leftEqualToView(weakSelf.contentView)
    .rightEqualToView(weakSelf.contentView)
    .topSpaceToView(weakSelf.contentView, 70)
    .heightIs(275*WIDTH_SCALE);
    
    [self setupAutoHeightWithBottomView: weakSelf.bgimg bottomMargin:0];
    
    [weakSelf.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf).with.offset(-50);
        make.top.equalTo(weakSelf.bgimg).with.offset(90*WIDTH_SCALE);
        make.height.mas_offset(45);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.height.mas_offset(26);
        make.bottom.equalTo(weakSelf).with.offset(-25);
    }];
}

#pragma mark - getters


-(UIView *)topbgview
{
    if(!_topbgview)
    {
        _topbgview = [[UIView alloc] init];
        _topbgview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _topbgview;
}

-(UILabel *)namelabl
{
    if(!_namelabl)
    {
        _namelabl = [[UILabel alloc] init];
        _namelabl.text = @"每分钟完成题目数";
        _namelabl.font = [UIFont systemFontOfSize:17];
        _namelabl.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _namelabl;
}

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"background_image_meifenzhong_lianxizhoubao"];
    }
    return _bgimg;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textAlignment = NSTextAlignmentCenter;
        _numberlab.font = [UIFont systemFontOfSize:60];
        _numberlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        //_numberlab.text = @"1.7";
    }
    return _numberlab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textAlignment = NSTextAlignmentCenter;
        _contentlab.font = [UIFont systemFontOfSize:18];
        _contentlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        //_contentlab.text = @"全站平均11题";
    }
    return _contentlab;
}
-(void)setdata:(NSDictionary *)dic
{
    NSString *userminuteplay = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userminuteplay"]];
    self.numberlab.text = userminuteplay;
    self.contentlab.text = [NSString stringWithFormat:@"%@%@%@",@"全站平均",userminuteplay,@"题"];
}
@end
