//
//  changeVC0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeVC0.h"
#import "changeVC1.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"


@interface changeVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSString *type;
@end

static NSString *changevcidentfid0 = @"changevcidentfid0";

@implementation changeVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = @"0";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    self.title = @"选择考试类型";
    self.table.tableFooterView = [UIView new];
    [self.view addSubview:self.table];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(NSArray *)dataSource
{
    if(!_dataSource)
    {
        _dataSource = [NSArray array];
        _dataSource = @[@"国家公务员考试",@"山东公务员考试",@"山东事业单位",@"山东选调村官",@"山东招警考试",@"山东三支一扶"];
    }
    return _dataSource;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changevcidentfid0];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changevcidentfid0];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"646464"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        self.type = @"1";
    }
    if (indexPath.row==1) {
        self.type = @"2";
    }
    if (indexPath.row==2) {
        self.type = @"3";
    }
    if (indexPath.row==3) {
        self.type = @"4";
    }
    if (indexPath.row==4) {
        self.type = @"5";
    }
    if (indexPath.row==5) {
        self.type = @"6";
    }
}

#pragma mark - 实现方法

-(void)rightAction
{
    if ([self.type isEqualToString:@"1"]) {
        changeVC1 *vc = [[changeVC1 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"2"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarController * main = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = main;
        
    }
    else if ([self.type isEqualToString:@"3"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarController * main = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = main;
    }
    else if ([self.type isEqualToString:@"4"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarController * main = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = main;
    }
    else if ([self.type isEqualToString:@"5"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarController * main = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = main;
    }
    else if ([self.type isEqualToString:@"6"])
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarController * main = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = main;
    }else
    {
        [MBProgressHUD showSuccess:@"请选择类型" toView:self.view];
    }
    
}

@end
