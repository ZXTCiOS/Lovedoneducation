//
//  LoginVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *passwordText;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) UIButton *qqBtn;
@property (nonatomic,strong) UIButton *weixinBtn;
@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIView *line0;
@property (nonatomic,strong) UIView *line1;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.weixinBtn];
    [self.view addSubview:self.img0];
    [self.view addSubview:self.img1];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    [self layout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)layout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(155);
        make.height.mas_offset(60);
    }];
    [weakSelf.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(85*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(41);
        make.height.mas_offset(30);
    }];
    [weakSelf.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.phoneText.mas_bottom).with.offset(25*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(41);
        make.height.mas_offset(30);
    }];
    
}

#pragma mark - getters

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"logo_png"];
    }
    return _logoImg;
}


-(UITextField *)phoneText
{
    if(!_phoneText)
    {
        _phoneText = [[UITextField alloc] init];
        _phoneText.delegate = self;
        _phoneText.placeholder = @"请输入手机号";

    }
    return _phoneText;
}

-(UITextField *)passwordText
{
    if(!_passwordText)
    {
        _passwordText = [[UITextField alloc] init];
        _passwordText.delegate = self;
        _passwordText.placeholder = @"请输入密码";

    }
    return _passwordText;
}

-(UIButton *)forgetBtn
{
    if(!_forgetBtn)
    {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码" forState:normal];
        [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"FF9B19"] forState:normal];
    }
    return _forgetBtn;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitBtn setTitle:@"登录" forState:normal];
    }
    return _submitBtn;
}

-(UIButton *)qqBtn
{
    if(!_qqBtn)
    {
        _qqBtn = [[UIButton alloc] init];
        [_qqBtn setImage:[UIImage imageNamed:@"QQ_png"] forState:normal];
    }
    return _qqBtn;
}

-(UIButton *)weixinBtn
{
    if(!_weixinBtn)
    {
        _weixinBtn = [[UIButton alloc] init];
        [_weixinBtn setImage:[UIImage imageNamed:@"weixin_png"] forState:normal];
    }
    return _weixinBtn;
}


-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.image = [UIImage imageNamed:@"telephone_icon"];
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.image = [UIImage imageNamed:@"mima_icon"];
    }
    return _img1;
}

-(UIView *)line0
{
    if(!_line0)
    {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    }
    return _line0;
}

-(UIView *)line1
{
    if(!_line1)
    {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    }
    return _line1;
}





#pragma mark - 实现方法


@end
