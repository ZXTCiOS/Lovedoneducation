//
//  smartCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell0.h"

@interface smartCell0()
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@property (nonatomic,strong) UILabel *lab5;
@property (nonatomic,strong) UILabel *lab6;
@property (nonatomic,strong) UILabel *lab7;
@property (nonatomic,strong) UILabel *lab8;
@property (nonatomic,strong) UILabel *lab9;
@end

@implementation smartCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
        [self.contentView addSubview:self.lab3];
        [self.contentView addSubview:self.lab4];
        [self.contentView addSubview:self.lab5];
        [self.contentView addSubview:self.lab6];
        [self.contentView addSubview:self.lab7];
        [self.contentView addSubview:self.lab8];
        [self.contentView addSubview:self.lab9];
        [self setuolayout];
    }
    return self;
}

-(void)setuolayout
{
    __weak typeof (self) weakSelf = self;

    weakSelf.lab0
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab1
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab0, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab2
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab1, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab3
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab2, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab4
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab3, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab5
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab4, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab6
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab5, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab7
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab6, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab8
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab7, 20)
    .autoHeightRatio(0);
    
    weakSelf.lab9
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.lab8, 20)
    .autoHeightRatio(0);
    
   // [self setupAutoHeightWithBottomView: weakSelf.lab5 bottomMargin:20];
    
}

#pragma mark - getters

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.textColor = [UIColor colorWithHexString:@"646464"];
        _lab0.font = [UIFont systemFontOfSize:15];
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.textColor = [UIColor colorWithHexString:@"646464"];
        _lab1.font = [UIFont systemFontOfSize:15];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = [UIColor colorWithHexString:@"646464"];
        _lab2.font = [UIFont systemFontOfSize:15];
    }
    return _lab2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.textColor = [UIColor colorWithHexString:@"646464"];
        _lab3.font = [UIFont systemFontOfSize:15];
    }
    return _lab3;
}

-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = [UIColor colorWithHexString:@"646464"];
        _lab4.font = [UIFont systemFontOfSize:15];
    }
    return _lab4;
}

-(UILabel *)lab5
{
    if(!_lab5)
    {
        _lab5 = [[UILabel alloc] init];
        _lab5.textColor = [UIColor colorWithHexString:@"646464"];
        _lab5.font = [UIFont systemFontOfSize:15];
    }
    return _lab5;
}

-(UILabel *)lab6
{
    if(!_lab6)
    {
        _lab6 = [[UILabel alloc] init];
        _lab6.textColor = [UIColor colorWithHexString:@"646464"];
        _lab6.font = [UIFont systemFontOfSize:15];
    }
    return _lab6;
}

-(UILabel *)lab7
{
    if(!_lab7)
    {
        _lab7 = [[UILabel alloc] init];
        _lab7.textColor = [UIColor colorWithHexString:@"646464"];
        _lab7.font = [UIFont systemFontOfSize:15];
    }
    return _lab7;
}

-(UILabel *)lab8
{
    if(!_lab8)
    {
        _lab8 = [[UILabel alloc] init];
        _lab8.textColor = [UIColor colorWithHexString:@"646464"];
        _lab8.font = [UIFont systemFontOfSize:15];
    }
    return _lab8;
}

-(UILabel *)lab9
{
    if(!_lab9)
    {
        _lab9 = [[UILabel alloc] init];
        _lab9.textColor = [UIColor colorWithHexString:@"646464"];
        _lab9.font = [UIFont systemFontOfSize:15];
    }
    return _lab9;
}

#pragma mark - 实现方法

-(void)setdata:(NSMutableArray *)conarr
{
    __weak typeof (self) weakSelf = self;
    if (conarr.count==1) {
        NSString *contstr = @"";
        NSArray *dataarr = [conarr objectAtIndex:0];
        contstr = [dataarr objectAtIndex:0];
        self.lab0.text = contstr;
        [self.lab1 setHidden:YES];
        [self.lab2 setHidden:YES];
        [self.lab3 setHidden:YES];
        [self.lab4 setHidden:YES];
        [self.lab5 setHidden:YES];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab0 bottomMargin:20];
    }
    if (conarr.count==2) {
        NSString *contstr = @"";
        NSArray *dataarr = [conarr objectAtIndex:0];
        contstr = [dataarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        self.lab0.text = contstr;
        self.lab1.text = [dataarr1 objectAtIndex:0];
        [self.lab2 setHidden:YES];
        [self.lab3 setHidden:YES];
        [self.lab4 setHidden:YES];
        [self.lab5 setHidden:YES];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab1 bottomMargin:20];
    }
    if (conarr.count==3) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        [self.lab3 setHidden:YES];
        [self.lab4 setHidden:YES];
        [self.lab5 setHidden:YES];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab2 bottomMargin:20];
    }
    if (conarr.count==4) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        [self.lab4 setHidden:YES];
        [self.lab5 setHidden:YES];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab3 bottomMargin:20];
    }
    if (conarr.count==5) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        
        [self.lab5 setHidden:YES];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab4 bottomMargin:20];
    }
    if (conarr.count==6) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        self.lab5.text = [dataarr5 objectAtIndex:0];
        [self.lab6 setHidden:YES];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab5 bottomMargin:20];
    }
    if (conarr.count==7) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        self.lab5.text = [dataarr5 objectAtIndex:0];
        self.lab6.text = [dataarr6 objectAtIndex:0];
        [self.lab7 setHidden:YES];
        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab6 bottomMargin:20];
    }
    if (conarr.count==8) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        self.lab5.text = [dataarr5 objectAtIndex:0];
        self.lab6.text = [dataarr6 objectAtIndex:0];
        self.lab7.text = [dataarr7 firstObject];

        [self.lab8 setHidden:YES];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab7 bottomMargin:20];
    }
    if (conarr.count==9) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
        NSArray *dataarr8 = [conarr objectAtIndex:8];
        
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        self.lab5.text = [dataarr5 objectAtIndex:0];
        self.lab6.text = [dataarr6 objectAtIndex:0];
        self.lab7.text = [dataarr7 firstObject];
        self.lab8.text = [dataarr8 firstObject];
        [self.lab9 setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.lab8 bottomMargin:20];
    }
    if (conarr.count==10) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
        NSArray *dataarr8 = [conarr objectAtIndex:8];
        NSArray *dataarr9 = [conarr objectAtIndex:9];
        self.lab0.text = [dataarr0 objectAtIndex:0];
        self.lab1.text = [dataarr1 objectAtIndex:0];
        self.lab2.text = [dataarr2 objectAtIndex:0];
        self.lab3.text = [dataarr3 objectAtIndex:0];
        self.lab4.text = [dataarr4 objectAtIndex:0];
        self.lab5.text = [dataarr5 objectAtIndex:0];
        self.lab6.text = [dataarr6 objectAtIndex:0];
        self.lab7.text = [dataarr7 firstObject];
        self.lab8.text = [dataarr8 firstObject];
        self.lab9.text = [dataarr9 firstObject];
        [self setupAutoHeightWithBottomView: weakSelf.lab9 bottomMargin:20];
    }
}

@end
