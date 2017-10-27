//
//  LiveEvaluateVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveEvaluateVC.h"
#import "TeacherHistoryCell.h"
#import "LiveEvalutateCell.h"

@interface LiveEvaluateVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<LiveEvaluateModel *> *datalist;
@property (nonatomic, strong) NSString *count;
@end

@implementation LiveEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = @"0";
    [self networking];
    self.title = @"评价";
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LiveEvalutateCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"evaluate"];
    UINib *nib1 = [UINib nibWithNibName:NSStringFromClass([TeacherHistoryCell class]) bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"history"];
    
}

- (void)networking{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *tid = self.model.tid;
    NSString *cdid = self.model.cdid;
    [DNNetworking getWithURLString:get_pingjia parameters:@{@"uid": uid, @"token": token, @"tid": tid, @"cdid": cdid} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            self.datalist = [LiveEvaluateModel parse:[data objectForKey:@"comment"]];
            self.count = [NSString stringWithFormat: @"%@",  [data objectForKey:@"num"]];
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
        TeacherHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"history" forIndexPath:indexPath];
        cell.nameL.text = self.model.cdintro;
        cell.nameL.textColor = [UIColor whiteColor];
        cell.timeL.hidden = YES;//text = [self timeStart:self.model.cdstart_time end:self.model.cdend_time];
        cell.timeL.textColor = [UIColor whiteColor];
        cell.countL.text = self.count;
        cell.countL.textColor = [UIColor whiteColor];
        //[cell.pinglunBtn removeAllTargets];
        cell.fenL.textColor = [UIColor whiteColor];
        cell.renL.text = @"人参与评论";
        cell.renL.textColor = [UIColor whiteColor];
        cell.pinglunBtn.hidden = YES;
        cell.img_naozhong.hidden = YES;
        cell.backgroundColor = krgb(8, 210, 208);
        cell.scoreL.text = [NSString stringWithFormat:@"%.1f", (long)[self.model.score integerValue]/10.0];
        cell.scoreL.textColor = [UIColor whiteColor];
        cell.starV.star = [self.model.score integerValue]/20.0;
        return cell;
    }
    LiveEvaluateModel *model = self.datalist[indexPath.row];
    LiveEvalutateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"evaluate" forIndexPath:indexPath];
    cell.nameL.text = model.uname;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    dateformater.dateFormat = @"yyyy.MM.dd HH:MM";
    NSTimeInterval start =[model.ctime doubleValue];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start];
    NSString *startTime = [dateformater stringFromDate:startDate];
    cell.timeL.text = startTime;
    cell.scoreL.text = [NSString stringWithFormat:@"%.1f", (long)[model.cscore integerValue]/10.0];
    cell.starV.star = [model.cscore integerValue]/20.0;
    cell.pingjiaL.text = model.ccontent;
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
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!section) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenH, 70)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 30, 100, 20)];
    [view addSubview:label];
    label.textColor = krgb(50, 50, 50);
    label.text = @"最新评论";
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) return 75;
    CGSize size = [self.datalist[indexPath.row].ccontent sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW- 24, 10000) mode:NSLineBreakByWordWrapping];
    return 87 + size.height;
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
