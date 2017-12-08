//
//  LiveVideoRecordVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveVideoRecordVC.h"
#import <ZFPlayer.h>
#import <AFNetworking.h>

@interface LiveVideoRecordVC ()<ZFPlayerDelegate, ZFPlayerControlViewDelagate>

@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;


@end

@implementation LiveVideoRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 强制转为横屏
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    ZFPlayerModel *model = [[ZFPlayerModel alloc] init];
    model.title = @"国考面试班";
    // 获取本地 url
    
    model.videoURL = [NSURL URLWithString:@""];
    model.placeholderImage = [UIImage imageNamed:@""];
    [self.playerView playerControlView:controlView playerModel:model];
    
    
}




- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        [self.view addSubview:self.playerView];
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _playerView.delegate = self;
        [_playerView autoPlayTheVideo];
        
    }
    return _playerView;
}

#pragma mark - 返回
- (void)zf_playerBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 强制旋转屏幕为横屏

- (BOOL)shouldAutorotate
{
    return YES;
}
//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
