//
//  essaytableCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essaytableCell2.h"

@interface essaytableCell2()
@property (nonatomic,strong) UIButton *submitbtn;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *lab;
@end

@implementation essaytableCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.submitbtn];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.lab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    weakSelf.submitbtn
    .sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .heightIs(40)
    .centerXEqualToView(weakSelf.contentView)
    .widthIs(200*WIDTH_SCALE);
    
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.submitbtn, 20)
    .autoHeightRatio(0);
 
    weakSelf.lab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentlab, 20)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView: weakSelf.lab bottomMargin:20];
}

#pragma mark - getters


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textAlignment = NSTextAlignmentCenter;
    }
    return _contentlab;
}

-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.text = @"#请耐心等待，我们会在24小时之内给您答案#";
        _lab.font = [UIFont systemFontOfSize:12];
        _lab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _lab;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitbtn setTitle:@"交卷购买" forState:normal];
        [_submitbtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _submitbtn;
}

#pragma mark - 数据源

-(void)setnumberstr:(NSString *)numser andpricestr:(NSString *)pricestr
{
    numser = @"1";
    pricestr = @"20";
    NSString *str1 = @"共计";
    NSString *str2 = numser;
    NSString *str3 = @"道题目，总计 ¥";
    NSString *str4 = pricestr;
    NSString *str5 = @"元";
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",str1,str2,str3,str4,str5];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(0, str1.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(str1.length, str2.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str1.length + str2.length, str3.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(str1.length + str2.length+str3.length, str4.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str1.length + str2.length+str3.length+str4.length, str5.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(0, str1.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(str1.length, str2.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(str1.length + str2.length, str3.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(str1.length + str2.length+str3.length, str4.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(str1.length + str2.length+str3.length+str4.length, str5.length)];
    self.contentlab.attributedText = attrStr;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    
}


@end
