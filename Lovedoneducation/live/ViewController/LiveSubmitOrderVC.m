//
//  LiveSubmitOrderVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveSubmitOrderVC.h"
#import "LiveOrderCell.h"
#import "LiveCourseCell.h"
#import "LivePayView.h"
#import "securitesModel.h"
#import "LiveCourseDetailVC.h"
#import "LiveChooseKechengquanVC.h"
#import "strisNull.h"
#import "ZTVendorManager.h"

@interface LiveSubmitOrderVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *money;  // 代金券总额
@property (nonatomic, assign) CGFloat daijinquan; //  使用代金券金额
@property (nonatomic, strong) LivePayView *payV;
@property (nonatomic, strong) ZTVendorPayManager *payManager;
@property (nonatomic,copy)  NSString *out_trade_no;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *ordersn;
@property (nonatomic, copy) NSString *orderPrice;

@end

@implementation LiveSubmitOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)){
        _tableView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        _tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = [NSMutableArray array];
    UINib *order = [UINib nibWithNibName:NSStringFromClass([LiveOrderCell class]) bundle:nil];
    UINib *course = [UINib nibWithNibName:NSStringFromClass([LiveCourseCell class]) bundle:nil];
    [self.tableView registerNib:order forCellReuseIdentifier:@"order"];
    [self.tableView registerNib:course forCellReuseIdentifier:@"course"];
    self.kechengquan = @"0";
    self.money = @"0";
    [self loaddata];
    self.title = @"提交订单";
    self.payManager = [[ZTVendorPayManager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
            NSArray *class = [datadic objectForKey:@"class"];
            for (int i = 0; i<class.count; i++) {
                NSDictionary *dic = [class objectAtIndex:i];
                securitesModel *model = [[securitesModel alloc] init];
                model.couponid = [dic objectForKey:@"couponid"];
                model.number = [dic objectForKey:@"number"];
                model.status = [dic objectForKey:@"status"];
                model.time = [dic objectForKey:@"time"];
                model.ucid = [dic objectForKey:@"ucid"];
                model.ucprice = [dic objectForKey:@"ucprice"];
                model.uctype = [dic objectForKey:@"uctype"];
                [self.dataSource addObject:model];
            }
            NSDictionary *moneydic = [datadic objectForKey:@"all"];
            self.money = [NSString stringWithFormat:@"%@", [moneydic objectForKey:@"price"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        LiveCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"course" forIndexPath:indexPath];
        LiveCourseModel *model = self.model;
        cell.titleL.text = model.c_name;
        // TODO:   介绍.....
        cell.introL.text = @"介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍";
        
        NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
        dateformater.dateFormat = @"yyyy.MM.dd";
        NSTimeInterval start = model.c_start_time;
        NSTimeInterval end = model.c_end_time;
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
        NSString *startTime = [dateformater stringFromDate:startDate];
        NSString *endTime = [dateformater stringFromDate:endDate];
        cell.timeL.text = [NSString stringWithFormat:@"%@-%@", startTime, endTime];
        cell.count.text = model.c_pay_num;
        cell.priceL.text = [NSString stringWithFormat:@"¥%@", model.c_price];
        cell.teacher1.hidden = YES;
        cell.teacher2.hidden = YES;
        cell.teacher3.hidden = YES;
        for (int i = 0; i < model.teacher.count; i++) {
            LiveTeacherModel *teacher = model.teacher[i];
            if (i == 0) {
                [cell.teacher1Img setImageWithURL:teacher.tpic.xd_URL placeholder:[UIImage imageNamed:@"touxiang_image_zhiboshouye"]];
                cell.teacher1Name.text = teacher.tname;
                cell.teacher1.hidden = NO;
            } else if (i == 1) {
                [cell.teacher2Img setImageWithURL:teacher.tpic.xd_URL placeholder:[UIImage imageNamed:@"touxiang_image_zhiboshouye"]];
                cell.teacher2Name.text = teacher.tname;
                cell.teacher2.hidden = NO;
            } else {
                [cell.teacher3Img setImageWithURL:teacher.tpic.xd_URL placeholder:[UIImage imageNamed:@"touxiang_image_zhiboshouye"]];
                cell.teacher3Name.text = teacher.tname;
                cell.teacher3.hidden = NO;
            }
        }
        return cell;
    }
    LiveOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order" forIndexPath:indexPath];
    [cell.kechengquanBtn removeAllTargets];
    [cell.kechengquanBtn bk_addEventHandler:^(id sender) {
        // 跳转课程抵用券
        if (self.dataSource.count == 0) {
            return;
            //[self.view showWarning:@"没有课程券"];
        }
        LiveChooseKechengquanVC *vc = [[LiveChooseKechengquanVC alloc] init];
        vc.dataSource = self.dataSource;
        vc.submitvc = self;
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [cell.cashDiyongBtn removeAllTargets];
    [cell.cashDiyongBtn bk_addEventHandler:^(id sender) {
        //切换是否使用现金抵用券
        if (cell.cashDiyongBtn.tag == 100) {
            cell.cashDiyongBtn.tag = 200;
            [cell.cashDiyongBtn setImage:[UIImage imageNamed:@"diyongquan_icon_selected_tijiaodingdan"] forState:UIControlStateNormal];
        } else {
            cell.cashDiyongBtn.tag = 100;
            [cell.cashDiyongBtn setImage:[UIImage imageNamed:@"diyongquan_icon_default_tijiaodingdan"] forState:UIControlStateNormal];
        }
        [self.tableView reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    // 没有选用课程券
    if ([self.kechengquan isEqualToString:@"0"]) {
        cell.kechengquanNum.text = [NSString stringWithFormat:@"%ld", self.dataSource.count];
        cell.hideL.hidden = NO;
    } else {
        cell.kechengquanNum.text = [NSString stringWithFormat:@"¥%@", self.kechengquan];
        cell.hideL.hidden = YES;
    }
    
    CGFloat kechengquan = [self.kechengquan floatValue];
    CGFloat price = [self.model.c_price floatValue];
    CGFloat cashdiyong = [self.money floatValue];
    
    
    
    if (cell.cashDiyongBtn.tag == 200) {  // 200 yong,   100 buyong;
        CGFloat leftmoney = price - kechengquan;
        if (leftmoney < 0) {
            cashdiyong = 0;
        } else {
            if (leftmoney < cashdiyong) {
                cashdiyong = leftmoney;
            }
        }
        cell.diyongquanNum.text = [NSString stringWithFormat:@"¥%.0f", cashdiyong];
    } else {
        cashdiyong = 0;
        cell.diyongquanNum.text = [NSString stringWithFormat:@"¥%@", self.money];
    }
    CGFloat count = [self.model.c_price doubleValue] - [self.kechengquan doubleValue] - cashdiyong;
    if (count < 0) {
        count = 0.00;
    }
    self.daijinquan = cashdiyong;
    cell.money.text = [NSString stringWithFormat:@"¥%.2f", count];
    self.orderPrice = cell.money.text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) return 352;
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    if (indexPath.row == 0) {
        LiveCourseDetailVC *vc = [[LiveCourseDetailVC alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }*/
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 130)];
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeSystem];
    [submit setTitle:@"提交订单" forState:UIControlStateNormal];
    [view addSubview:submit];
    submit.tintColor = [UIColor whiteColor];
    
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(200, 44));
    }];
    submit.titleLabel.textColor = [UIColor whiteColor];
    submit.backgroundColor = krgb(8, 210, 178);
    [submit bk_addEventHandler:^(id sender) {
        // 提交
        // done: 支付  提交功能完善 1. 服务器请求支付, 2. 弹出手机支付 view, 3. 发起手机支付
        //self.kechengquan   所选课程券金额
        //self.kechengquanid // id
        //self.money  可用代金券金额
        //self.model.c_price  商品金额
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] initWithDictionary: @{@"uid": uid, @"token": token,@"ucid": self.kechengquanid ? self.kechengquanid : @"0", @"c_id": self.model.c_id, @"type": @"1"}];
        if ([self.kechengquan isEqualToString:@"0"]) {
            [dic removeObjectForKey:@"ucid"];
        }
        if (self.daijinquan) {
            [dic setObject:@(self.daijinquan) forKey:@"couponprice"];
        }
        
        [DNNetworking postWithURLString:POST_orderInsert parameters:dic success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                
                NSDictionary *dic = [obj objectForKey:@"data"];
                self.orderid = [dic objectForKey:@"orderid"];
                self.ordersn = [dic objectForKey:@"ordersn"];
                NSString *ordertotalprice = [dic objectForKey:@"ordertotalprice"];
                NSLog(@"价格----%@",ordertotalprice);
                self.orderPrice = ordertotalprice;
                if ([self.orderPrice floatValue] == 0) {
                    NSString *uid = [userDefault objectForKey:user_uid];
                    NSString *token = [userDefault objectForKey:user_token];
                    [DNNetworking postWithURLString:post_ordersucess parameters:@{@"uid": uid, @"token": token, @"orderid": self.orderid} success:^(id obj) {
                        NSString *code = [obj objectForKey:@"code"];
                        if ([code isEqualToString:@"200"]) {
                            [self.view showWarning:@"购买成功"];
                            self.vc.model.isbuy = @"1";
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } failure:^(NSError *error) {
                        [self.view showWarning:@"服务器错误, 请稍后再试"];
                    }];
                    
                } else {
                    //[MBProgressHUD showSuccess:@"提交成功" toView:self.table];
                    //[self showwindow];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.payV.alpha = 1;
                        self.payV.hidden = NO;
                    }completion:^(BOOL finished) {
                        
                    }];
                }
            }
        } failure:^(NSError *error) {
            
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    return view;
}
/**
 * 微信支付
 */
- (void)weixinPay{
    // TODO: 微信支付
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *price = self.orderPrice;
    
    NSDictionary *dic = @{@"uid":uid,@"token":token,@"price":price};
    [DNNetworking postWithURLString:POST_WEIXINZHIFU parameters:dic success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *appid = [dic objectForKey:@"appid"];
            NSString *noncestr = [dic objectForKey:@"noncestr"];
            self.out_trade_no = [dic objectForKey:@"out_trade_no"];
            NSString *package = [dic objectForKey:@"package"];
            NSString *partnerid = [dic objectForKey:@"partnerid"];
            NSString *prepayid = [dic objectForKey:@"prepayid"];
            NSString *sign = [dic objectForKey:@"sign"];
            NSString *timestamp = [dic objectForKey:@"timestamp"];
            
            ZTVendorPayModel *model = [[ZTVendorPayModel alloc] init];
            model.timeStamp = [timestamp intValue];
            
            model.partnerId = partnerid;
            model.prepayId = prepayid;
            model.package = package;
            model.nonceStr = noncestr;
            model.sign = sign;
            model.appid = appid;
            [self.payManager payOrderWith:1 orderModel:model payResultBlock:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"支付成功");
                    NSString *uid = [userDefault objectForKey:user_uid];
                    NSString *token = [userDefault objectForKey:user_token];
                    [DNNetworking postWithURLString:post_ordersucess parameters:@{@"uid": uid, @"token": token, @"orderid": self.orderid} success:^(id obj) {
                        NSString *code = [obj objectForKey:@"code"];
                        if ([code isEqualToString:@"200"]) {
                            [self.view showWarning:@"购买成功"];
                        }
                    } failure:^(NSError *error) {
                        [self.view showWarning:@"服务器错误, 请稍后再试"];
                    }];
                }else{
                    NSLog(@"%@",error);
                    NSString *url = [NSString stringWithFormat:GET_WEIXINCLONE,self.out_trade_no];
                    [DNNetworking getWithURLString:url success:^(id obj) {
                        
                    } failure:^(NSError *error) {
                        
                    }];
                }
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    self.payV.hidden = YES;
}
/**
 * 阿里支付
 */
- (void)aliPay{
    // TODO: 支付宝支付
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *price = self.orderPrice;
    
    //NSString *url = [NSString stringWithFormat:GET_ZHIFUBAO,uid,token,price];
    
    NSDictionary *para = @{@"uid":uid,@"token":token,@"price":price,@"ordersn":self.ordersn};
    [DNNetworking postWithURLString:POST_ZHIFUBAO parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *str = [dic objectForKey:@"str"];
            ZTVendorPayModel *model = [[ZTVendorPayModel alloc] init];
            model.aliPayOrderString = str;
            [self.payManager payOrderWith:0 orderModel:model payResultBlock:^(BOOL success,NSError *error) {
                if (success) {
                    [DNNetworking postWithURLString:post_ordersucess parameters:@{@"uid": uid, @"token": token, @"orderid": self.orderid} success:^(id obj) {
                        NSString *code = [obj objectForKey:@"code"];
                        if ([code isEqualToString:@"200"]) {
                            [self.view showWarning:@"购买成功"];
                        }
                    } failure:^(NSError *error) {
                        [self.view showWarning:@"服务器错误, 请稍后再试"];
                    }];
                }else{
                    NSLog(@"%@",error);
                }
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
    self.payV.hidden = YES;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 130;
}


- (LivePayView *)payV{
    if (!_payV) {
        
            _payV = [[NSBundle mainBundle] loadNibNamed:@"LIvePayView" owner:nil options:nil].firstObject;
            _payV.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH - NAVIGATION_HEIGHT);
            [_payV.weixin addTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
            [_payV.zhifubao addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_payV];
        _payV.alpha = 0;
        _payV.hidden = YES;
    }
    return _payV;
}


@end
