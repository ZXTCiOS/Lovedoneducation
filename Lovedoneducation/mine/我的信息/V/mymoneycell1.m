//
//  mymoneycell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import "mymoneycell1.h"

@interface mymoneycell1()
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UIButton *btn0;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIButton *submitbtn;
@end

@implementation mymoneycell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.btn0];
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.submitbtn];
        [self layout];
    }
    return self;
}

-(void)layout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(15);
    }];
    [weakSelf.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(10);
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(80);
        make.height.mas_offset(46);
    }];
    [weakSelf.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(46);
        make.right.equalTo(weakSelf.btn1.mas_left).with.offset(-20);
    }];
    [weakSelf.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typelab.mas_bottom).with.offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(46);
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(20);
    }];
    
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(10);
        make.height.mas_offset(15);
    }];
    
    [weakSelf.submitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(10);
        make.height.mas_offset(36);
        make.left.equalTo(weakSelf).with.offset(50);
    }];
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"充值";
        _typelab.font = [UIFont systemFontOfSize:12];
    }
    return _typelab;
}


-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        _btn0.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        _btn0.layer.masksToBounds = YES;
        _btn0.layer.borderWidth = 1;
        _btn0.layer.borderColor = [UIColor colorWithHexString:@"08D2B2"].CGColor;
        [_btn0 setTitle:@"1" forState:normal];
        [_btn0 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
        [_btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        _btn1.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [_btn1 setTitle:@"12" forState:normal];
        [_btn1 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor colorWithHexString:@"08D2B2"].CGColor;
        [_btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        _btn2.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [_btn2 setTitle:@"30" forState:normal];
        [_btn2 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = [UIColor colorWithHexString:@"08D2B2"].CGColor;
        [_btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textAlignment = NSTextAlignmentCenter;
        _contentlab.font = [UIFont systemFontOfSize:12];
        _contentlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _contentlab;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        _submitbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitbtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        [_submitbtn setTitle:@"确认充值" forState:normal];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitbtn;
}

-(void)submitbtnclick
{
    [self.delegate submitVClick1:self];

}

#pragma mark - 实现方法

-(void)btn0click
{
    self.btn0.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.btn0 setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    
    self.btn1.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn1 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.btn2.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn2 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.contentlab.text = @"支付金额1:00";
    [self.delegate myTabVClick0:self];
}

-(void)btn1click
{
    
    self.btn0.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn0 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.btn1.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.btn1 setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    
    self.btn2.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn2 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.contentlab.text = @"支付金额12:00";
    [self.delegate myTabVClick1:self];
}

-(void)btn2click
{
    self.btn0.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn0 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.btn1.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.btn1 setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
    
    self.btn2.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.btn2 setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    
    self.contentlab.text = @"支付金额30:00";
    [self.delegate myTabVClick2:self];
}



@end
