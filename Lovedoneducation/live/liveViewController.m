//
//  liveViewController.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header liveViewController.m
 
 @brief 直播首页
 所有课程的列表页, 一个 tableView.
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */

#import "liveViewController.h"
#import "LiveModel.h"
#import "LiveCourseCell.h"
#import "LiveCourseDetailVC.h"
#import "MyCourseViewController.h"
#import "typeVC0.h"

@interface liveViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<LiveCourseModel *> *datalist;
@end

@implementation liveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBar];
    [self tableheaderView];
    [self netWorking];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveCourseCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)configNaviBar{
    //self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = [userDefault objectForKey:user_type];
    UIBarButtonItem *leftItemChange = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"kechengxuanze_icon_nav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftActionChange1)];
    self.navigationItem.leftBarButtonItem = leftItemChange;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]}];
}

- (void)leftActionChange1{
    typeVC0 *vc = [[typeVC0 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableheaderView{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    view.backgroundColor = krgb(8, 210, 178);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 14, 70, 16)];
    label.text = @"我的课程";
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 20, 15.5, 7, 13)];
    imgV.image = [UIImage imageNamed:@"right_button_zhiboshouye"];
    [view addSubview:imgV];
    [view bk_addEventHandler:^(id sender) {
        MyCourseViewController *vc = [[MyCourseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = view;
}

- (void)netWorking{
    MJWeakSelf
    [self.tableView addHeaderRefresh:^{
        [weakSelf headerRefresh];
    }];
    [self.tableView addFooterRefreshAuto:^{
        [weakSelf footerRefresh];
    }];
    // 下拉刷新
    [self.tableView beginHeaderRefresh];
    // 静默请求
    //[self headerRefresh];
}
- (void)headerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    [DNNetworking getWithURLString:get_courselist parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            LiveModel *model = [LiveModel parse:obj];
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:model.data];
            [self.tableView reloadData];
        } else if([code isEqualToString:@"201"]) {
            [self.view showWarning:@"抱歉, 没有课程"];
        }
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络请求失败"];
        [self.tableView endHeaderRefresh];
    }];
}
- (void)footerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *c_id = self.datalist.lastObject.c_id;
    if (!c_id) {
        [self.tableView endFooterRefresh];
        return;
    }
    [DNNetworking getWithURLString:get_courselist parameters:@{@"uid": uid, @"token": token, @"c_id": c_id} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            LiveModel *model = [LiveModel parse:obj];
            [self.datalist addObjectsFromArray:model.data];
            [self.tableView reloadData];
        } else if([code isEqualToString:@"201"]){
            [self.view showWarning:@"到头了, 别扯了..."];
        }
        [self.tableView endFooterRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络请求失败"];
        [self.tableView endFooterRefresh];
    }];
}


#pragma mark tableview delegate & datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count ? 1: 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LiveCourseModel *model = self.datalist[indexPath.row];
    cell.titleL.text = model.c_name;
    cell.introL.text = model.c_intro;
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
    cell.priceL.text = [NSString stringWithFormat:@"%@", model.c_price];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LiveCourseDetailVC *vc = [[LiveCourseDetailVC alloc] initWithNibName:NSStringFromClass([LiveCourseDetailVC class]) bundle:nil];
    vc.model = self.datalist[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark lazy load

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH - NAVIGATION_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        if (@available(iOS 11.0, *)){
            _tableView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
        }
        else
        {
            _tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray<LiveCourseModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<LiveCourseModel *> array];
    }
    return _datalist;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
