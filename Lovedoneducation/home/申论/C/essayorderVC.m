//
//  essayorderVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ZTVendorManagerConfig.h"
#import "essayorderVC.h"
#import "essayorderCell0.h"
#import "essayorderCell1.h"
#import "essayorderCell2.h"
#import "essayorderCell3.h"
#import "essayorderCell4.h"
#import "chooseView.h"
#import "strisNull.h"
#import "ZTVendorManager.h"

@interface essayorderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) chooseView *zhifuView;
@property (nonatomic,strong)UIView *bgView;//半透明背景
@property (nonatomic,copy) NSString *zhekoumoney;
@property (nonatomic,copy) NSString *money;
@property (nonatomic, strong) ZTVendorPayManager *payManager;
@property (nonatomic,strong) UILabel *textlab;

@property (nonatomic,copy) NSString *orderid;
@property (nonatomic,copy) NSString *out_trade_no ;
@property (nonatomic,copy) NSString *ordersn;
@end

static NSString *essayorderidentfid0 = @"essayorderidentfid0";
static NSString *essayorderidentfid1 = @"essayorderidentfid1";
static NSString *essayorderidentfid2 = @"essayorderidentfid2";
static NSString *essayorderidentfid3 = @"essayorderidentfid3";
static NSString *essayorderidentfid4 = @"essayorderidentfid4";

@implementation essayorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
    self.payManager = [[ZTVendorPayManager alloc]init];
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH-0);
    }
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
    NSString *url = [NSString stringWithFormat:GET_mineCoupon,uid,token];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [obj objectForKey:@"data"];
            NSDictionary *moneydic = [datadic objectForKey:@"all"];
            NSString *str1 = [NSString stringWithFormat:@"%@", [moneydic objectForKey:@"price"]];
            if ([strisNull isNullToString:str1]) {
                self.zhekoumoney = @"0";
            }
            else
            {
                self.zhekoumoney = str1;
            }
            float f0 = [self.zhekoumoney floatValue];
            float f1 = [self.pricestr floatValue];
            float f2 = f1-f0;
            self.money = [NSString stringWithFormat:@"%.2f",f2];
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

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] init];
        _footView.frame = CGRectMake(0, 0, kScreenW, 120);
        _footView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        [_footView addSubview:self.submitBtn];
        [_footView addSubview:self.textlab];
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.frame = CGRectMake((kScreenW-225)/2, 20, 225, 40);
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"提交订单" forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        
    }
    return _submitBtn;
}

-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.frame = CGRectMake((kScreenW-225)/2, 70, 225, 20);
        _textlab.textAlignment = NSTextAlignmentCenter;
        _textlab.font = [UIFont systemFontOfSize:12];
        _textlab.textColor = [UIColor colorWithHexString:@"646464"];
        _textlab.text = @"#请到账户信息-我的账户进行充值#";
    }
    return _textlab;
}



#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    if (section==1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            essayorderCell0 *cell = [tableView dequeueReusableCellWithIdentifier:essayorderidentfid0];
            if (!cell) {
                cell = [[essayorderCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essayorderidentfid0];
            }
            [cell setdatatimestr:self.timestr andnumstr:self.numstr andpricestr:self.pricestr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==1) {
            essayorderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:essayorderidentfid1];
            if (!cell) {
                cell = [[essayorderCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essayorderidentfid1];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==2) {
            essayorderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:essayorderidentfid2];
            if (!cell) {
                cell = [[essayorderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essayorderidentfid2];
            }
            [cell setdata:self.zhekoumoney];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==3) {
            essayorderCell3 *cell = [tableView dequeueReusableCellWithIdentifier:essayorderidentfid3];
            if (!cell) {
                cell = [[essayorderCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essayorderidentfid3];
            }
            [cell setdata:self.money];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            essayorderCell4 *cell = [tableView dequeueReusableCellWithIdentifier:essayorderidentfid4];
            if (!cell) {
                cell = [[essayorderCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essayorderidentfid4];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 125;
        }
        if (indexPath.row==1) {
            return 80;
        }
        if (indexPath.row==2) {
            return 80;
        }
        if (indexPath.row==3) {
            return 85;
        }
    }
    if (indexPath.section==1) {
        return 84;
    }
    return 0.01f;
}

-(void)submitbtnclick
{
    [self tijiaodanan];

}



-(void)tijiaodanan
{
    NSString *couponprice = @"";
    CGFloat f1 = [self.zhekoumoney floatValue];
    CGFloat f2 = [self.pricestr floatValue];
    
    if (f1==0&&f2==0) {
        [MBProgressHUD showSuccess:@"您还没有做题" toView:self.view];
    }
    else
    {
        if (f1==f2) {
            NSString *uid = [userDefault objectForKey:user_uid];
            NSString *token = [userDefault objectForKey:user_token];
            NSDictionary *para = @{@"uid":uid,@"token":token,@"orderid":self.orderid,@"type":@"1"};
            [DNNetworking postWithURLString:POST_successOrder parameters:para success:^(id obj) {
                
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
            if (f1>f2) {
                 couponprice = self.pricestr;
            }
            else{
                couponprice = self.zhekoumoney;
            }
            
            [self.para setValue:couponprice forKey:@"couponprice"];
            [self.para setValue:@"2" forKey:@"type"];
            [DNNetworking postWithURLString:POST_orderInsert parameters:self.para success:^(id obj) {
                if ([[obj objectForKey:@"code"] intValue]==200) {
                    NSDictionary *dic = [obj objectForKey:@"data"];
                    self.orderid = [dic objectForKey:@"orderid"];
                    self.ordersn = [dic objectForKey:@"ordersn"];
                    NSString *ordertotalprice = [dic objectForKey:@"ordertotalprice"];
                    NSLog(@"价格----%@",ordertotalprice);
                    [MBProgressHUD showSuccess:@"提交成功" toView:self.table];
                    CGFloat ff1 = [ordertotalprice floatValue];
                    NSString *uprice = [userDefault objectForKey:user_uprice];
                    CGFloat ff2 = [uprice floatValue];
                    if (ff1>ff2) {
                        [MBProgressHUD showSuccess:@"余额不足，请充值" toView:self.view];
                    }
                    else
                    {
                        NSString *uid = [userDefault objectForKey:user_uid];
                        NSString *token = [userDefault objectForKey:user_token];
                        NSDictionary *para = @{@"uid":uid,@"token":token,@"orderid":self.orderid,@"type":@"2"};
                        
                        [DNNetworking postWithURLString:POST_successOrder parameters:para success:^(id obj) {
                            if ([[obj objectForKey:@"code"] intValue]==200) {
                                [MBProgressHUD showSuccess:@"支付成功" toView:self.view];
                            }
                        } failure:^(NSError *error) {
                            
                        }];
                    }

                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 20;
    }
    else
    {
        return 0.01f;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
        view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        return view;
    }
    return nil;
}
@end
