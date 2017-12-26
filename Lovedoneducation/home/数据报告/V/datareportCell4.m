//
//  datareportCell4.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell4.h"
#import "YZLineChartView.h"
#import "YZLineChartModel.h"

@interface datareportCell4()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UIImageView *rightpoint;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) YZLineChartView *lineChartView;
@property (nonatomic,strong) UILabel *textlab0;
@property (nonatomic,strong) UILabel *textlab1;
@property (nonatomic,strong) UILabel *textlab2;

@property (nonatomic,strong) UILabel *datalab0;
@property (nonatomic,strong) UILabel *datalab1;
@property (nonatomic,strong) UILabel *datalab2;

@property (nonatomic,strong) NSMutableArray *upscorearray;
@property (nonatomic,strong) NSMutableArray *strarr;
@end

@implementation datareportCell4

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightpoint];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.lineChartView];
        [self.contentView addSubview:self.textlab0];
        [self.contentView addSubview:self.textlab1];
        [self.contentView addSubview:self.textlab2];
        [self.contentView addSubview:self.datalab0];
        [self.contentView addSubview:self.datalab1];
        [self.contentView addSubview:self.datalab2];
        
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(20);
        
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(25);
        make.right.equalTo(weakSelf).with.offset(-14);
    }];
    [weakSelf.rightpoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightlab.mas_left).with.offset(-16);
        make.top.equalTo(weakSelf.rightlab).with.offset(5);
        make.height.mas_offset(5);
        make.width.mas_offset(5);
    }];
    [weakSelf.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.top.equalTo(weakSelf.rightpoint.mas_bottom).with.offset(50);
        make.height.mas_offset(320);
    }];
    
    [weakSelf.textlab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(80);
        make.top.equalTo(weakSelf.lineChartView.mas_bottom).mas_offset(20);
    }];
    
    [weakSelf.textlab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf.textlab1.mas_left).with.offset(-20);
        make.top.equalTo(weakSelf.textlab1);
    }];
    [weakSelf.textlab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab1.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.textlab1);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
    [weakSelf.datalab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(80);
        make.top.equalTo(weakSelf.textlab1.mas_bottom).with.offset(20);
        make.height.mas_offset(20);
    }];
    [weakSelf.datalab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab0);
        make.right.equalTo(weakSelf.textlab0);
        make.top.equalTo(weakSelf.datalab1);
        make.height.mas_offset(20);
    }];
    [weakSelf.datalab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab2);
        make.right.equalTo(weakSelf.textlab2);
        make.top.equalTo(weakSelf.datalab1);
        make.height.mas_offset(20);
    }];

}

#pragma mark - private
- (void) redrawLineChart {
    YZLineChartModel *lineChart1 = [[YZLineChartModel alloc] init];
    //lineChart1.data = @[@10, @20,@30,@40,@50,@60,@70];
    lineChart1.data = self.upscorearray;
    lineChart1.lineColor = [UIColor colorWithHexString:@"08D2B2"];
       [self.lineChartView reDrawLineChartWithDimensionData:@[@"周一", @"周二", @"周三",@"周四",@"周五",@"周六",@"周日"] chartData: @[lineChart1]];
   // [self.lineChartView reDrawLineChartWithDimensionData:self.strarr  chartData: @[lineChart1]];
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
#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.text = @"预测分趋势";
        _leftlab.font = [UIFont systemFontOfSize:17];
    }
    return _leftlab;
}

-(UIImageView *)rightpoint
{
    if(!_rightpoint)
    {
        _rightpoint = [[UIImageView alloc] init];
        _rightpoint.backgroundColor = [UIColor colorWithHexString:@"FF9B19"];
    }
    return _rightpoint;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textColor = [UIColor colorWithHexString:@"646464"];
        _rightlab.textAlignment = NSTextAlignmentRight;
        _rightlab.font = [UIFont systemFontOfSize:13];
        _rightlab.text = @"我的";
    }
    return _rightlab;
}

-(UILabel *)textlab0
{
    if(!_textlab0)
    {
        _textlab0 = [[UILabel alloc] init];
        _textlab0.textAlignment = NSTextAlignmentCenter;
    }
    return _textlab0;
}

-(UILabel *)textlab1
{
    if(!_textlab1)
    {
        _textlab1 = [[UILabel alloc] init];
        _textlab1.font = [UIFont systemFontOfSize:30];
        _textlab1.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _textlab1.text = @"7分钟";
        _textlab1.textAlignment = NSTextAlignmentCenter;
    }
    return _textlab1;
}

-(UILabel *)textlab2
{
    if(!_textlab2)
    {
        _textlab2 = [[UILabel alloc] init];
        _textlab2.font = [UIFont systemFontOfSize:30];
        _textlab2.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _textlab2.text = @"10次";
        _textlab2.textAlignment = NSTextAlignmentCenter;
    }
    return _textlab2;
}

-(UILabel *)datalab0
{
    if(!_datalab0)
    {
        _datalab0 = [[UILabel alloc] init];
        _datalab0.textAlignment = NSTextAlignmentCenter;
        _datalab0.text = @"练习天数";
        _datalab0.font = [UIFont systemFontOfSize:13];
        _datalab0.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _datalab0;
}

-(UILabel *)datalab1
{
    if(!_datalab1)
    {
        _datalab1 = [[UILabel alloc] init];
        _datalab1.textAlignment = NSTextAlignmentCenter;
        _datalab1.text = @"答题时长";
        _datalab1.font = [UIFont systemFontOfSize:13];
        _datalab1.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _datalab1;
}

-(UILabel *)datalab2
{
    if(!_datalab2)
    {
        _datalab2 = [[UILabel alloc] init];
        _datalab2.textAlignment = NSTextAlignmentCenter;
        _datalab2.text = @"创建练习";
        _datalab2.font = [UIFont systemFontOfSize:13];
        _datalab2.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _datalab2;
}

-(void)setdata:(NSDictionary *)dic
{
    self.strarr = [NSMutableArray array];
    self.upscorearray = [NSMutableArray array];
    NSArray *arr = [dic objectForKey:@"userList"];
    for (int i = 0; i<arr.count ; i++) {
        NSDictionary *dic = [arr objectAtIndex:i];
        NSString *upscore = [dic objectForKey:@"upscore"];
        NSInteger numu = [upscore integerValue];
        NSNumber *num = @(numu);
        [self.upscorearray addObject:num];
        [self.strarr addObject:@""];
    }
    [self redrawLineChart];
    
    NSString *practicedays = [dic objectForKey:@"practicedays"];
    NSString *str1 = @"天";
    NSString *str = [NSString stringWithFormat:@"%@%@",practicedays,str1];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"08D2B2"]
                    range:NSMakeRange(0, practicedays.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(practicedays.length, str1.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, practicedays.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:13.0f]
                    range:NSMakeRange(practicedays.length, str1.length)];
    self.textlab0.attributedText = attrStr;
    
    NSString *minute = @"";
    if ([[dic objectForKey:@"minute"]isEqualToString:@"zxtc"]) {
        minute = @"0";
    }
    else
    {
        minute = [dic objectForKey:@"minute"];
    }
    NSString *str2 = @"分钟";
    NSString *newstr = [NSString stringWithFormat:@"%@%@",minute,str2];
    NSMutableAttributedString *newattrStr = [[NSMutableAttributedString alloc] initWithString:newstr];
    [newattrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"08D2B2"]
                    range:NSMakeRange(0, minute.length)];
    [newattrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(minute.length, str2.length)];
    [newattrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, minute.length)];
    [newattrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:13.0f]
                    range:NSMakeRange(minute.length, str2.length)];
    self.textlab1.attributedText = newattrStr;
    
    NSString *practicenum = [dic objectForKey:@"practicenum"];
    NSString *str3 = @"次";
    NSString *neewstr = [NSString stringWithFormat:@"%@%@",practicenum,str3];
    NSMutableAttributedString *neewattrStr = [[NSMutableAttributedString alloc] initWithString:neewstr];
    [neewattrStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"08D2B2"]
                       range:NSMakeRange(0, practicenum.length)];
    [neewattrStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"646464"]
                       range:NSMakeRange(practicenum.length, str3.length)];
    [neewattrStr addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:30.0f]
                       range:NSMakeRange(0, practicenum.length)];
    [neewattrStr addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:13.0f]
                       range:NSMakeRange(practicenum.length, str3.length)];
    self.textlab2.attributedText = neewattrStr;
    
}

@end
