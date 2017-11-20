//
//  changeVC1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeVC1.h"
#import "changeCell1.h"
#import "changeModel1.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface changeVC1 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSString *secondtype;
@end

static NSString *changevc1identfid = @"changevc1identfid";

@implementation changeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择要参加的考试";
    self.secondtype = @"0";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changevc1identfid];
    if (!cell) {
        cell = [[changeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changevc1identfid];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [cell setdata:self.dataSource[indexPath.row]];
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
    
    self.secondtype = @"1";
    
    changeModel1 *model = self.dataSource[indexPath.row];
    self.testid = model.testid;
    self.utest_type = model.testpath;
    NSLog(@"testid---%@",self.testid);
    NSLog(@"utest_type====%@",model.testpath);
}

#pragma mark - 实现方法

-(void)rightAction
{
    if ([self.secondtype isEqualToString:@"1"]) {
        NSString *password = [MD5Tool MD5ForLower32Bate:self.upwd];
        NSString *type = [NSString stringWithFormat:@"%@%@%@",self.utest_type,@"-",self.testid];
        NSDictionary *dic = @{@"upwd":password,@"uphone":self.uphone,@"uname":self.uname,@"testid":self.testid,@"utest_type":type};
        NSLog(@"dic-----%@",dic);
        [DNNetworking postWithURLString:POST_REGISTER parameters:dic success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                [MBProgressHUD showError:@"注册成功" toView:self.view];
                NSDictionary *dic = [obj objectForKey:@"data"];
                NSString *token = [dic objectForKey:@"token"];
                NSString *uid = [dic objectForKey:@"uid"];
                NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
                [defat setObject:token forKey:user_token];
                [defat setObject:uid forKey:user_uid];
                NSString *imtoken = [obj objectForKey:@"acctoken"];
                [userDefault setObject:imtoken forKey:user_imtoken];
                [defat synchronize];
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                MainTabBarController * main = [[MainTabBarController alloc] init];
                appDelegate.window.rootViewController = main;
                
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [MBProgressHUD showSuccess:@"请选择类型" toView:self.view];
    }
}

@end
