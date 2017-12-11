//
//  collecttopicVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "collecttopicVC.h"
#import "collecttopicModel.h"
#import "collecttopicCell.h"
#import "collecttopicparticularsVC.h"

@interface collecttopicVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *collecttopocidentfid = @"collecttopocidentfid";

@implementation collecttopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏题目";
    [self.view addSubview:self.table];
    self.dataSource = [NSMutableArray array];
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
    NSString *token = [userDefault objectForKey:user_token];
    NSString *type = @"2";
    NSString *url = [NSString stringWithFormat:GET_userquestion,uid,token,type];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *arr = [obj objectForKey:@"data"];
            for (int i = 0; i<arr.count; i++) {
                NSDictionary *dic = [arr objectAtIndex:i];
                collecttopicModel *model = [collecttopicModel new];
                model.name = [dic objectForKey:@"name"];
                model.uqid = [dic objectForKey:@"uqid"];
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
    collecttopicCell *cell = [tableView dequeueReusableCellWithIdentifier:collecttopocidentfid];
    if (!cell) {
        cell = [[collecttopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collecttopocidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    collecttopicModel *model = self.dataSource[indexPath.row];
    collecttopicparticularsVC *vc = [collecttopicparticularsVC new];
    vc.uqid = model.uqid;
    vc.namestr = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
