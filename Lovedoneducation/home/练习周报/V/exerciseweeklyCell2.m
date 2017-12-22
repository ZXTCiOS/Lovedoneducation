//
//  exerciseweeklyCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell2.h"
#import "YZLineChartView.h"
#import "YZLineChartModel.h"

@interface exerciseweeklyCell2()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) YZLineChartView *lineChartView;
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *lefttextlab;
@property (nonatomic,strong) UILabel *righttextlab;
@property (nonatomic,strong) NSMutableArray *weeklist;

@end

@implementation exerciseweeklyCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
        [self.contentView addSubview:self.lineChartView];
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.lefttextlab];
        [self.contentView addSubview:self.righttextlab];

        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(70);
    }];
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.bgview).with.offset(30);
    }];
    [weakSelf.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf.lab0);
        make.width.mas_offset(40);
    }];
    [weakSelf.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lab1).with.offset(5);
        make.width.mas_offset(5);
        make.height.mas_offset(5);
        make.right.equalTo(weakSelf.lab1.mas_left).with.offset(5);
    }];
    [weakSelf.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.top.equalTo(weakSelf.bgview.mas_bottom).with.offset(20);
        make.height.mas_offset(320);
    }];
    
    [weakSelf.lefttextlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-kScreenW/2-20);
        make.top.equalTo(weakSelf.lineChartView.mas_bottom).with.offset(10);
    }];
    [weakSelf.righttextlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(kScreenW/2+20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.top.equalTo(weakSelf.lefttextlab);
    }];
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lefttextlab);
        make.right.equalTo(weakSelf.lefttextlab);
        make.top.equalTo(weakSelf.lefttextlab.mas_bottom).with.offset(10);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.righttextlab);
        make.left.equalTo(weakSelf.righttextlab);
        make.top.equalTo(weakSelf.leftlab);
    }];
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
        _lab0.text = @"预测分趋势";
        _lab0.textColor = [UIColor colorWithHexString:@"323232"];
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
        _lab1.text = @"我的";
        _lab1.textAlignment = NSTextAlignmentRight;
        _lab1.font = [UIFont systemFontOfSize:13];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _lab2;
}

-(UILabel *)lefttextlab
{
    if(!_lefttextlab)
    {
        _lefttextlab = [[UILabel alloc] init];
        _lefttextlab.font = [UIFont systemFontOfSize:30];
        _lefttextlab.textAlignment = NSTextAlignmentCenter;
//        _lefttextlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _lefttextlab;
}

-(UILabel *)righttextlab
{
    if(!_righttextlab)
    {
        _righttextlab = [[UILabel alloc] init];
        _righttextlab.textColor = [UIColor colorWithHexString:@"FF9B19"];
        _righttextlab.textAlignment = NSTextAlignmentCenter;
       
        _righttextlab.font = [UIFont systemFontOfSize:30];
    }
    return _righttextlab;
}

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textColor = [UIColor colorWithHexString:@"646464"];
        _leftlab.text = @"本周排名变化";
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.font = [UIFont systemFontOfSize:15];
    }
    return _leftlab;
}


-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textColor = [UIColor colorWithHexString:@"646464"];
        _rightlab.text = @"国考排名";
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.font = [UIFont systemFontOfSize:15];
    }
    return _rightlab;
}


#pragma mark - private
- (void) redrawLineChart {
    YZLineChartModel *lineChart1 = [[YZLineChartModel alloc] init];
    //lineChart1.data = @[@10, @20,@30,@40,@50,@60,@70];
    lineChart1.data = self.weeklist;
    lineChart1.lineColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.lineChartView reDrawLineChartWithDimensionData:@[@"周一", @"周二", @"周三",@"周四",@"周五",@"周六",@"周日"] chartData: @[lineChart1]];
 
}

#pragma mark - get/set method
- (UIView *)lineChartView
{
    if (_lineChartView == nil) {
        _lineChartView = [[YZLineChartView alloc] initWithFrame:CGRectZero];
        _lineChartView.axisColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _lineChartView.marginInset = UIEdgeInsetsMake(20.f, 30.f, 40.f, 30.f);
        _lineChartView.gridStep = 4;
        _lineChartView.drawsDataPoints = YES;
        _lineChartView.backgroundColor = [UIColor whiteColor];
    }
    return _lineChartView;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.lineChartView.frame = self.contentView.bounds;
    [self redrawLineChart];
}

-(void)setdata:(NSDictionary *)dic
{
    self.weeklist = [NSMutableArray array];
    NSArray *arr = [dic objectForKey:@"weeklist"];
    if (arr.count!=0) {
        self.weeklist = [dic objectForKey:@"weeklist"];
        [self redrawLineChart];
    }
    NSString *rankingup = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rankingup"]];
    NSString *str1 = @"名";
    NSString *str = [NSString stringWithFormat:@"%@%@",rankingup,str1];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"08D2B2"]
                    range:NSMakeRange(0, rankingup.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(rankingup.length, str1.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, rankingup.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:13.0f]
                    range:NSMakeRange(rankingup.length, str1.length)];
    self.lefttextlab.attributedText = attrStr;
    
    NSString *ranking = @"";
    NSString *alluser = @"";
    if (![strisNull isNullToString:[dic objectForKey:@"ranking"]]) {
         ranking = [dic objectForKey:@"ranking"];
    }
    else
    {
        ranking = @"0";
    }
    if (![strisNull isNullToString:[dic objectForKey:@"alluser"]]) {
        alluser = [dic objectForKey:@"alluser"];
    }
    else
    {
        alluser = @"0";
    }
    NSString *str2 = [NSString stringWithFormat:@"%@%@",ranking,@"/"];
    NSString *newstr = [NSString stringWithFormat:@"%@%@",str2,alluser];
    NSMutableAttributedString *newattrStr = [[NSMutableAttributedString alloc] initWithString:newstr];
    [newattrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"08D2B2"]
                    range:NSMakeRange(0, str2.length)];
    [newattrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str2.length, alluser.length)];
    [newattrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, str2.length)];
    [newattrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:13.0f]
                    range:NSMakeRange(str2.length, alluser.length)];
    self.righttextlab.attributedText = newattrStr;
}

@end
