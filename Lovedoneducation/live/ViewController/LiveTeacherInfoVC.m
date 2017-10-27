//
//  LiveTeacherInfoVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveTeacherInfoVC.h"
#import "LiveModel.h"
#import "LiveTeacherListCell.h"
#import "TeacherHistoryCell.h"
#import "LiveEvaluateVC.h"

@interface LiveTeacherInfoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<LiveCourseHistoryModel *> *datalist;
@end

@implementation LiveTeacherInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self networking];
    self.title = @"名师信息";
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveTeacherListCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"teacher"];
    UINib *nib1 = [UINib nibWithNibName:NSStringFromClass([TeacherHistoryCell class]) bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"history"];
    
}

- (void)networking{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *tid = self.model.tid;
    [DNNetworking getWithURLString:get_teacherHistory parameters:@{@"uid": uid, @"token": token, @"tid": tid} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            self.datalist = [LiveCourseHistoryModel parse:[obj objectForKey:@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"服务器错误"];
    }];
}

#pragma mark - tableView  Delegate && dataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        return self.datalist.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) {
        LiveTeacherListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacher" forIndexPath:indexPath];
        [cell.imgV sd_setImageWithURL:self.model.tpic.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang_image_laoshijieshao"]];
        cell.intro.text = self.model.tsimple;
        cell.intro.textColor = [UIColor whiteColor];
        cell.name.text = self.model.tname;
        cell.name.textColor = [UIColor whiteColor];
        cell.detail.text = self.model.tintro;
        cell.detail.textColor = [UIColor whiteColor];
        cell.pingjia .hidden = YES;
        cell.starV.star = [self.model.tscore intValue]/20.0;
        cell.backgroundColor = krgb(8, 210, 208);
        cell.fenL.textColor = [UIColor whiteColor];
        return cell;
    }
    LiveCourseHistoryModel *model = self.datalist[indexPath.row];
    TeacherHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history" forIndexPath:indexPath];
    cell.nameL.text = model.cdintro;
    cell.timeL.text = [self timeStart:model.cdstart_time end:model.cdend_time];
    cell.countL.text = model.comment;
    [cell.pinglunBtn removeAllTargets];
    cell.scoreL.text = [NSString stringWithFormat:@"%.1f", (long)[model.score integerValue]/10.0];
    [cell.pinglunBtn bk_addEventHandler:^(id sender) {
        // TODO: 跳转评论页面
        LiveEvaluateVC *vc = [[LiveEvaluateVC alloc] init];
        vc.model = self.datalist[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)timeStart:(NSString *) starttime end:(NSString *) endtime{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    dateformater.dateFormat = @"yyyy.MM.dd";
    NSTimeInterval start =[starttime doubleValue];
    NSTimeInterval end = [endtime doubleValue];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end];
    NSString *startTime = [dateformater stringFromDate:startDate];
    NSString *endTime = [dateformater stringFromDate:endDate];
     return [NSString stringWithFormat:@"%@-%@", startTime, endTime];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!section) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenH, 70)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 30, 100, 20)];
    [view addSubview:label];
    label.textColor = krgb(50, 50, 50);
    label.text = @"历史课程";
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) return 100;
    CGSize size = [self.model.tintro sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW- 24, 10000) mode:NSLineBreakByWordWrapping];
    return 165 + size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) return 70;
    return 0;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        if (@available(iOS 11.0, *)){
            _tableView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
        }
        else
        {
            _tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        }
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
