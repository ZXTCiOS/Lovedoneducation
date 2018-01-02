//
//  LiveCourseDetailVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveCourseDetailVC.h"
#import "LiveTeacherListCell.h"
#import "LiveCourseListCell.h"
#import "LiveTeacherInfoVC.h"
#import "LiveSubmitOrderVC.h"
#import "NTESMeetingViewController.h"
#import "SVProgressHUD.h"
#import "NTESMeetingManager.h"
#import "UIView+Toast.h"
#import "LiveKeqiankehouVC.h"
#import "NTESMeetingRolesManager.h"

@interface LiveCourseDetailVC ()<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIView *greenV;

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UIButton *course_intro_btn;
@property (weak, nonatomic) IBOutlet UIButton *course_list_btn;
@property (weak, nonatomic) IBOutlet UIButton *course_teacher_btn;

@property (weak, nonatomic) IBOutlet UIView *contentV;

@property (nonatomic, strong) UITableView *courseListView;
@property (nonatomic, strong) UITableView *teacherListView;
@property (nonatomic, strong) UIScrollView *courseIntroView;

@property (nonatomic, strong) NSArray *datalist; // 课程表
@end

@implementation LiveCourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setbtns];
    [self netWorking];
    self.title = @"课程详情";
    
    if (@available(iOS 11.0, *)){
        //self.greenV.frame = CGRectMake(0, 0, kScreenW, 100);
        self.view.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH - 64);
        self.topConstraint.constant = NAVIGATION_HEIGHT;
        [self.greenV setNeedsLayout];
        [self.greenV setNeedsDisplay];
        [self.greenV layoutIfNeeded];
        [self.view setNeedsLayout];
        [self.view setNeedsDisplay];
        [self.view layoutIfNeeded];
    }
    else
    {
        self.view.frame = CGRectMake(0, 64, kScreenW, kScreenH - 64);
        self.topConstraint.constant = 64;
        [self.greenV setNeedsLayout];
        [self.greenV setNeedsDisplay];
        [self.greenV layoutIfNeeded];
        [self.view setNeedsLayout];
        [self.view setNeedsDisplay];
        [self.view layoutIfNeeded];
    }
    if ([self.model.isbuy isEqualToString:@"1"]) {
        [self.buyBtn setTitle:@"进入课程" forState:UIControlStateNormal];
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:self.model.c_intro_img.xd_URL];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imgV = [[UIImageView alloc] init];
            imgV.image = image;
            CGSize size = image.size;
            CGRect frame = self.contentV.frame;
            CGPoint point = CGPointMake(0, 0);
            frame.origin = point;
            _courseIntroView.frame = frame;
            imgV.frame = CGRectMake(0, 0, kScreenW, size.height * kScreenW / size.width);
            [_courseIntroView addSubview:imgV];
            _courseIntroView.contentSize = imgV.frame.size;
        });
    });
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.model.isbuy isEqualToString:@"1"]) {
        [self.buyBtn setTitle:@"进入课程" forState:UIControlStateNormal];
    }
    
}

- (void)netWorking{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *c_id = self.model.c_id;
    [DNNetworking getWithURLString:get_kechengbiao parameters:@{@"uid": uid, @"token": token, @"c_id": c_id} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            self.datalist = [LiveCourseListModel parse:[obj objectForKey:@"data"]];
            [self.courseListView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络异常"];
    }];
}

- (void)setbtns{
    self.course_intro_btn.enabled = NO;
    self.course_list_btn.enabled = YES;
    self.course_teacher_btn.enabled = YES;
    
    self.course_intro_btn.backgroundColor = krgb(8, 210, 178);
    self.course_list_btn.backgroundColor = krgb(246, 246, 246);
    self.course_teacher_btn.backgroundColor = krgb(246, 246, 246);
    self.courseIntroView.hidden = NO;
    
    self.courseName.text = self.model.c_name;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    dateformater.dateFormat = @"yyyy.MM.dd";
    NSTimeInterval start = self.model.c_start_time;
    NSTimeInterval end = self.model.c_end_time;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
    NSString *startTime = [dateformater stringFromDate:startDate];
    NSString *endTime = [dateformater stringFromDate:endDate];
    self.timeL.text = [NSString stringWithFormat:@"%@-%@", startTime, endTime];
    
}

#pragma mark - 点击事件

- (IBAction)buyNow:(id)sender {
    if ([self.model.isbuy isEqualToString:@"1"]) {  // 1. 已买
        // 上课去
        NSString *roomid;
        for (LiveCourseListModel *model in self.datalist) {
            if (model.isstart == CourseStateing){
                for (LiveTeacherModel *teacher in self.model.teacher) {
                    if ([model.tid isEqualToString:teacher.tid]) {
                        roomid = teacher.roomid;
                    }
                }
            }
        }
        if (roomid) {
            __weak typeof(self) wself = self;
            NIMChatroomEnterRequest *request = [[NIMChatroomEnterRequest alloc] init];
            request.roomId = roomid;//@"19645919";//19645919  19743991
            [[NSUserDefaults standardUserDefaults] setObject:request.roomId forKey:@"cachedRoom"];
            [[NIMSDK sharedSDK].chatroomManager enterChatroom:request completion:^(NSError *error, NIMChatroom *chatroom, NIMChatroomMember *me) {
                [SVProgressHUD dismiss];
                if (!error) {
                    [[NTESMeetingManager sharedInstance] cacheMyInfo:me roomId:request.roomId];
                    [[NTESMeetingRolesManager sharedInstance] startNewMeeting:me withChatroom:chatroom newCreated:NO];
                    UINavigationController *nav = wself.navigationController;
                    NTESMeetingViewController *vc = [[NTESMeetingViewController alloc] initWithChatroom:chatroom];
                    [nav pushViewController:vc animated:YES];
                    NSMutableArray *vcs = [nav.viewControllers mutableCopy];
                    [vcs removeObject:self];
                    nav.viewControllers = vcs;
                }else {
                    [self.view makeToast:@"进入房间失败，请确认ID是否正确" duration:2.0 position:CSToastPositionCenter];
                }
            }];
        } else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前没有课程直播" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:act];
            [self.navigationController presentViewController:alertC animated:YES completion:nil];
        }
        
        
        
    }else{
        LiveSubmitOrderVC *vc = [[LiveSubmitOrderVC alloc] init];
        vc.model = self.model;
        vc.vc = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
/**
 * // 课程介绍
 */
- (IBAction)jieshao:(UIButton *)sender {
    self.course_intro_btn.enabled = NO;
    self.course_list_btn.enabled = YES;
    self.course_teacher_btn.enabled = YES;
    
    self.course_intro_btn.backgroundColor = krgb(8, 210, 178);
    self.course_list_btn.backgroundColor = krgb(246, 246, 246);
    self.course_teacher_btn.backgroundColor = krgb(246, 246, 246);
    self.courseIntroView.hidden = NO;
    self.courseListView.hidden = YES;
    self.teacherListView.hidden = YES;
}
/**
 * // 课程列表
 */
- (IBAction)courseList:(UIButton *)sender {
    self.course_intro_btn.enabled = YES;
    self.course_list_btn.enabled = NO;
    self.course_teacher_btn.enabled = YES;
    
    self.course_intro_btn.backgroundColor = krgb(246, 246, 246);
    self.course_list_btn.backgroundColor = krgb(8, 210, 178);
    self.course_teacher_btn.backgroundColor = krgb(246, 246, 246);
    self.courseIntroView.hidden = YES;
    self.courseListView.hidden = NO;
    self.teacherListView.hidden = YES;
}
/**
 * // 老师介绍
 */
- (IBAction)teacherIntro:(UIButton *)sender {
    self.course_intro_btn.enabled = YES;
    self.course_list_btn.enabled = YES;
    self.course_teacher_btn.enabled = NO;
    
    self.course_intro_btn.backgroundColor = krgb(246, 246, 246);
    self.course_list_btn.backgroundColor = krgb(246, 246, 246);
    self.course_teacher_btn.backgroundColor = krgb(8, 210, 178);
    self.courseIntroView.hidden = YES;
    self.courseListView.hidden = YES;
    self.teacherListView.hidden = NO;
}

#pragma  mark - tableView  delegate && datasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 200) {// 老师列表
        return self.model.teacher.count;
    } else {
        return self.datalist.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        LiveCourseListModel *model = self.datalist[indexPath.row];
        
        LiveCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"course" forIndexPath:indexPath];
        NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
        dateformater.dateFormat = @"yyyy.MM.dd";
        NSTimeInterval start = [model.cdstart_time doubleValue];
        NSTimeInterval end = [model.cdend_time doubleValue];
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
        NSString *startTime = [dateformater stringFromDate:startDate];
        NSString *endTime = [dateformater stringFromDate:endDate];
        cell.timeL.text = [NSString stringWithFormat:@"%@-%@  (", startTime, endTime];
        cell.nameL.text = [NSString stringWithFormat:@"%@ - %@", model.tname, model.cdintro];
        CGFloat t1 = [model.cdstart_time doubleValue];
        CGFloat t2 = [model.cdend_time doubleValue];
        cell.keshiL.text = [NSString stringWithFormat:@"%ld", (long)(t2-t1)/3600];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    LiveTeacherModel *model = self.model.teacher[indexPath.row];
    LiveTeacherListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
    [cell.imgV sd_setImageWithURL:model.tpic.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang_image_laoshijieshao"]];
    cell.intro.text = model.tsimple;
    cell.name.text = model.tname;
    cell.detail.text = model.tintro;
    [cell.pingjia removeAllTargets];
    [cell.pingjia bk_addEventHandler:^(id sender) {
        // TODO: 跳转 评价页面
    } forControlEvents:UIControlEventTouchUpInside];
    cell.starV.star = [model.tscore intValue]/20.0;
    cell.scoreL.text = [NSString stringWithFormat:@"%.1f", [model.tscore intValue]/10.0];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 200) {// 老师列表
        CGSize size = [self.model.teacher[indexPath.row].tintro sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW- 24, 10000) mode:NSLineBreakByWordWrapping];
        return 165 + size.height; // 可变高度   计算
    } else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 100) {
        LiveKeqiankehouVC *vc = [[LiveKeqiankehouVC alloc] init];
        LiveCourseListModel *model = self.datalist[indexPath.row];
        vc.state = model.isstart;
        vc.model = model;
        vc.coursemodel = self.model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    LiveTeacherInfoVC *vc = [[LiveTeacherInfoVC alloc] init];
    vc.model = self.model.teacher[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark lazy load

- (UITableView *)courseListView{
    if (!_courseListView) {
        CGRect frame = self.contentV.frame;
        CGPoint point = CGPointMake(0, 0);
        frame.origin = point;
        _courseListView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _courseListView.hidden = YES;
        [self.contentV addSubview:_courseListView];
        _courseListView.delegate = self;
        _courseListView.dataSource = self;
        _courseListView.tag = 100;
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveCourseListCell class]) bundle:nil];
        [_courseListView registerNib:nib forCellReuseIdentifier:@"course"];
        _courseListView.tableFooterView = [UIView new];
        _courseListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _courseListView;
}

- (UITableView *)teacherListView{
    if (!_teacherListView) {
        CGRect frame = self.contentV.frame;
        CGPoint point = CGPointMake(0, 0);
        frame.origin = point;
        _teacherListView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _teacherListView.hidden = YES;
        [self.contentV addSubview:_teacherListView];
        _teacherListView.delegate = self;
        _teacherListView.dataSource = self;
        _teacherListView.tag = 200;
        _teacherListView.tableFooterView = [UIView new];
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveTeacherListCell class]) bundle:nil];
        [_teacherListView registerNib:nib forCellReuseIdentifier:@"teacher"];
        _teacherListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _teacherListView;
}

- (UIScrollView *)courseIntroView{
    if (!_courseIntroView) {
        CGRect frame = self.contentV.frame;
        CGPoint point = CGPointMake(0, 0);
        frame.origin = point;
        _courseIntroView = [[UIScrollView alloc] initWithFrame:frame];
        [self.contentV addSubview:_courseIntroView];
        _courseIntroView.hidden = YES;
    }
    return _courseIntroView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib{
    [super awakeFromNib];
    if (@available(iOS 11.0, *)){
        self.greenV.frame = CGRectMake(0, 0, kScreenW, 100);
    }
    else
    {
        self.greenV.frame = CGRectMake(0, 64, kScreenW, 100);
    }
}


@end
