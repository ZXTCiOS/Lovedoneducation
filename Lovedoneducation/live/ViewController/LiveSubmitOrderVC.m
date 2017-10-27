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

@interface LiveSubmitOrderVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *money;  // 可用代金券金额
@property (nonatomic, strong) LivePayView *payV;
@end

@implementation LiveSubmitOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:kFrame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
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
    CGFloat cashdiyong = 0;
    if (cell.cashDiyongBtn.tag == 200) {  // 200 yong,   100 buyong;
        cashdiyong = [self.money doubleValue];
    }
    CGFloat count = [self.model.c_price doubleValue] - [self.kechengquan doubleValue] - cashdiyong;
    if (count < 0) {
        count = 0.00;
    }
    cell.money.text = [NSString stringWithFormat:@"¥%.2f", count];
    cell.diyongquanNum.text = [NSString stringWithFormat:@"¥%@", self.money];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) return 352;
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LiveCourseDetailVC *vc = [[LiveCourseDetailVC alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        // TODO: 支付  提交功能完善 1. 服务器请求支付, 2. 弹出手机支付 view, 3. 发起手机支付
        //self.kechengquan   所选课程券金额
        //self.money  可用代金券金额
        //self.model.c_price  商品金额
        
        
        
        
        
        // 2. 弹出 选择 view
        if (!self.payV) {
            self.payV = [[NSBundle mainBundle] loadNibNamed:@"LIvePayView" owner:nil options:nil].firstObject;
            self.payV.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH - NAVIGATION_HEIGHT);
            [self.payV.weixin addTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
            [self.payV.zhifubao addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.payV];
        }
        self.payV.hidden = NO;
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    return view;
}
/**
 * 微信支付
 */
- (void)weixinPay{
    // TODO: 微信支付
    
    
    
    self.payV.hidden = YES;
}
/**
 * 阿里支付
 */
- (void)aliPay{
    // TODO: 支付宝支付
    
    
    
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



@end
