//
//  LogupVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LogupVC.h"
#import "logupCell0.h"
#import "logupCell1.h"
#import "logupCell2.h"
#import "logupCell3.h"

@interface LogupVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@end

static NSString *logupCell0identfid = @"logupCell0identfid";
static NSString *logipCell1identfid = @"logipCell1identfid";
static NSString *logipCell2identfid = @"logipCell2identfid";
static NSString *logipCell3identfid = @"logipCell3identfid";
static NSString *logupCell4identfid = @"logupCell4identfid";
static NSString *logupCell5identfid = @"logupCell5identfid";
static NSString *logupCell6identfid = @"logupCell6identfid";

@implementation LogupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号注册";
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    // tableView 偏移20/64适配
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}


#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
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
        _footView.backgroundColor = [UIColor whiteColor];
        _footView.frame = CGRectMake(0, 0, kScreenW, 150*HEIGHT_SCALE);
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"完成" forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        
    }
    return _submitBtn;
}



#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        logupCell0 *cell = [tableView dequeueReusableCellWithIdentifier:logupCell0identfid];
        if (!cell) {
            cell = [[logupCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logupCell0identfid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:logipCell1identfid];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logipCell1identfid];
        }
        cell.infotext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.placeholder = @"请输入昵称";
        return cell;
    }
    if (indexPath.row==2) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:logipCell2identfid];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logipCell2identfid];
        }
        cell.infotext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.placeholder = @"请输入手机号";
        return cell;
    }
    if (indexPath.row==3) {
        logupCell2 *cell = [tableView dequeueReusableCellWithIdentifier:logipCell3identfid];
        if (!cell) {
            cell = [[logupCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logipCell3identfid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.yanzhengtext.placeholder = @"请输入手机验证码";
        return cell;
    }
    if (indexPath.row==4) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:logupCell4identfid];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logupCell4identfid];
        }
        cell.infotext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.placeholder = @"请输入密码";
        return cell;
    }
    if (indexPath.row==5) {
        logupCell3 *cell = [tableView dequeueReusableCellWithIdentifier:logupCell6identfid];
        if (!cell) {
            cell = [[logupCell3 alloc] initWithStyle:(UITableViewCellStyle)UITableViewCellStyleDefault reuseIdentifier:logupCell4identfid];
        }
        cell.passwordtext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 60*HEIGHT_SCALE;
    }
    if (indexPath.row==2) {
        return 60*HEIGHT_SCALE;
    }
    if (indexPath.row==3) {
        return 60*HEIGHT_SCALE;
    }
    if (indexPath.row==4) {
        return 60*HEIGHT_SCALE;
    }
    if (indexPath.row==5) {
        return 90*HEIGHT_SCALE;
    }
    return 0.01f;
}
@end
