//
//  MyCourseViewController.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MyCourseViewController.h"
#import "LiveCourseCell.h"
#import "LiveModel.h"
#import "FSCalendar.h"
#import "LiveCourseDetailVC.h"


typedef NS_ENUM(NSUInteger, MyCourseState) {
    MyCourseStateAll,
    MyCourseStateCalendar,
};

CGFloat calendar_height = 230;

@interface MyCourseViewController ()<UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray<LiveMyCourseModel *> *datalist;
@property (nonatomic, strong) NSMutableArray<LiveMyCourseModel *> *calendarList;
@property (nonatomic, assign) MyCourseState state;
@property (nonatomic, strong) UIButton *kuBtn;
@property (nonatomic, strong) UIButton *calBtn;
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) NSDate *selectDate;
@end

@implementation MyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的课程";
    [self networking];
    [self configTopview];
    self.state = MyCourseStateAll;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveCourseCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([LiveCourseCell class])];
    
}

- (void)configTopview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 44)];
    if (@available(ios 11.0, *)) {
        view.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 44);
    }
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *ku = [UIButton buttonWithType:UIButtonTypeCustom];
    [ku setTitle:@"课程库" forState:UIControlStateNormal];
    [ku setTitleColor:krgb(144, 144, 144) forState:UIControlStateNormal];
    [ku setTitleColor:krgb(255, 155, 25) forState:UIControlStateDisabled];
    ku.titleLabel.font = [UIFont systemFontOfSize:16];
    [ku addTarget:self action:@selector(kuClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *calendar = [UIButton buttonWithType:UIButtonTypeCustom];
    [calendar setTitle:@"课程日历" forState:UIControlStateNormal];
    [calendar setTitleColor:krgb(144, 144, 144) forState:UIControlStateNormal];
    [calendar setTitleColor:krgb(255, 155, 25) forState:UIControlStateDisabled];
    calendar.titleLabel.font = [UIFont systemFontOfSize:16];
    [calendar addTarget:self action:@selector( calendarClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreenW/2.0, 10, 1, 24)];
    line.backgroundColor = krgb(229, 229, 229);
    [view addSubview:line];
    
    ku.frame = CGRectMake(0, 0, kScreenW/2.0 - 1, 44);
    calendar.frame = CGRectMake(kScreenW/2.0 + 1, 0, kScreenW/ 2.0 + 1, 44);
    self.kuBtn = ku;
    self.calBtn = calendar;
    [view addSubview:ku];
    [view addSubview:calendar];
    self.kuBtn.enabled = NO;
}

- (void)kuClicked:(UIButton *) sender{
    
    if (self.state == MyCourseStateAll) return;
    self.state = MyCourseStateAll;
    self.kuBtn.enabled = NO;
    self.calBtn.enabled = YES;
    [self.tableView reloadData];
    
}
- (void)calendarClicked:(UIButton *) sender{
    if (self.state == MyCourseStateCalendar) return;
    self.state = MyCourseStateCalendar;
    self.kuBtn.enabled = YES;
    self.calBtn.enabled = NO;
    [self.tableView reloadData];
}


- (void)networking{
    
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    [DNNetworking getWithURLString:get_wodekecheng parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            self.datalist = [LiveMyCourseModel parse:[obj objectForKey:@"data"]];
            [self.tableView reloadData];
        } else if ([code isEqualToString:@"201"]){
            [self.view showWarning:@"您还没有购买课程哦~"];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"wukecheng_icon"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *string = @"您还没有购买课程";
    if (self.state == MyCourseStateAll) {
        string = @"您还没有购买课程";
    } else {
        string = @"今天没有课程哦";
    }
    
    UIFont *font = [UIFont systemFontOfSize:16];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FSCalendar  delegate, datasource

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//    return date;
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    NSInteger count = 0;
    NSTimeInterval selectTime = [date timeIntervalSince1970];
    for (LiveMyCourseModel *model in self.datalist) {
        for (NSString *time in model.ymdhis) {
            NSTimeInterval courseTime = [time integerValue];
            NSTimeInterval diff = courseTime - selectTime;
            if (diff > 0 && diff < 24 * 60 * 60) {
                count++;
            }
        }
    }
    return count;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    if ([self.selectDate timeIntervalSince1970] == [date timeIntervalSince1970]) {
        
        return;
    }
    [self.calendar deselectDate:self.selectDate];
    self.selectDate = date;
    [self.calendar selectDate:date scrollToDate:YES];
    NSTimeInterval selectTime = [date timeIntervalSince1970];
    [self.calendarList removeAllObjects];
    for (LiveMyCourseModel *model in self.datalist) {
        for (NSString *time in model.ymdhis) {
            NSTimeInterval courseTime = [time integerValue];
            NSTimeInterval diff = courseTime - selectTime;
            if (diff > 0 && diff < 24 * 60 * 60) {
                [self.calendarList addObject:model];
            }
            if (model == self.datalist.lastObject) {
                [self.tableView reloadData];
            }
        }
    }
    
}



#pragma mark table view delegate , datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.state == MyCourseStateAll) return self.datalist.count;
    return self.calendarList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveMyCourseModel *model;
    if (self.state == MyCourseStateAll) {
        model = self.datalist[indexPath.row];
    } else {
        model = self.calendarList[indexPath.row];
    }
    LiveCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LiveCourseCell class]) forIndexPath:indexPath];
    cell.titleL.text = model.classs.c_name;
    cell.introL.text = model.classs.c_intro;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    dateformater.dateFormat = @"yyyy.MM.dd";
    NSTimeInterval start = model.classs.c_start_time;
    NSTimeInterval end = model.classs.c_end_time;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
    NSString *startTime = [dateformater stringFromDate:startDate];
    NSString *endTime = [dateformater stringFromDate:endDate];
    cell.timeL.text = [NSString stringWithFormat:@"%@-%@", startTime, endTime];
    cell.count.hidden = YES;
    cell.yiyou.hidden = YES;
    cell.ren.hidden = YES;
    cell.priceL.hidden = YES;//.text = [NSString stringWithFormat:@"¥%@", model.c_price];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.state == MyCourseStateAll) return nil;
    return self.calendar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.state == MyCourseStateAll) return 0.1;
    return calendar_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LiveMyCourseModel *model;
    if (self.state == MyCourseStateAll) {
        model = self.datalist[indexPath.row];
    } else {
        model = self.calendarList[indexPath.row];
    }
    LiveCourseModel *m = model.classs;
    m.isbuy = @"1";
    m.teacher = model.teacher;
    LiveCourseDetailVC *vc = [[LiveCourseDetailVC alloc] init];
    vc.model = m;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy load

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+44, kScreenW, kScreenH - 44-64) style:UITableViewStyleGrouped];
        if (@available( ios 11.0, *)) {
            _tableView.frame = CGRectMake(0, 44 + NAVIGATION_HEIGHT, kScreenW, kScreenH - 44 - NAVIGATION_HEIGHT);
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, calendar_height)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = [UIColor whiteColor];
        [_calendar selectDate:[NSDate dateWithTimeIntervalSinceNow:0] scrollToDate:YES];
        [self.view addSubview:_calendar];
        _calendar.appearance.todaySelectionColor = krgb(8, 210, 178);
        _calendar.appearance.todayColor = [UIColor redColor];
        _calendar.appearance.headerTitleColor = krgb(8, 210, 178);
        _calendar.appearance.weekdayTextColor = krgb(8, 210, 178);
        
        _calendar.appearance.headerDateFormat = @"yyyy.MM";
        _calendar.appearance.selectionColor = krgb(8, 210, 178);
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
    }
    return _calendar;
}

- (NSArray<LiveMyCourseModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<LiveMyCourseModel *> array];
    }
    return _datalist;
}

- (NSArray<LiveMyCourseModel *> *)calendarList{
    if (!_calendarList) {
        _calendarList = [NSMutableArray<LiveMyCourseModel *> array];
    }
    return _calendarList;
}

@end
