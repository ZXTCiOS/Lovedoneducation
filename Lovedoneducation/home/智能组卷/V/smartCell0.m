//
//  smartCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell0.h"

@interface smartCell0()
{
    dispatch_source_t timer;
}
@property (nonatomic,strong) UILabel *numberlab;
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic) BOOL isStart;
@property (nonatomic) BOOL isPause;
@property (nonatomic) BOOL isCreat;
@property (nonatomic,assign) int timeCount;
@end

@implementation smartCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _timeCount = 0;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [self.contentView addSubview:self.numberlab];
        [self.contentView addSubview:self.rightbtn];
        [self.contentView addSubview:self.timelab];
        [self setuolayout];
        [self startCount];
    }
    return self;
}

-(void)setuolayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.numberlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 20)
    .widthIs(100)
    .heightIs(20);
    
    weakSelf.rightbtn
    .sd_layout
    .rightSpaceToView(weakSelf.contentView, 20)
    .widthIs(18)
    .heightIs(18)
    .topSpaceToView(weakSelf.contentView, 20);
    
    weakSelf.timelab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 120)
    .rightSpaceToView(weakSelf.contentView, 120)
    .heightIs(20)
    .topSpaceToView(weakSelf.contentView, 20);
    
    [self setupAutoHeightWithBottomView: weakSelf.rightbtn bottomMargin:20];
}

#pragma mark - getters


-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
        _numberlab.font = [UIFont systemFontOfSize:15];
    }
    return _numberlab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"datika_icon"] forState:normal];
    }
    return _rightbtn;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textAlignment = NSTextAlignmentCenter;
        _timelab.font = [UIFont systemFontOfSize:19];
        _timelab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
        _timelab.text = @"00:00";
    }
    return _timelab;
}

#pragma marm - 实现方法

/**
 开始倒计时方法
 */
-(void)startCount
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    _isCreat = YES;
    
    //    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        int hours = _timeCount / 3600;
        int minutes = (_timeCount - (3600*hours)) / 60;
        int seconds = _timeCount%60;
        NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //           ======在这根据自己的需求去刷新UI==============
            _timelab.text = strTime;
            
        });
        _timeCount ++;
    });
    
    dispatch_resume(timer);
}

-(void)setdata:(NSString *)numstr andallstr:(NSString *)allnum
{
    self.numberlab.text = [NSString stringWithFormat:@"%@%@%@",numstr,@"/",allnum];
}

@end
