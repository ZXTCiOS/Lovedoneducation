//
//  changephoneVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneVC.h"
#import "changephoneCell0.h"
#import "changephoneCell1.h"

@interface changephoneVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@end
static NSString *changephoneidentfid0 = @"changephoneidentfid0";
static NSString *changephoneidentfid1 = @"changephoneidentfid1";
static NSString *changephoneidentfid2 = @"changephoneidentfdi2";
@implementation changephoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    [self.view addSubview:self.table];
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT)];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changephoneidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephoneidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"修改手机号";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changephoneidentfid1];
        if (!cell) {
            cell = [[changephoneCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephoneidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50;
    }
    if (indexPath.row==1) {
        return 240;
    }
    if (indexPath.row==2) {
        return 240;
    }
    return 0.01f;
}

@end
