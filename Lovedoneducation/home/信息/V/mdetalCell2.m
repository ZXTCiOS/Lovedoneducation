//
//  mdetalCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mdetalCell2.h"

@interface mdetalCell2()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;

@end

@implementation mdetalCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    weakSelf.typelab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.typelab, 25)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:25];
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:26];
        _typelab.textColor = [UIColor colorWithHexString:@"323232"];
        _typelab.text = @"批改结果";
    }
    return _typelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:16];
        _contentlab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _contentlab;
}
-(void)setdata:(NSString *)str
{
    self.contentlab.text = str;
}

@end
