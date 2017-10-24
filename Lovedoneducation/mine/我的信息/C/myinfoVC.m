//
//  myinfoVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfoVC.h"
#import "startVC.h"
#import "MainNavigationController.h"
#import "AppDelegate.h"
#import "changephoneVC.h"
#import "changenameVC.h"
#import "changepasswordVC.h"

@interface myinfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submtiBtn;

@end

static NSString *myinfoidentfid0 = @"myinfoidentfid0";
static NSString *myinfoidentfid1 = @"myinfoidentfid1";
static NSString *myinfoidentfid2 = @"myinfoidentfid2";
static NSString *myinfoidentfid3 = @"myinfoidentfid3";

@implementation myinfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] init];
        _footView.frame = CGRectMake(0, 0, kScreenW, kScreenH-NAVIGATION_HEIGHT-250);
        _footView.backgroundColor = [UIColor whiteColor];
        [_footView addSubview:self.submtiBtn];
    }
    return _footView;
}

-(UIButton *)submtiBtn
{
    if(!_submtiBtn)
    {
        _submtiBtn = [[UIButton alloc] init];
        _submtiBtn.frame = CGRectMake(100, kScreenH-NAVIGATION_HEIGHT-400*HEIGHT_SCALE, kScreenW-200, 44);
        [_submtiBtn setTitle:@"退出登录" forState:normal];
        _submtiBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submtiBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        [_submtiBtn addTarget:self action:@selector(submtibtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submtiBtn;
}




#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"修改账号信息";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid1];
        }
        cell.textLabel.textColor = [UIColor colorWithHexString:@"323232"];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.textLabel.text = @"修改昵称";
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"修改密码";
        }
        if (indexPath.row==2) {
            cell.textLabel.text = @"更换手机号";
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50;
    }
    else
    {
        return 60;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

#pragma mark - 实现方法

-(void)submtibtnclick
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [userDefault removeObjectForKey:user_uid];
        [userDefault removeObjectForKey:user_token];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        startVC *vc = [[startVC alloc] init];
        MainNavigationController *nav = [[MainNavigationController alloc] init];
        nav.viewControllers = @[vc];
        appDelegate.window.rootViewController = nav;
        
    }];;
    [control addAction:action0];
    [control addAction:action1];
    [self presentViewController:control animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            changenameVC *vc = [[changenameVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==1) {
            changepasswordVC *vc = [[changepasswordVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2) {
            changephoneVC *vc = [[changephoneVC alloc] init];
            vc.phonestr = self.phonestr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
