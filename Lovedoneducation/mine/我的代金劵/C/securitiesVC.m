//
//  securitiesVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "securitiesVC.h"
#import "securitiesCell0.h"
#import "securitiesCell1.h"
#import "securitesModel.h"

@interface securitiesVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSDictionary *moneydic;
@property (nonatomic,assign) BOOL isshow;
@end

static NSString *securitiesidentfid0 = @"securitiesidentfid0";
static NSString *securitiesidentfid1 = @"securitiesidentfid1";
static NSString *securitiesidentfid2 = @"securitiesidentfid2";

@implementation securitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"爱唐币优惠劵";
    self.isshow = NO;
    self.dataSource = [NSMutableArray new];
    self.moneydic = [NSDictionary new];
    [self.view addSubview:self.table];
    [self loaddata];
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

#pragma mark - 数据源方法

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_mineCoupon,uid,token];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [obj objectForKey:@"data"];
            NSArray *class = [datadic objectForKey:@"class"];
            self.moneydic = [datadic objectForKey:@"all"];
            self.isshow = YES;
            for (int i = 0; i<class.count; i++) {
                NSDictionary *dic = [class objectAtIndex:i];
                securitesModel *model = [[securitesModel alloc] init];
                model.couponid = [dic objectForKey:@"couponid"];
                model.number = [dic objectForKey:@"number"];
                model.status = [dic objectForKey:@"status"];
                model.time = [dic objectForKey:@"time"];
                model.ucid = [dic objectForKey:@"ucid"];
                model.ucprice = [dic objectForKey:@"ucprice"];
                model.uctype = [dic objectForKey:@"uctype"];
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return self.dataSource.count;
    }
    if (section==2) {
        if (self.isshow) {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"每日签到、评论和分享有机会获得现金抵用券哦";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.section==1) {
        securitiesCell0 *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid1];
        if (!cell) {
            cell = [[securitiesCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid1];
        }
        [cell setdata:self.dataSource[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        securitiesCell1 *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid2];
        if (!cell) {
            cell = [[securitiesCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid2];
        }
        [cell setdata:self.moneydic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50;
    }
    if (indexPath.section==1) {
        return 100;
    }
    if (indexPath.section==2) {
        return 150;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01f;
    }
    if (section==1) {
        return 60;
    }
    if (section==2) {
        return 60;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        if (self.isshow) {
            UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
            UILabel *lab0 = [[UILabel alloc] init];
            UILabel *lab1 = [[UILabel alloc] init];
            lab1.font = [UIFont systemFontOfSize:12];
            lab0.text = @"爱唐课程券";
            lab1.text = @"每次限使用一张，少补不退";
            lab0.frame = CGRectMake(15, 20, 100, 20);
            lab1.frame = CGRectMake(130, 20, 200, 20);
            [footview addSubview:lab1];
            [footview addSubview:lab0];
            return footview;
        }
        else
        {
            return nil;
        }

    }
    if (section==2) {
        if (self.isshow) {
            UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
            UILabel *lab0 = [[UILabel alloc] init];
            lab0.text = @"爱唐币抵用券";
            lab0.frame = CGRectMake(15, 20, 100, 20);
            [footview addSubview:lab0];
            return footview;
        }
        else
        {
            return nil;
        }

    }
    return nil;
}
@end
