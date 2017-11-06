//
//  exerciseweeklyCell7.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell7.h"

@interface exerciseweeklyCell7()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;

@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@end

@implementation exerciseweeklyCell7

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.lab1];
        [self setuplayout];
        [self getdata];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.leftlab
    .sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, kScreenW/2+20)
    .heightIs(40);
    
    weakSelf.rightlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, kScreenW/2+20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .heightIs(40)
    .topEqualToView(weakSelf.leftlab);
    
    weakSelf.lab0
    .sd_layout
    .leftEqualToView(weakSelf.leftlab)
    .rightEqualToView(weakSelf.leftlab)
    .heightIs(20)
    .topSpaceToView(weakSelf.leftlab, 20);
    
    weakSelf.lab1
    .sd_layout
    .leftEqualToView(weakSelf.rightlab)
    .rightEqualToView(weakSelf.rightlab)
    .heightIs(20)
    .topSpaceToView(weakSelf.rightlab, 20);
    
    [self setupAutoHeightWithBottomView: weakSelf.lab0 bottomMargin:20];
}


#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textAlignment = NSTextAlignmentCenter;
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentCenter;
    }
    return _rightlab;
}


-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.textAlignment = NSTextAlignmentCenter;
        _lab0.font = [UIFont systemFontOfSize:15];
        _lab0.textColor = [UIColor colorWithHexString:@"323232"];
        _lab0.text = @"上周练习";
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.textAlignment = NSTextAlignmentCenter;
        _lab1.font = [UIFont systemFontOfSize:15];
        _lab1.textColor = [UIColor colorWithHexString:@"323232"];
        _lab1.text = @"上周平均练习";
    }
    return _lab1;
}




-(void)getdata
{
    NSString *leftstr = @"138题";
    NSString *rightstr = @"158题";
    
    NSMutableAttributedString *attrleftstr = [[NSMutableAttributedString alloc] initWithString:leftstr];
    [attrleftstr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, leftstr.length-1)];
    [attrleftstr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(leftstr.length-1, 1)];
    [attrleftstr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"08D2B2"]
                    range:NSMakeRange(0, leftstr.length-1)];
    [attrleftstr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"646464"]
                        range:NSMakeRange(leftstr.length-1, 1)];
    self.leftlab.attributedText = attrleftstr;
    
    
    NSMutableAttributedString *attrrightstr = [[NSMutableAttributedString alloc] initWithString:rightstr];
    [attrrightstr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:30.0f]
                        range:NSMakeRange(0, rightstr.length-1)];
    [attrrightstr addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13.0f]
                        range:NSMakeRange(rightstr.length-1, 1)];
    [attrrightstr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"08D2B2"]
                        range:NSMakeRange(0, rightstr.length-1)];
    [attrrightstr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"646464"]
                        range:NSMakeRange(rightstr.length-1, 1)];
    self.rightlab.attributedText = attrrightstr;
}


@end
