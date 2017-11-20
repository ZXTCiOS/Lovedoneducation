//
//  LiveKeqiankehouVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveKeqiankehouVC.h"
#import <ZFDownloadManager.h>

@interface LiveKeqiankehouVC ()

@property (nonatomic) UIImageView *bgImg;
@property (nonatomic) UIButton *back;
@property (nonatomic) UILabel *title_course;
@property (nonatomic) UILabel *teacher;
@property (nonatomic) UILabel *time;
@property (nonatomic, strong) UIButton *down;

@end

@implementation LiveKeqiankehouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIImageView *)bgImg{
    if (_bgImg) {
        _bgImg = [[UIImageView alloc] init];
        [self.view addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(_bgImg.mas_width).multipliedBy(2/3.0);
        }];
        [_bgImg sd_setImageWithURL:[NSURL URLWithString:self.model.cdimg] placeholderImage:[UIImage imageNamed:@""]];
    }
    return _bgImg;
}

- (UIButton *)back{
    if (!_back) {
        _back = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_back];
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImg.mas_top).equalTo(33);
            make.size.equalTo(CGSizeMake(10, 18));
            make.left.equalTo(12);
        }];
    }
    return _back;
}

- (UILabel *)title_course{
    if (!_title_course) {
        _title_course = [UILabel new];
        [self.view addSubview:_title_course];
        [_title_course mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(self.bgImg.mas_centerY).equalTo(-18);
        }];
        _title_course.textColor = [UIColor whiteColor];
        _title_course.font = [UIFont systemFontOfSize:23];
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
            make.centerY.equalTo(self.bgImg.mas_centerY).equalTo(12);
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
            make.top.equalTo(self.bgImg.mas_bottom).equalTo(120);
        }];
        _time.numberOfLines = 0;
        _time.font = [UIFont systemFontOfSize:23];
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
        //ZFDownloadManager *manager = [ZFDownloadManager sharedDownloadManager];
        
        [_down setTitle:@"下载讲义" forState:UIControlStateNormal];
        [_down setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _down.backgroundColor = krgb(8, 210, 178);
        [_down addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    }
    return _down;
}

- (void)download{
    ZFDownloadManager *manager = [ZFDownloadManager sharedDownloadManager];
    [manager downFileUrl:@"" filename:@"" fileimage:[UIImage imageNamed:@""] extention:self.model];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
