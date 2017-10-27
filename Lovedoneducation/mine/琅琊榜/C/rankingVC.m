//
//  rankingVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "rankingVC.h"
#import "rankingCell.h"
#import "rankingModel.h"

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
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    [DNNetworking getWithURLString:GET_ranking success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                rankingModel *model = [[rankingModel alloc] init];
                model.tid = [dic objectForKey:@"tid"];
                model.time = [dic objectForKey:@"time"];
                model.tintro = [dic objectForKey:@"tintro"];
                model.tname = [dic objectForKey:@"tname"];
                model.tphone = [dic objectForKey:@"tphone"];
                model.tpic = [dic objectForKey:@"tpic"];
                model.tpwd = [dic objectForKey:@"tpwd"];
                model.tscore = [dic objectForKey:@"tscore"];
                model.tsimple = [dic objectForKey:@"tsimple"];
                model.tstatus = [dic objectForKey:@"tstatus"];
                model.ttime = [dic objectForKey:@"ttime"];
                [self.dataSource addObject:model];
                [self.table reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];;
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rankingCell *cell = [tableView dequeueReusableCellWithIdentifier:rankingidentfid];
    if (!cell) {
        cell = [[rankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankingidentfid];
    }
    [cell setdata:self.dataSource[indexPath.row]];
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
