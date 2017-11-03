//
//  exerciseweeklyVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyVC.h"
#import "exerciseweeklyCell0.h"
#import "exerciseweeklyCell1.h"
#import "exerciseweeklyCell2.h"
#import "exerciseweeklyCell3.h"

@interface exerciseweeklyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *exercisidentfid0 = @"exercisidentfid0";
static NSString *exercisidentfid1 = @"exercisidentfid1";
static NSString *exercisidentfid2 = @"exercisidentfid2";
static NSString *exercisidentfid3 = @"exercisidentfid3";

@implementation exerciseweeklyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"练习周报";
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        exerciseweeklyCell0 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid0];
        if (!cell) {
            cell = [[exerciseweeklyCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        exerciseweeklyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid1];
        if (!cell) {
            cell = [[exerciseweeklyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        exerciseweeklyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid2];
        if (!cell) {
            cell = [[exerciseweeklyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        exerciseweeklyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid3];
        if (!cell) {
            cell = [[exerciseweeklyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid3];
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
        return 60;
    }
    if (indexPath.row==2) {
        return 525;
    }
    if (indexPath.row==3) {
        return 525;
    }
    return 0.01f;
}

@end
