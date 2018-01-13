//
//  aboutVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutVC.h"
#import "aboutCell0.h"
#import "aboutCell1.h"
#import "aboutCell2.h"


@interface aboutVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;

@property (nonatomic,copy) NSString *website;
@property (nonatomic,copy) NSString *custom_service;
@property (nonatomic,copy) NSString *custom_service_phone;
@property (nonatomic,copy) NSString *custom_service_wechat;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *wechat;
@property (nonatomic,assign) BOOL isshow;
@end

static NSString *aboutidentfid0 = @"aboutidentfid0";
static NSString *aboutidentfid1 = @"aboutidentfid1";
static NSString *aboutidentfid2 = @"aboutidentfid2";
static NSString *aboutidentfid3 = @"aboutidentfid3";
static NSString *aboutidentfid4 = @"aboutidentfid4";
static NSString *aboutidentfid5 = @"aboutidentfid5";

@implementation aboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.isshow = NO;
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

/**
  网络请求
 */
-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_confit,uid,token];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.website = [dic objectForKey:@"website"];
            self.custom_service = [dic objectForKey:@"custom_service"];
            self.custom_service_phone = [dic objectForKey:@"custom_service_phone"];
            self.custom_service_wechat = [dic objectForKey:@"custom_service_wechat"];
            self.wechat = [dic objectForKey:@"wechat"];
            self.address = [dic objectForKey:@"address"];
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        aboutCell0 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid0];
        if (!cell) {
            cell = [[aboutCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        return cell;
    }
    if (indexPath.row==1) {
        aboutCell1 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid1];
        if (!cell) {
            cell = [[aboutCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"官网";
        if (self.isshow) {
            cell.messageLabel.text = self.website;
        }
        return cell;
    }
    if (indexPath.row==2) {
        aboutCell1 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid2];
        if (!cell) {
            cell = [[aboutCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"客服";
        if (self.isshow) {
            cell.messageLabel.text = self.custom_service;
        }
        return cell;
    }
    if (indexPath.row==3) {
        aboutCell1 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid3];
        if (!cell) {
            cell = [[aboutCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"客服电话";
        if (self.isshow) {
            cell.messageLabel.text = self.custom_service_phone;
        }
        return cell;
    }
    if (indexPath.row==4) {
        aboutCell1 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid4];
        if (!cell) {
            cell = [[aboutCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"客服微信";
        if (self.isshow) {
            cell.messageLabel.text = self.custom_service_wechat;
        }
        return cell;
    }
    if (indexPath.row==5) {
        aboutCell2 *cell = [tableView dequeueReusableCellWithIdentifier:aboutidentfid5];
        if (!cell) {
            cell = [[aboutCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutidentfid5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"办公地址";
        if (self.isshow) {
            cell.addressLabel.text = self.address;
            [cell.wechatImg sd_setImageWithURL:[NSURL URLWithString:self.wechat]];
        }
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
        return 60;
    }
    if (indexPath.row==2) {
        return 60;
    }
    if (indexPath.row==3) {
        return 60;
    }
    if (indexPath.row==4) {
        return 60;
    }
    if (indexPath.row==5) {
        return 300;
    }
    return 0.01f;
}


@end
