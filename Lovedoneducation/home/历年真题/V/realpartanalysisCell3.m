//
//  realpartanalysisCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisCell3.h"

@interface realpartanalysisCell3()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation realpartanalysisCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self setclick];
    }
    return self;
}

-(void)setclick
{
    __weak typeof (self) weakSelf = self;
    weakSelf.typelab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.contentView, 40)
    .widthIs(120)
    .heightIs(25);
    
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 14)
    .rightSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.typelab, 30)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:30];
}

#pragma mark - getters



-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"来源";
        _typelab.textColor = [UIColor colorWithHexString:@"323232"];
        _typelab.font = [UIFont systemFontOfSize:18];
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

-(void)setdatacomestr:(NSString *)comestr
{
    self.contentlab.text = comestr;
}



@end
