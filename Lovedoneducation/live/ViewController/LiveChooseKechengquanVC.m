//
//  LiveChooseKechengquanVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveChooseKechengquanVC.h"
#import "securitiesCell0.h"
#import "securitiesCell1.h"


@interface LiveChooseKechengquanVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSDictionary *moneydic;
@property (nonatomic,assign) BOOL isshow;
@property (nonatomic, strong) UIButton *quedingBtn;
@property (nonatomic, strong) NSMutableArray *selectArr;

@end
static NSString *securitiesidentfid0 = @"securitiesidentfid0";
static NSString *securitiesidentfid1 = @"securitiesidentfid1";
static NSString *securitiesidentfid2 = @"securitiesidentfid2";
@implementation LiveChooseKechengquanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程券";
    self.isshow = YES;
    //self.dataSource = [NSMutableArray new];
    self.moneydic = [NSDictionary new];
    [self.view addSubview:self.table];
    //[self loaddata];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.selectArr = [NSMutableArray array];
    for (int i = 0; i< self.dataSource.count; i++) {
        [self.selectArr addObject:@"0"];
    }
    
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return self.dataSource.count;
    }
    if (section==2) {
        if (self.isshow) {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"每日签到、评论和分享有机会获得现金抵用券哦";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.section==1) {
        securitiesCell0 *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid1];
        if (!cell) {
            cell = [[securitiesCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid1];
        }
        [cell setdata:self.dataSource[indexPath.row]];
        cell.selectImg.hidden = NO;
        NSString *state = self.selectArr[indexPath.row];
        if ([state isEqualToString:@"0"]) {
            cell.selectImg.image = [UIImage imageNamed:@"diyongquan_icon_default_tijiaodingdan"];
        } else {
            cell.selectImg.image = [UIImage imageNamed:@"diyongquan_icon_selected_tijiaodingdan"];
        }
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        securitiesCell1 *cell = [tableView dequeueReusableCellWithIdentifier:securitiesidentfid2];
        if (!cell) {
            cell = [[securitiesCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:securitiesidentfid2];
        }
        [cell setdata:self.moneydic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *state = self.selectArr[indexPath.row];
    if ([state isEqualToString:@"1"]) {
        state = @"0";
    } else {
        state = @"1";
    }
    [self.selectArr removeAllObjects];
    for (int i = 0; i < self.dataSource.count; i++) {
        [self.selectArr addObject:@"0"];
    }
    [self.selectArr removeObjectAtIndex:indexPath.row];
    [self.selectArr insertObject:state atIndex:indexPath.row];
    [tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50;
    }
    if (indexPath.section==1) {
        return 100;
    }
    if (indexPath.section==2) {
        return 150;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01f;
    }
    if (section==1) {
        return 60;
    }
    if (section==2) {
        return 60;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 160;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 120)];
    view.backgroundColor = krgb(246, 246, 246);
    self.quedingBtn = [[UIButton alloc] init];
    [view addSubview:self.quedingBtn];
    [self.quedingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(220, 44));
    }];
    [self.quedingBtn setTitle:@"确定" forState: UIControlStateNormal];
    [self.quedingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.quedingBtn.backgroundColor = krgb(8, 210, 178);
    [self.quedingBtn bk_addEventHandler:^(id sender) {
        for (int i = 0; i < self.selectArr.count; i++) {
            
            if ([self.selectArr[i] isEqualToString:@"1"]) {
                self.submitvc.kechengquan = self.dataSource[i].ucprice;
                self.submitvc.kechengquanid = self.dataSource[i].ucid;
                [self.navigationController popViewControllerAnimated:YES];
                return;
            } else {
                if (i == self.selectArr.count - 1) {
                    self.submitvc.kechengquan = @"0";
                    self.submitvc.kechengquanid = @"0";
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    } forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        if (self.isshow) {
            UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
            UILabel *lab0 = [[UILabel alloc] init];
            UILabel *lab1 = [[UILabel alloc] init];
            lab1.font = [UIFont systemFontOfSize:12];
            lab0.text = @"课程券";
            lab1.text = @"每次限使用一张，少补不退";
            lab0.frame = CGRectMake(15, 20, 100, 20);
            lab1.frame = CGRectMake(130, 20, 200, 20);
            [footview addSubview:lab1];
            [footview addSubview:lab0];
            return footview;
        }
        else
        {
            return nil;
        }
        
    }
    if (section==2) {
        if (self.isshow) {
            UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
            UILabel *lab0 = [[UILabel alloc] init];
            lab0.text = @"现金抵用券";
            lab0.frame = CGRectMake(15, 20, 100, 20);
            [footview addSubview:lab0];
            return footview;
        }
        else
        {
            return nil;
        }
        
    }
    return nil;
}

@end
