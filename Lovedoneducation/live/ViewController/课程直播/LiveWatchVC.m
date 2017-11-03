//
//  LiveWatchVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveWatchVC.h"
//#import "ZFPlayerView.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
//#import "NTESWhiteboardCommand.h"
//#import "NTESWhiteboardCmdHandler.h"
#import "NTESWhiteboardLines.h"
#import "NTESWhiteboardDrawView.h"




#define kTimeInterval 0.06

@interface LiveWatchVC ()<UITableViewDelegate, UITableViewDataSource, NIMRTSConferenceManagerDelegate, NTESMeetingRTSManagerDelegate, NTESWhiteboardCmdHandlerDelegate, NIMLoginManagerDelegate, NIMNetCallManagerDelegate>



// 白板

@property (nonatomic, strong) NTESWhiteboardDrawView *drawView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NIMRTSConference *conference;
@property (nonatomic, strong) NTESWhiteboardCmdHandler *cmdHander;
@property (nonatomic, strong) NTESWhiteboardLines *lines;

// 聊天室
@property (nonatomic, strong) UITableView *chatView;

NIMNetCallManagerDelegate

@property (nonatomic, strong) NSMutableArray *datalist;

@end

@implementation LiveWatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datalist = [NSMutableArray array];
    
    //[self configZFPlayer];
    self.timer = [NSTimer timerWithTimeInterval:kTimeInterval block:^(NSTimer * _Nonnull timer) {
        NIMRTSConferenceData *data = [[NIMRTSConferenceData alloc] init];
        //TODO: 定时发送 data
        //data.data
        [[NIMAVChatSDK sharedSDK].rtsConferenceManager sendRTSData:data];
    } repeats:YES];
    
    
}

#pragma mark - RTS  conference delegate
/**
 * 预定多人会话
 */
- (void)reserveConference{
    NIMRTSConference *conference = [[NIMRTSConference alloc] init];
    conference.name = @"name";
    conference.ext = @"extention";
    conference.serverRecording = YES;
    self.conference = conference;
    [[NIMAVChatSDK sharedSDK].rtsConferenceManager reserveConference:conference];
}

- (void)joinConference{
    
    self.conference.serverRecording = YES;
    self.conference.dataHandler = ^(NIMRTSConferenceData * _Nonnull data) {
        NSLog(@"did receive conference data");
        //TODO: 处理 data 数据
        
    };
    [[NIMAVChatSDK sharedSDK].rtsConferenceManager joinConference:self.conference];
}

/**
 *
 */

- (void)onReserveConference:(NIMRTSConference *)conference result:(NSError *)result{
    if (!result) NSLog(@"服务器接受预定多人会话");
}

- (void)onJoinConference:(NIMRTSConference *)conference result:(NSError *)result{
    if (!result) NSLog(@"服务器接收加入多人会话");
}

- (void)onLeftConference:(NIMRTSConference *)conference error:(NSError *)error{
    //某些异常情况发生导致会话断开时，SDK 通过该回调通知应用。
    NSLog(@"异常导致会话断开  error:%@", error);
}

- (void)onUserJoined:(NSString *)uid conference:(NIMRTSConference *)conference{
    
}
- (void)onUserLeft:(NSString *)uid conference:(NIMRTSConference *)conference reason:(NIMRTSConferenceUserLeaveReason)reason{
    
}

#pragma mark - 文档转码

// 拉取文档
- (void)fetchMyDocumentsInfo:(NSString *) lastDocID limit:(NSInteger) limit{
    [[NIMSDK sharedSDK].docTranscodingManager fetchMyDocsInfo:lastDocID limit:limit completion:^(NSError * _Nullable error, NSArray<NIMDocTranscodingInfo *> * _Nullable infos) {
        if (error) NSLog(@"拉取文档失败");
        return;
        
        
    }];
}
// 查询文档
- (void)inquirDocumentInfo:(NSString *) docID{
    [[NIMSDK sharedSDK].docTranscodingManager inquireDocInfo:docID completion:^(NSError * _Nullable error, NIMDocTranscodingInfo * _Nullable info) {
        
    }];
}






- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NIMAVChatSDK sharedSDK].rtsConferenceManager leaveConference:self.conference];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}




















#pragma mark - table view delegate , datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

#pragma mark - lazy loading

- (UITableView *)chatView{
    if (!_chatView) {
        _chatView = [[UITableView alloc] init];
        [self.view addSubview:_chatView];
        [_chatView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        _chatView.delegate = self;
        _chatView.dataSource = self;
    }
    return _chatView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
