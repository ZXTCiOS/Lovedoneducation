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
    
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    ZFPlayerModel *model = [[ZFPlayerModel alloc] init];
    model.title = @"国考面试班加强无敌阿姆斯特朗电720°回旋飞天意大利磁炮";
    model.videoURL = [NSURL URLWithString:@""];
    model.placeholderImage = [UIImage imageNamed:@""];
    [self.playerView playerControlView:controlView playerModel:model];
    
    //self.playerView.hasDownload = YES;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
