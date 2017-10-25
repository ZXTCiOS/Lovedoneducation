//
//  myinfomessageVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfomessageVC.h"
#import "myinfomessageCell.h"
#import "myinfomessageModel.h"

@interface myinfomessageVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *myinfomessageidentfid = @"myinfomessageidentfid";

@implementation myinfomessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"爱唐播报";
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
    [DNNetworking getWithURLString:GET_slide success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                myinfomessageModel *model = [[myinfomessageModel alloc] init];
                model.pdid = [dic objectForKey:@"pdid"];
                model.pdintro = [dic objectForKey:@"pdintro"];
                model.pdtitle = [dic objectForKey:@"pdtitle"];
                model.pdurl = [dic objectForKey:@"pdurl"];
                model.posterid = [dic objectForKey:@"posterid"];
                model.tid = [dic objectForKey:@"tid"];
                model.time = [dic objectForKey:@"time"];
                [self.dataSource addObject:model];
                [self.table reloadData];
            }
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
    myinfomessageCell *cell = [tableView dequeueReusableCellWithIdentifier:myinfomessageidentfid];
    if (!cell) {
        cell = [[myinfomessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfomessageidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

@end
