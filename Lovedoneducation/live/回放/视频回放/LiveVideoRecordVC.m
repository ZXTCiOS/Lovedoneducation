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

/*
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    
    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
        //...视频下载完毕操作
    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        /*
         [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
         NSLog(@is download：%f, (float)totalBytesRead/totalBytesExpectedToRead);
         }];
         */
/*
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *audioData = [NSData dataWithContentsOfFile:fileName];
            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            //...视频下载完毕操作
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //下载失败
            //...视频下载失败操作
        }];
        
        [operation start];
    }
}
*/



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
