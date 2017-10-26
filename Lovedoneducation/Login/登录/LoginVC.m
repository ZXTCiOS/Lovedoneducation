//
//  LoginVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LoginVC.h"
#import "changeVC0.h"
#import "forgetVC.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "ZTVendorManager.h"

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
@property (nonatomic,strong) ZTVendorPayManager *payManager;
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
    self.payManager = [[ZTVendorPayManager alloc]init];
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
    [weakSelf.img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(260*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(41*WIDTH_SCALE);
        make.width.mas_offset(16);
        make.height.mas_offset(18);
    }];
    [weakSelf.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(316*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(41*WIDTH_SCALE);
        make.width.mas_offset(16);
        make.height.mas_offset(18);
    }];
    
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(155);
        make.height.mas_offset(60);

    }];
    [weakSelf.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img0).with.offset(-4*HEIGHT_SCALE);
        make.height.mas_offset(30);
        make.right.equalTo(weakSelf.view).with.offset(-34.5*WIDTH_SCALE);
    }];
    [weakSelf.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img1).with.offset(-4*HEIGHT_SCALE);
        make.height.mas_offset(30);
        make.right.equalTo(weakSelf.view).with.offset(-34.5*WIDTH_SCALE);
    }];
    [weakSelf.line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phoneText);
        make.top.equalTo(weakSelf.phoneText.mas_bottom);
        make.right.equalTo(weakSelf.phoneText);
        make.height.mas_offset(1);
    }];
    [weakSelf.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.passwordText);
        make.top.equalTo(weakSelf.passwordText.mas_bottom);
        make.right.equalTo(weakSelf.passwordText);
        make.height.mas_offset(1);
    }];
    [weakSelf.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line1.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14);
        make.height.mas_offset(30);
        make.width.mas_offset(80);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.forgetBtn.mas_bottom).with.offset(30*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.view).with.offset(34.5);
        make.height.mas_offset(44);
    }];
    [weakSelf.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.submitBtn.mas_bottom).with.offset(40*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-34.5);
        make.width.mas_offset(44);
        make.height.mas_offset(44);
    }];
    [weakSelf.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.qqBtn);
        make.right.equalTo(weakSelf.qqBtn.mas_left).with.offset(-20);
        make.width.mas_offset(44);
        make.height.mas_offset(44);
    }];
}

#pragma mark - getters

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"logo_icon_dengluyemian"];
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
        _phoneText.keyboardType = UIKeyboardTypePhonePad;
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
        _passwordText.secureTextEntry = YES;
    }
    return _passwordText;
}

-(UIButton *)forgetBtn
{
    if(!_forgetBtn)
    {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码?" forState:normal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"FF9B19"] forState:normal];
        [_forgetBtn addTarget:self action:@selector(forgetbtnclick) forControlEvents:UIControlEventTouchUpInside];
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
        [_submitBtn addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(UIButton *)qqBtn
{
    if(!_qqBtn)
    {
        _qqBtn = [[UIButton alloc] init];
        [_qqBtn setImage:[UIImage imageNamed:@"qq_icon_dengluye"] forState:normal];
        [_qqBtn addTarget:self action:@selector(qqbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

-(UIButton *)weixinBtn
{
    if(!_weixinBtn)
    {
        _weixinBtn = [[UIButton alloc] init];
        [_weixinBtn setImage:[UIImage imageNamed:@"weixin_icon_dengluye"] forState:normal];
        [_weixinBtn addTarget:self action:@selector(weixinbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinBtn;
}


-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.image = [UIImage imageNamed:@"telephone_icon_dengluye"];
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.image = [UIImage imageNamed:@"mima_icon_dengluye"];
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

-(void)submitclick
{
    NSString *phone = @"";
    NSString *pwd = @"";
    if (self.phoneText.text.length==0) {
        phone = @"";
    }
    else
    {
        phone = self.phoneText.text;
    }
    if (self.passwordText.text.length==0) {
        pwd = @"";
    }
    else
    {
        pwd = self.passwordText.text;
    }
    NSString *password = [MD5Tool MD5ForUpper32Bate:pwd];
    NSDictionary *dic = @{@"uname":phone,@"upwd":password};
    [DNNetworking postWithURLString:POST_LOGIN parameters:dic success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *token = [dic objectForKey:@"token"];
            NSString *uid = [dic objectForKey:@"uid"];
            [userDefault setObject:token forKey:user_token];
            [userDefault setObject:uid forKey:user_uid];
            [userDefault synchronize];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainTabBarController * main = [[MainTabBarController alloc] init];
            appDelegate.window.rootViewController = main;
        }
        if ([[obj objectForKey:@"code"] isEqualToString:@"006"]) {
            [MBProgressHUD showSuccess:@"账号或密码不一致" toView:self.view];
        }
        if ([[obj objectForKey:@"code"] isEqualToString:@"005"]) {
            [MBProgressHUD showSuccess:@"手机号不存在" toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];;
    
}

-(void)forgetbtnclick
{
    forgetVC *vc = [[forgetVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)qqbtnclick
{
    [ZTVendorManager loginWith:ZTVendorPlatformTypeQQ completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
}

-(void)weixinbtnclick
{
    [ZTVendorManager loginWith:ZTVendorPlatformTypeWechat completionHandler:^(ZTVendorAccountModel *model, NSError *error) {
        NSLog(@"nickname:%@",model.nickname);
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
}
@end
