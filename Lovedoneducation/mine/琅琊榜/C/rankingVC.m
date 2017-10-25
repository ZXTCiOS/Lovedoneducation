//
//  rankingVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rankingVC.h"
#import "rankingCell.h"

@interface rankingVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *rankingidentfid = @"rankingidentfid";

@implementation rankingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"山东名师琅琊榜";
    self.dataSource = [NSMutableArray array];
    // Do any additional setup after loading the view.
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
    rankingCell *cell = [tableView dequeueReusableCellWithIdentifier:rankingidentfid];
    if (!cell) {
        cell = [[rankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankingidentfid];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
    
}
@end
