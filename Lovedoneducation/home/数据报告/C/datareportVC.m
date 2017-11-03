//
//  datareportVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportVC.h"
#import "datareportCell0.h"
#import "datareportCell1.h"
#import "datareportCell2.h"
#import "datareportCell3.h"
#import "datareportCell4.h"
#import "datareportCell5.h"

@interface datareportVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *datareportidentfid0 = @"datareportidentfid0";
static NSString *datareportidentfid1 = @"datareportidentfid1";
static NSString *datareportidentfid2 = @"datareportidentfid2";
static NSString *datareportidentfid3 = @"datareportidentfid3";
static NSString *datareportidentfid4 = @"datareportidentfid4";
static NSString *datareportidentfid5 = @"datareportidentfid5";

@implementation datareportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据报告";
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
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        datareportCell0 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid0];
        if (!cell) {
            cell = [[datareportCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        datareportCell1 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid1];
        if (!cell) {
            cell = [[datareportCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        datareportCell2 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid2];
        if (!cell) {
            cell = [[datareportCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        datareportCell3 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid3];
        if (!cell) {
            cell = [[datareportCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==4) {
        datareportCell4 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid4];
        if (!cell) {
            cell = [[datareportCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==5) {
        datareportCell5 *cell = [tableView dequeueReusableCellWithIdentifier:datareportidentfid5];
        if (!cell) {
            cell = [[datareportCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datareportidentfid5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 240*WIDTH_SCALE;
    }
    if (indexPath.row==1) {
        return 90;
    }
    if (indexPath.row==2) {
        return 150;
    }
    if (indexPath.row==3) {
        return 90;
    }
    if (indexPath.row==4) {
        return 475;
    }
    if (indexPath.row==5) {
        return 120;
    }
    return 0.01f;
}

@end
