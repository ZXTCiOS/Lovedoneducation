//
//  realpartanalysisCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisCell2.h"

@interface realpartanalysisCell2()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *accuracylab;
@property (nonatomic,strong) UILabel *errorlab;
@end

@implementation realpartanalysisCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.leftView];
        [self.contentView addSubview:self.rightView];
        [self.contentView addSubview:self.contentlab];
        [self setclick];
    }
    return self;
}

-(void)setclick
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab.isAttributedContent = YES;
    weakSelf.typelab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.contentView, 40)
    .widthIs(120)
    .heightIs(25);
    
    weakSelf.leftView
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.typelab, 30)
    .heightIs(60)
    .widthIs(kScreenW/2-28);
    
    weakSelf.rightView
    .sd_layout
    .rightSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.typelab, 30)
    .heightIs(60)
    .widthIs(kScreenW/2-28);
    
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 14)
    .rightSpaceToView(weakSelf.contentView, 14)
    .topSpaceToView(weakSelf.leftView, 30)
    .autoHeightRatio(0);
    

    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:40];
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"解析";
        _typelab.textColor = [UIColor colorWithHexString:@"323232"];
        _typelab.font = [UIFont systemFontOfSize:18];
    }
    return _typelab;
}

-(UIView *)leftView
{
    if(!_leftView)
    {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_leftView addSubview:self.leftlab];
        [_leftView addSubview:self.accuracylab];
    }
    return _leftView;
}

-(UIView *)rightView
{
    if(!_rightView)
    {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_rightView addSubview:self.rightlab];
        [_rightView addSubview:self.errorlab];
    }
    return _rightView;
}


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.frame = CGRectMake(0, 35, kScreenW/2-28, 16);
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.text = @"全站正确率";
        _leftlab.font = [UIFont systemFontOfSize:13];
        _leftlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.frame = CGRectMake(0, 35, kScreenW/2-28, 16);
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.text = @"易错项";
        _rightlab.font = [UIFont systemFontOfSize:13];
        _rightlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _rightlab;
}

-(UILabel *)accuracylab
{
    if(!_accuracylab)
    {
        _accuracylab = [[UILabel alloc] init];
        _accuracylab.frame = CGRectMake(0, 10, kScreenW/2-28, 26);
        _accuracylab.textAlignment = NSTextAlignmentCenter;
        _accuracylab.text = @"73%";
        _accuracylab.font = [UIFont systemFontOfSize:24];
        _accuracylab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _accuracylab;
}

-(UILabel *)errorlab
{
    if(!_errorlab)
    {
        _errorlab = [[UILabel alloc] init];
        _errorlab.frame = CGRectMake(0, 10, kScreenW/2-28, 26);
        _errorlab.textAlignment = NSTextAlignmentCenter;
        _errorlab.text = @"C";
        _errorlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _errorlab.font = [UIFont systemFontOfSize:24];
    }
    return _errorlab;
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

-(void)setdata:(NSMutableArray *)conarr anderrorstr:(NSString *)errorstr andaccuracystr:(NSString *)accuracystr
{
    if ([errorstr isEqualToString:@"zxtc"]) {
        self.errorlab.text = @"";
    }
    else
    {
        self.errorlab.text = errorstr;
    }
    if ([accuracystr isEqualToString:@"zxtc"]) {
          self.accuracylab.text = [NSString stringWithFormat:@"%@%@",@"0",@"%"];
    }
    else
    {
          self.accuracylab.text = [NSString stringWithFormat:@"%@%@",accuracystr,@"%"];
    }
    
    NSMutableArray *arr0 = [NSMutableArray new];
    NSMutableArray *arr1 = [NSMutableArray new];
    
    if ([conarr isKindOfClass:[NSString class]]) {
        
    }
    else
    {
        for (int i = 0; i<conarr.count; i++) {
            arr0 = [conarr objectAtIndex:i];
            NSString *str = [arr0 componentsJoinedByString:@" "];
            [arr1 addObject:str];
        }
    }
    
    NSString *textStr = [arr1 componentsJoinedByString:@" "];
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    self.contentlab.attributedText = attributedString;
    
}

@end
