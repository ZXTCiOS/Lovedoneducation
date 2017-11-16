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
#import "changeModel0.h"
#import "changeModel1.h"
#import "changeCell0.h"



@interface changeVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSMutableArray *typeArray;
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
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.dataSource = [NSMutableArray array];
    self.typeArray = [NSMutableArray array];
    [self loaddata];
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

-(void)loaddata
{
    [DNNetworking getWithURLString:GET_type success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *array = [obj objectForKey:@"data"];
            for (int i = 0 ; i<array.count; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                changeModel0 *model = [[changeModel0 alloc] init];
                model.testflag = [dic objectForKey:@"testflag"];
                model.testid = [dic objectForKey:@"testid"];
//                model.testlist = [dic objectForKey:@"testlist"];
                model.testname = [dic objectForKey:@"testname"];
                model.testpath = [dic objectForKey:@"testpath"];
                model.testpid = [dic objectForKey:@"testpid"];
                model.time = [dic objectForKey:@"time"];
                [self.dataSource addObject:model];
                
            }
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
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
    changeCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changevcidentfid0];
    if(!cell)
    {
        cell = [[changeCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changevcidentfid0];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [cell setdata:self.dataSource[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"646464"];
    cell.textLabel.highlightedTextColor = [UIColor colorWithHexString:@"FFFFFF"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    changeModel0 *model = self.dataSource[indexPath.row];
    NSString *parentid = model.testid;
    NSString *url = [NSString stringWithFormat:@"%@%@",GET_type2,parentid];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *arr = [obj objectForKey:@"data"];
            for (int i = 0; i<arr.count; i++) {
                NSDictionary *dic = [arr objectAtIndex:i];
                changeModel1 *model = [[changeModel1 alloc] init];
                model.testflag = [dic objectForKey:@"testflag"];
                model.testid = [dic objectForKey:@"testid"];
                model.testname = [dic objectForKey:@"testname"];
                model.testpath = [dic objectForKey:@"testpath"];
                model.testpid = [dic objectForKey:@"testpid"];
                model.time = [dic objectForKey:@"time"];
                [self.typeArray addObject:model];
            }
            self.type = @"1";
            
        }
        else
        {
            self.type = @"2";
            changeModel0 *model0 = self.dataSource[indexPath.row];
            self.testid = model0.testid;
            self.utest_type = model0.testpath;
            NSLog(@"testid---%@",self.testid);
            NSLog(@"utest_type====%@",model.testpath);
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 实现方法

-(void)rightAction
{
    if ([self.type isEqualToString:@"1"]) {
        changeVC1 *vc = [[changeVC1 alloc] init];
        vc.dataSource = [NSMutableArray array];
        vc.dataSource = self.typeArray;
        vc.uphone = self.uphone;
        vc.uname = self.uname;
        vc.upwd = self.upwd;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.type isEqualToString:@"2"])
    {
        NSString *password = [MD5Tool MD5ForLower32Bate:self.upwd];
        NSString *type = [NSString stringWithFormat:@"%@%@%@",self.utest_type,@"-",self.testid];
        NSDictionary *dic = @{@"upwd":password,@"uphone":self.uphone,@"uname":self.uname,@"testid":self.testid,@"utest_type":type};
        NSLog(@"dic-----%@",dic);
        [DNNetworking postWithURLString:POST_REGISTER parameters:dic success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                [MBProgressHUD showError:@"注册成功" toView:self.view];
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
