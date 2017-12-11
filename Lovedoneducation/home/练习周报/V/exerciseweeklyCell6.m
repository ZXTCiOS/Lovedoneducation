//
//  exerciseweeklyCell6.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell6.h"
#import "BarChat.h"

@interface exerciseweeklyCell6()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) BarChat *chartView;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UIView *colorview;
@end

@implementation exerciseweeklyCell6

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.colorview];
        [self.contentView addSubview:self.chartView];
        [self getdata];
        [self setuplayout];
    }
    return self;
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    weakSelf.bgview
    .sd_layout
    .leftEqualToView(weakSelf.contentView)
    .rightEqualToView(weakSelf.contentView)
    .heightIs(70)
    .topEqualToView(weakSelf.contentView);
    
    weakSelf.lab0.sd_layout
    .leftSpaceToView(weakSelf.contentView, 30)
    .topSpaceToView(weakSelf.contentView, 20)
    .widthIs(140)
    .heightIs(20);
    
    weakSelf.lab1
    .sd_layout
    .topEqualToView(weakSelf.lab0)
    .rightSpaceToView(weakSelf.contentView, 20)
    .widthIs(40)
    .heightIs(18);
    
    weakSelf.colorview
    .sd_layout
    .topSpaceToView(weakSelf.lab1, -10)
    .rightSpaceToView(weakSelf.lab1, 10)
    .widthIs(6)
    .heightIs(6);
    
    weakSelf.chartView
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 30)
    .rightSpaceToView(weakSelf.contentView, 30)
    .topSpaceToView(weakSelf.bgview, 20)
    .heightIs(200);
    
    [self setupAutoHeightWithBottomView: self.chartView bottomMargin:0];
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _bgview;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.font = [UIFont systemFontOfSize:17];
        _lab0.textColor = [UIColor colorWithHexString:@"323232"];
        _lab0.text = @"练习情况";
    }
    return _lab0;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.textAlignment = NSTextAlignmentRight;
        _lab1.text = @"上周";
        _lab1.font = [UIFont systemFontOfSize:13];
        _lab1.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _lab1;
}

-(UIView *)colorview
{
    if(!_colorview)
    {
        _colorview = [[UIView alloc] init];
        _colorview.backgroundColor = [UIColor colorWithHexString:@"FF9B19"];
    }
    return _colorview ;
}




-(BarChat *)chartView
{
    if(!_chartView)
    {
        _chartView = [[BarChat alloc] init];
        
    }
    return _chartView;
}

-(void)getdata
{
    _chartView.xValues = @[@"申论",@"测评",@"3",@"4",@"5",@"6",@"7"];
    
    _chartView.yValues = @[@1,@2,@4,@5,@7,@8,@10];
}

-(void)setdata:(NSDictionary *)dic
{
    
}
@end
