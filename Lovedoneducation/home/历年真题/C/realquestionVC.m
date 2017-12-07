//
//  realquestionVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realquestionVC.h"
#import "realquestionCell.h"
#import "realquextionModel.h"
#import "realparticularsVC.h"

@interface realquestionVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *requalquestionidentfid = @"requalquestionidentfid";

@implementation realquestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历年真题";
    self.dataSource = [NSMutableArray array];
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
    NSString *url = [NSString stringWithFormat:GET_realQuestion,uid];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                realquextionModel *model = [[realquextionModel alloc] init];
                model.ctime = [dic objectForKey:@"ctime"];
                model.qcid = [dic objectForKey:@"qcid"];
                model.qcintro = [dic objectForKey:@"qcintro"];
                model.qcname = [dic objectForKey:@"qcname"];
                model.qcscore = [dic objectForKey:@"qcscore"];
                model.qctype = [dic objectForKey:@"qctype"];
                model.qdegree = [dic objectForKey:@"qdegree"];
                model.users = [dic objectForKey:@"users"];
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
    realquestionCell *cell = [tableView dequeueReusableCellWithIdentifier:requalquestionidentfid];
    if (!cell) {
        cell = [[realquestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:requalquestionidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    realparticularsVC *vc = [[realparticularsVC alloc] init];
    realquextionModel *model = self.dataSource[indexPath.row];
    vc.qcid = model.qcid;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
