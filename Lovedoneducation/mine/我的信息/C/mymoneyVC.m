//
//  mymoneyVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import "mymoneyVC.h"
#import "mymoneycell0.h"
#import "mymoneycell1.h"
#import "mymoneycell2.h"

@interface mymoneyVC ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSString *moneystr;
@property (nonatomic,assign) BOOL isxuanze;
@end

static NSString *moneyidentfid0 = @"moneyidentfid0";
static NSString *moneyidentfid1 = @"moneyidentfid1";
static NSString *moneyidentfid2 = @"moneyidentfid2";

@implementation mymoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    self.isxuanze = NO;
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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



#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        mymoneycell0 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid0];
        if (!cell) {
            cell = [[mymoneycell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid0];
        }
        cell.moneylab.text = [userDefault objectForKey:user_uprice];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        mymoneycell1 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid1];
        if (!cell) {
            cell = [[mymoneycell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row==2) {
        mymoneycell2 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid2];
        if (!cell) {
            cell = [[mymoneycell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }
    if (indexPath.row==1) {
        return 200;
    }
    if (indexPath.row==2) {
        return 80;
    }
    return 0.01f;
}

#pragma mark - 协议方法

-(void)myTabVClick0:(UITableViewCell *)cell
{
    self.moneystr = @"1";
    self.isxuanze = YES;
}

-(void)myTabVClick1:(UITableViewCell *)cell
{
    self.moneystr = @"12";
    self.isxuanze = YES;
}

-(void)myTabVClick2:(UITableViewCell *)cell
{
    self.moneystr = @"30";
    self.isxuanze = YES;
}

-(void)submitVClick1:(UITableViewCell *)cell
{
    if (self.isxuanze) {
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSDictionary *para = @{@"uid":uid,@"token":token,@"price":self.moneystr};
        [DNNetworking postWithURLString:POST_PRICE parameters:para success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSDictionary *dic = [obj objectForKey:@"data"];
                NSString *uprice = [dic objectForKey:@"uprice"];
                [userDefault setObject:uprice forKey:user_uprice];
                [MBProgressHUD showSuccess:@"充值成功" toView:self.view];
                [self.table reloadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [MBProgressHUD showSuccess:@"请选择充值金额" toView:self.view];
    }

    
}

@end
