//
//  chooseView.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chooseView.h"

@interface chooseView()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UIView *topview;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UIView *leftline;
@property (nonatomic,strong) UIView *rightline;
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;

@end

@implementation chooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.bgview];
        [self addSubview:self.topview];
        [self addSubview:self.typelab];
        [self addSubview:self.leftline];
        [self addSubview:self.rightline];
        [self addSubview:self.leftlab];
        [self addSubview:self.rightlab];
        [self addSubview:self.leftimg];
        [self addSubview:self.rightimg];
        [self addSubview:self.clonebtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.height.mas_offset(200);
        
    }];
    [weakSelf.leftline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(55);
        make.top.equalTo(weakSelf).with.offset(28);
        make.height.mas_offset(1);
        make.width.mas_offset(25);
    }];
    [weakSelf.rightline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-55);
        make.top.equalTo(weakSelf).with.offset(28);
        make.height.mas_offset(1);
        make.width.mas_offset(25);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20);
        make.left.equalTo(weakSelf.leftline.mas_right);
        make.right.equalTo(weakSelf.rightline.mas_left);
    }];
    [weakSelf.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(56);
        make.top.equalTo(weakSelf).with.offset(78);
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];
    [weakSelf.rightimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-56);
        make.top.equalTo(weakSelf).with.offset(78);
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftimg.mas_left).with.offset(-20);
        make.right.equalTo(weakSelf.leftimg.mas_right).with.offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(weakSelf.leftimg.mas_bottom).with.offset(20);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.rightimg.mas_left).with.offset(-20);
        make.right.equalTo(weakSelf.rightimg.mas_right).with.offset(20);
        make.height.mas_offset(20);
        make.top.equalTo(weakSelf.leftlab);
    }];
    [weakSelf.clonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.topview.mas_bottom).with.offset(40);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        
    }
    return _bgview;
}


-(UIView *)topview
{
    if(!_topview)
    {
        _topview = [[UIView alloc] init];
        _topview.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _topview;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textAlignment = NSTextAlignmentCenter;
        _typelab.text = @"选择支付方式";
        _typelab.font = [UIFont systemFontOfSize:18];
        _typelab.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _typelab;
}

-(UIView *)leftline
{
    if(!_leftline)
    {
        _leftline = [[UIView alloc] init];
        _leftline.backgroundColor = [UIColor colorWithHexString:@"BDBDBD"];
    }
    return _leftline;
}

-(UIView *)rightline
{
    if(!_rightline)
    {
        _rightline = [[UIView alloc] init];
        _rightline.backgroundColor = [UIColor colorWithHexString:@"BDBDBD"];
    }
    return _rightline;
}

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.text = @"微信支付";
        _leftlab.textColor = [UIColor colorWithHexString:@"646464"];
        _leftlab.font = [UIFont systemFontOfSize:14];
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.text = @"支付宝支付";
        _rightlab.textColor = [UIColor colorWithHexString:@"646464"];
        _rightlab.font = [UIFont systemFontOfSize:14];
    }
    return _rightlab;
}

-(UIButton *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIButton alloc] init];
        //leftimg.image = [UIImage imageNamed:@"wechat_icon"];
        [_leftimg setImage:[UIImage imageNamed:@"wechat_icon"] forState:normal];
    }
    return _leftimg;
}

-(UIButton *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIButton alloc] init];
        //_rightimg.image = [UIImage imageNamed:@"zhifubao_icon"];
        [_rightimg setImage:[UIImage imageNamed:@"zhifubao_icon"] forState:normal];
    }
    return _rightimg;
}


-(UIButton *)clonebtn
{
    if(!_clonebtn)
    {
        _clonebtn = [[UIButton alloc] init];
        [_clonebtn setImage:[UIImage imageNamed:@"close_icon"] forState:normal];
    }
    return _clonebtn;
}






@end
