//
//  messageVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messageVC.h"
#import "messageCell.h"
#import "messageModel.h"

@interface messageVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *messageidentfid = @"messageidentfid";

@implementation messageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"信息";
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
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_userMessage,uid,token];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                messageModel *model = [[messageModel alloc] init];
                NSDictionary *dic = [dataarr objectAtIndex:i];
                model.messageid = [dic objectForKey:@"messageid"];
                model.uid = [dic objectForKey:@"uid"];
                model.messagetitle = [dic objectForKey:@"messagetitle"];
                model.messageintro = [dic objectForKey:@"messageintro"];
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
    messageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageidentfid];
    if (!cell) {
        cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageidentfid];
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
