//
//  LiveKeqiankehouVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header LiveKeqiankehouVC.m
 
 @brief 课程状态详情页面.m
 
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */
#import "LiveKeqiankehouVC.h"
//#import <ZFDownloadManager.h>
#import "HTTPSessionShare.h"
#import "FileModel.h"
#import "NSObject+FileDBManager.h"

@interface LiveKeqiankehouVC ()

/*! 背景图片 */
@property (nonatomic) UIImageView *bgImg;

@property (nonatomic) UIButton *back;
@property (nonatomic) UILabel *title_course;
@property (nonatomic) UILabel *teacher;
@property (nonatomic) UILabel *time;
@property (nonatomic, strong) UIButton *down;
/*! 白板下载地址 */
@property (nonatomic, copy) NSString *wbURL;
/*! 音视频下载地址 */
@property (nonatomic, copy) NSString *FileURL;


@end

@implementation LiveKeqiankehouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursemodel.course = self.model;
    switch (self.state) {
        case CourseStateAfter:
            self.down.enabled = NO; // 获取到下载链接之前 下载按钮 enable = no;
            break;
            case CourseStateBefore:
            self.down.hidden = YES;
        default:
            break;
    }
    [self networking];
    [self layoutview];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self panduanstate];
}
/*! 判断当前下载状态 */
- (void)panduanstate{
    
    FileModel *model;// = [NSObject getFileModeWithFilUrl:self.FileURL];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:HttpShare.downloadingList];
    [arr addObjectsFromArray:HttpShare.diskFileList];
    if (!self.FileURL) return;
    NSArray *file = [self.FileURL componentsSeparatedByString:@"?"];
    for (FileModel *modelll in arr) {
        NSArray *fileee = [modelll.fileUrl componentsSeparatedByString:@"?"];
        if ([file.firstObject isEqualToString:fileee.firstObject]) {
            model = modelll;
        }
    }
    
    
    if (model) {
        switch (model.fileState) {
            case FileDownloaded:
                [self.down setTitle:@"讲义已下载" forState:UIControlStateNormal];
                self.down.enabled = NO;
                break;
            case FileDownloading:
                [self.down setTitle:@"讲义下载中" forState:UIControlStateNormal];
                self.down.enabled = NO;
                break;
            case FileStopDownload:
                [self.down setTitle:@"讲义下载中" forState:UIControlStateNormal];
                self.down.enabled = NO;
                break;
            case FileWillDownload:
                [self.down setTitle:@"讲义下载中" forState:UIControlStateNormal];
                self.down.enabled = NO;
                break;
            default:
                break;
        }
    }
}



- (void)networking{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *cdid = self.model.cdid;
    [DNNetworking getWithURLString:get_videourl parameters:@{@"uid": uid, @"token": token, @"cdid": cdid} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            //NSDictionary *Mezzanine = [data objectForKey:@"Mezzanine"];
            self.wbURL = [data objectForKey:@"whiteboard"]; // gz
            self.FileURL = [data objectForKey:@"video"];    ////  ******.mp3/4
            self.down.enabled = YES;
            [self panduanstate];
            
        } else {
            NSLog(@"...");
        }
    } failure:^(NSError *error) {
        NSLog(@"...");
    }];
}

- (void)layoutview{
    [self bgImg];
    [self back];
    [self title_course];
    [self teacher];
    [self time];
    [self down];
}

- (UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*2/3)];
        [self.view addSubview:_bgImg];
        [_bgImg sd_setImageWithURL:[NSURL URLWithString:self.model.cdimg] placeholderImage:[UIImage imageNamed:@"background_image_lianxizhoubao"]];
    }
    return _bgImg;
}

- (UIButton *)back{
    if (!_back) {
        _back = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_back];
        _back.tintColor = [UIColor whiteColor];
        [_back setImage:[UIImage imageNamed:@"back_white_icon_zhiboweikaishi"] forState:UIControlStateNormal];
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(33);
            make.size.equalTo(CGSizeMake(30, 18));
            make.left.equalTo(8);
        }];
        [_back bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _back;
}

- (UILabel *)title_course{
    if (!_title_course) {
        _title_course = [UILabel new];
        [self.view addSubview:_title_course];
        [_title_course mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo((kScreenW *2/3 - 60)/2);
            make.height.equalTo(23);
        }];
        _title_course.textColor = [UIColor whiteColor];
        _title_course.font = [UIFont systemFontOfSize:24];
        _title_course.text = self.model.cdintro;
        [_title_course sizeToFit];
    }
    return _title_course;
}

- (UILabel *)teacher{
    if (!_teacher) {
        _teacher = [UILabel new];
        [self.view addSubview:_teacher];
        [_teacher mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.title_course.mas_bottom).equalTo(20);
            make.height.equalTo(17);
        }];
        _teacher.font = [UIFont systemFontOfSize:18];
        _teacher.textColor = [UIColor whiteColor];
        _teacher.text = [NSString stringWithFormat:@"讲师: %@", self.model.tname];
        [_teacher sizeToFit];
    }
    return _teacher;
}

- time{
    if (!_time) {
        _time = [[UILabel alloc] init];
        [self.view addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(50);
            make.right.equalTo(-50);
            make.top.equalTo(100 + kScreenW *2/3);
        }];
        _time.numberOfLines = 0;
        _time.font = [UIFont systemFontOfSize:18];
        _time.textColor = krgb(100, 100, 100);
        NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
        dateformater.dateFormat = @"YYYY年MM月dd日HH:mm分";
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[self.model.cdstart_time doubleValue]];
        NSString *d = [dateformater stringFromDate:date];
        _time.text = [NSString stringWithFormat:@"直播将在%@开始，敬请期待!", d];
        if (self.model.isstart == CourseStateAfter) {
            _time.text = @"直播已经结束，请下载观看";
        }
        _time.textAlignment = NSTextAlignmentCenter;
        [_time sizeToFit];
    }
    return _time;
}

- (UIButton *)down{
    if (!_down) {
        _down = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_down];
        [_down mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(75);
            make.right.equalTo(-75);
            make.height.equalTo(44);
            make.bottom.equalTo(-50);
        }];
        
        // TODO: 判断 button title  下载讲义还是观看视频
        [_down setTitle:@"下载讲义" forState:UIControlStateNormal];
        [_down setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _down.backgroundColor = krgb(8, 210, 178);
        [_down addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    }
    return _down;
}

- (void)download{
    NSString *fileurl = self.FileURL;
    NSString *filename = [NSString stringWithFormat:@"%@-%@", self.model.tname, self.model.cdintro];
    //ZFDownloadManager *manager = [ZFDownloadManager sharedDownloadManager];
    LiveCourseModel *model = self.coursemodel;      // 大课 model
    LiveCourseListModel *courseModel = self.model;  // 小课 model
    LiveTeacherModel *teacherModel;
    NSString *teacherID = courseModel.tid;
    for (LiveTeacherModel *teacher in model.teacher) {
        if ([teacher.tid isEqualToString:teacherID]) {
            teacherModel = teacher;
        }
    }
    NSString *type = [[self.FileURL componentsSeparatedByString:@"?"].firstObject componentsSeparatedByString:@"."].lastObject;
    
    NSMutableArray *arrM = [NSMutableArray array];
    if ([type isEqualToString:@"aac"]) {
        FileModel *fileModel = [[FileModel alloc] init];
        fileModel.fileName = [filename stringByAppendingString:@".aac"];
        fileModel.fileUrl = fileurl;
        fileModel.teacherName = teacherModel.tname;
        fileModel.teacherIntro = teacherModel.tsimple;
        fileModel.courseIntro = courseModel.cdintro;
        fileModel.courseTime = courseModel.cdstart_time;
        fileModel.tpic = teacherModel.tpic;
        [arrM addObject:fileModel];
        
        FileModel *fileModel1 = [[FileModel alloc] init];
        fileModel1.fileName = [filename stringByAppendingString:@".gz"];
        fileModel1.fileUrl = self.wbURL;
        fileModel1.teacherName = teacherModel.tname;
        fileModel1.teacherIntro = teacherModel.tsimple;
        fileModel1.courseIntro = courseModel.cdintro;
        fileModel1.courseTime = courseModel.cdstart_time;
        fileModel1.tpic = teacherModel.tpic;
        [arrM addObject:fileModel1];
    } else {
        FileModel *fileModel = [[FileModel alloc] init];
        fileModel.fileName = [filename stringByAppendingString:@".mp4"];
        fileModel.fileUrl = fileurl;
        fileModel.teacherName = teacherModel.tname;
        fileModel.teacherIntro = teacherModel.tsimple;
        fileModel.courseIntro = courseModel.cdintro;
        fileModel.courseTime = courseModel.cdstart_time;
        fileModel.tpic = teacherModel.tpic;
        [arrM addObject:fileModel];
    }
    [HttpShare downloadFileWithFileModelArray:arrM];
    [self panduanstate];
    [self.down setTitle:@"讲义下载中" forState:UIControlStateNormal];
    self.down.enabled = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
