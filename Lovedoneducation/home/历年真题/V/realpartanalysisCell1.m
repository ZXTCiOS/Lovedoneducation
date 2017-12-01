//
//  realpartanalysisCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisCell1.h"

@interface realpartanalysisCell1()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation realpartanalysisCell1

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
    .leftSpaceToView(weakSelf.contentView, 20)
    .widthIs(120)
    .topSpaceToView(self.contentView, 40)
    .heightIs(25);
    
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .widthIs(kScreenW/2-20)
    .heightIs(44)
    .topSpaceToView(weakSelf.typelab, 20);
    
    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:40];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"考点";
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
        _contentlab.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        _contentlab.textAlignment = NSTextAlignmentCenter;
        _contentlab.font = [UIFont systemFontOfSize:18];
        _contentlab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
    }
    return _contentlab;
}

-(void)setdata:(NSString *)contentstr
{
    self.contentlab.text = contentstr;
}


@end
