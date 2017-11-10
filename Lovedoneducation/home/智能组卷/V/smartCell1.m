//
//  smartCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell1.h"

@interface smartCell1()
@property (nonatomic,strong) UILabel *labA;
@property (nonatomic,strong) UILabel *labB;
@property (nonatomic,strong) UILabel *labC;
@property (nonatomic,strong) UILabel *labD;
@end

@implementation smartCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.labA];
        [self.contentView addSubview:self.labB];
        [self.contentView addSubview:self.labC];
        [self.contentView addSubview:self.labD];
        [self setuolayout];
    }
    return self;
}


-(void)setuolayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.labA
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    
    weakSelf.labB
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labA, 20)
    .autoHeightRatio(0);
    
    weakSelf.labC
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labB, 20)
    .autoHeightRatio(0);
    
    weakSelf.labD
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labC, 20)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView: weakSelf.labD bottomMargin:20];
}

#pragma mark - getters

-(UILabel *)labA
{
    if(!_labA)
    {
        _labA = [[UILabel alloc] init];
        _labA.textColor = [UIColor colorWithHexString:@"646464"];
        _labA.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickA)];
        [_labA addGestureRecognizer:labelTapGestureRecognizer];
        _labA.userInteractionEnabled = YES;
    }
    return _labA;
}

-(UILabel *)labB
{
    if(!_labB)
    {
        _labB = [[UILabel alloc] init];
        _labB.textColor = [UIColor colorWithHexString:@"646464"];
        _labB.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickB)];
        [_labB addGestureRecognizer:labelTapGestureRecognizer];
        _labB.userInteractionEnabled = YES;
    }
    return _labB;
}

-(UILabel *)labC
{
    if(!_labC)
    {
        _labC = [[UILabel alloc] init];
        _labC.textColor = [UIColor colorWithHexString:@"646464"];
        _labC.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickC)];
        [_labC addGestureRecognizer:labelTapGestureRecognizer];
        _labC.userInteractionEnabled = YES;
    }
    return _labC;
}

-(UILabel *)labD
{
    if(!_labD)
    {
        _labD = [[UILabel alloc] init];
        _labD.textColor = [UIColor colorWithHexString:@"646464"];
        _labD.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickD)];
        [_labD addGestureRecognizer:labelTapGestureRecognizer];
        _labD.userInteractionEnabled = YES;
    }
    return _labD;
}

-(void)setdata:(NSMutableArray *)answer
{
    if (answer.count==4) {
        NSArray *arr0 = [answer objectAtIndex:0];
        NSArray *arr1 = [answer objectAtIndex:1];
        NSArray *arr2 = [answer objectAtIndex:2];
        NSArray *arr3 = [answer objectAtIndex:3];
        
        NSString *answera = [arr0 componentsJoinedByString:@" "];
        NSString *answerb = [arr1 componentsJoinedByString:@" "];
        NSString *answerc = [arr2 componentsJoinedByString:@" "];
        NSString *answerd = [arr3 componentsJoinedByString:@" "];
        
        self.labA.text = [answera stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        self.labB.text = [answerb stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
        self.labC.text = [answerc stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
        self.labD.text = [answerd stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
    }
    if (answer.count==3) {
        
    }
    if (answer.count==2) {
        
    }
    if (answer.count==1) {
        
    }

}

#pragma mark - 实现点击方法

-(void)labelClickA
{
    self.labA.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickA:self];
}

-(void)labelClickB
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickB:self];
}

-(void)labelClickC
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickC:self];
}

-(void)labelClickD
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"FF9B19"];
    [self.delegate myTabVClickD:self];
}

@end
