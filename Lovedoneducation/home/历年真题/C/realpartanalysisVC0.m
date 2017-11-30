//
//  realpartanalysisVC0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisVC0.h"
#import "realparticularsCell0.h"
#import "realparticularsCell1.h"

@interface realpartanalysisVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end

static NSString *realparticularsCellidentfid0 = @"realparticularsCellidentfid0";
static NSString *realparticularsCellidentfid1 = @"realparticularsCellidentfid1";

@implementation realpartanalysisVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"错题分析";
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        realparticularsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid0];
        if (!cell) {
            cell = [[realparticularsCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid0];
        }
        [cell setdata:self.model.qcontent andtype:self.model.qtype andtitle:self.model.qtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        realparticularsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid1];
        if (!cell) {
            cell = [[realparticularsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid1];
        }
        [cell setarray:self.model.qanswer andtype:self.model.qtype andimgarr:self.model.answerimgarr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}
@end
