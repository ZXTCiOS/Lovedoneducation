//
//  datareportCell4.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell4.h"
#import "RMDashLineView.h"

@interface datareportCell4()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UIImageView *rightpoint;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) RMDashLineView *line0;
@property (nonatomic,strong) RMDashLineView *line1;
@property (nonatomic,strong) RMDashLineView *line2;
@property (nonatomic,strong) RMDashLineView *line3;
@property (nonatomic,strong) RMDashLineView *line4;
@property (nonatomic,strong) RMDashLineView *line5;

@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@property (nonatomic,strong) UILabel *lab5;

@property (nonatomic,strong) UILabel *textlab0;
@property (nonatomic,strong) UILabel *textlab1;
@property (nonatomic,strong) UILabel *textlab2;

@property (nonatomic,strong) UILabel *datalab0;
@property (nonatomic,strong) UILabel *datalab1;
@property (nonatomic,strong) UILabel *datalab2;
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
        [self.contentView addSubview:self.lab0];
        [self.contentView addSubview:self.lab1];
        [self.contentView addSubview:self.lab2];
        [self.contentView addSubview:self.lab3];
        [self.contentView addSubview:self.lab4];
        [self.contentView addSubview:self.lab5];
        [self.contentView addSubview:self.line0];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.line2];
        [self.contentView addSubview:self.line3];
        [self.contentView addSubview:self.line4];
        [self.contentView addSubview:self.line5];
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
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(73);
    }];
    [weakSelf.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0.mas_right).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab0.mas_bottom).with.offset(3);
    }];
    [weakSelf.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0);
        make.top.equalTo(weakSelf.lab0.mas_bottom).with.offset(30);
    }];
    [weakSelf.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab1.mas_bottom).with.offset(3);
    }];
    [weakSelf.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0);
        make.top.equalTo(weakSelf.lab1.mas_bottom).with.offset(30);
    }];
    [weakSelf.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab2.mas_bottom).with.offset(3);
    }];
    [weakSelf.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0);
        make.top.equalTo(weakSelf.lab2.mas_bottom).with.offset(30);
    }];
    [weakSelf.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab3.mas_bottom).with.offset(3);
    }];
    [weakSelf.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0);
        make.top.equalTo(weakSelf.lab3.mas_bottom).with.offset(30);
    }];
    [weakSelf.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab4.mas_bottom).with.offset(3);
    }];
    [weakSelf.lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lab0);
        make.top.equalTo(weakSelf.lab4.mas_bottom).with.offset(30);
    }];
    [weakSelf.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.line0);
        make.right.equalTo(weakSelf.line0);
        make.height.mas_offset(1);
        make.top.equalTo(weakSelf.lab5.mas_bottom).with.offset(3);
    }];
    [weakSelf.textlab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(80);
        make.top.equalTo(weakSelf.line5).mas_offset(20);
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
    }];
    [weakSelf.datalab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab0);
        make.right.equalTo(weakSelf.textlab0);
        make.top.equalTo(weakSelf.datalab1);
    }];
    [weakSelf.datalab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab2);
        make.right.equalTo(weakSelf.textlab2);
        make.top.equalTo(weakSelf.datalab1);
    }];
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


-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.text = @"100";
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
        _lab1.text = @"80";
        _lab1.textColor = [UIColor colorWithHexString:@"323232"];
        _lab1.font = [UIFont systemFontOfSize:15];
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.text = @"60";
        _lab2.textColor = [UIColor colorWithHexString:@"323232"];
        _lab2.font = [UIFont systemFontOfSize:15];
    }
    return _lab2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.text = @"40";
        _lab3.textColor = [UIColor colorWithHexString:@"323232"];
        _lab3.font = [UIFont systemFontOfSize:15];
    }
    return _lab3;
}


-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.text = @"20";
        _lab4.textColor = [UIColor colorWithHexString:@"323232"];
        _lab4.font = [UIFont systemFontOfSize:15];
    }
    return _lab4;
}

-(UILabel *)lab5
{
    if(!_lab5)
    {
        _lab5 = [[UILabel alloc] init];
        _lab5.text = @"0";
        _lab5.textColor = [UIColor colorWithHexString:@"323232"];
        _lab5.font = [UIFont systemFontOfSize:15];
    }
    return _lab5;
}



-(RMDashLineView *)line0
{
    if(!_line0)
    {
        _line0 = [[RMDashLineView alloc] init];
        
    }
    return _line0;
}

-(RMDashLineView *)line1
{
    if(!_line1)
    {
        _line1 = [[RMDashLineView alloc] init];
        
    }
    return _line1;
}

-(RMDashLineView *)line2
{
    if(!_line2)
    {
        _line2 = [[RMDashLineView alloc] init];
        
    }
    return _line2;
}


-(RMDashLineView *)line3
{
    if(!_line3)
    {
        _line3 = [[RMDashLineView alloc] init];
        
    }
    return _line3;
}

-(RMDashLineView *)line4
{
    if(!_line4)
    {
        _line4 = [[RMDashLineView alloc] init];
        
    }
    return _line4;
}

-(RMDashLineView *)line5
{
    if(!_line5)
    {
        _line5 = [[RMDashLineView alloc] init];
        
    }
    return _line5;
}


-(UILabel *)textlab0
{
    if(!_textlab0)
    {
        _textlab0 = [[UILabel alloc] init];
        _textlab0.text = @"6天";
        _textlab0.font = [UIFont systemFontOfSize:30];
        _textlab0.textColor = [UIColor colorWithHexString:@"08D2B2"];
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




















@end
