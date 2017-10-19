//
//  startVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "startVC.h"
#import "LoginVC.h"
#import "LogupVC.h"

@interface startVC ()
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *logupBtn;
@end

@implementation startVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.logupBtn];
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
    [weakSelf.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.height.mas_equalTo(44);
        make.left.equalTo(weakSelf.view).with.offset(34.5);
        make.top.equalTo(weakSelf.logoImg.mas_bottom).with.offset(145*HEIGHT_SCALE);
    }];
    [weakSelf.logupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.height.mas_equalTo(44);
        make.left.equalTo(weakSelf.view).with.offset(34.5);
        make.top.equalTo(weakSelf.loginBtn.mas_bottom).with.offset(26*HEIGHT_SCALE);
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

-(UIButton *)loginBtn
{
    if(!_loginBtn)
    {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:normal];
        [_loginBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:normal];
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_loginBtn addTarget:self action:@selector(loginbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UIButton *)logupBtn
{
    if(!_logupBtn)
    {
        _logupBtn = [[UIButton alloc] init];
        [_logupBtn setTitle:@"注册" forState:normal];
        [_logupBtn setTitleColor:[UIColor colorWithHexString:@"08D2B2"] forState:normal];
        _logupBtn.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _logupBtn.layer.masksToBounds = YES;
        _logupBtn.layer.borderWidth = 0.6;
        _logupBtn.layer.borderColor = [UIColor colorWithHexString:@"E5E5E5"].CGColor;
        [_logupBtn addTarget:self action:@selector(logupbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logupBtn;
}

#pragma mark - 实现方法

-(void)loginbtnclick
{
    LoginVC *vc = [[LoginVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logupbtnclick
{
    LogupVC *vc = [[LogupVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
