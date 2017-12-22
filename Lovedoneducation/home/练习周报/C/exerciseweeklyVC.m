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
#import "exerciseweeklyCell4.h"
#import "exerciseweeklyCell5.h"
#import "exerciseweeklyCell6.h"
#import "exerciseweeklyCell7.h"

@interface exerciseweeklyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,assign) BOOL isshow;
@end

static NSString *exercisidentfid0 = @"exercisidentfid0";
static NSString *exercisidentfid1 = @"exercisidentfid1";
static NSString *exercisidentfid2 = @"exercisidentfid2";
static NSString *exercisidentfid3 = @"exercisidentfid3";
static NSString *exercisidentfid4 = @"exercisidentfid4";
static NSString *exercisidentfid5 = @"exercisidentfid5";
static NSString *exercisidentfid6 = @"exercisidentfid6";
static NSString *exercisidentfid7 = @"exercisidentfid7";

@implementation exerciseweeklyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"练习周报";
    self.dic = [NSDictionary dictionary];
    self.isshow = NO;
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *url = [NSString stringWithFormat:GET_weekdeport,uid];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            self.dic = [obj objectForKey:@"data"];
            self.isshow = YES;
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
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        exerciseweeklyCell0 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid0];
        if (!cell) {
            cell = [[exerciseweeklyCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid0];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        exerciseweeklyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid1];
        if (!cell) {
            cell = [[exerciseweeklyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid1];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        exerciseweeklyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid2];
        if (!cell) {
            cell = [[exerciseweeklyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid2];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        exerciseweeklyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid3];
        if (!cell) {
            cell = [[exerciseweeklyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid3];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==4) {
        exerciseweeklyCell4 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid4];
        if (!cell) {
            cell = [[exerciseweeklyCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid4];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==5) {
        exerciseweeklyCell5 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid5];
        if (!cell) {
            cell = [[exerciseweeklyCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid5];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==6) {
        exerciseweeklyCell6 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid6];
        if (!cell) {
            cell = [[exerciseweeklyCell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid6];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==7) {
        exerciseweeklyCell7 *cell = [tableView dequeueReusableCellWithIdentifier:exercisidentfid7];
        if (!cell) {
            cell = [[exerciseweeklyCell7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exercisidentfid7];
        }
        if (self.isshow) {
            [cell setdata:self.dic];
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
    else
    {
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
    }

    return 0.01f;
}

@end
