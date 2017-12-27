//
//  LievWhiteboardRecoredVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LievWhiteboardRecoredVC.h"
#import "NVHTarGzip.h"

#import "NTESWhiteboardLines.h"
#import "NTESWhiteboardPoint.h"
#import "NTESWhiteboardCommand.h"
#import "NTESWhiteboardDrawView.h"
#import "NTESDocDownloadManager.h"
#import "NTESDocumentShareInfo.h"
#import "NTESDocumentHandler.h"

#import <ZFPlayer.h>


@interface LievWhiteboardRecoredVC ()<ZFPlayerDelegate, ZFPlayerControlViewDelagate, NTESDocumentHandlerDelegate>

@property (nonatomic, strong) UIView *wbView;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) id timeobserver;

@property (nonatomic, strong) NTESWhiteboardDrawView *drawView;
@property (nonatomic, strong) NTESWhiteboardLines *lines;
@property (nonatomic, strong) UIView *laserView;
@property (nonatomic, strong) UIImageView *docView;
@property (nonatomic, strong) NIMDocTranscodingInfo *docInfo;
@property (nonatomic, strong) NSMutableDictionary *docInfoDic;
@property (nonatomic, strong) NTESDocumentHandler *docHander;
@property (nonatomic) int currentPage;

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSInteger wbTime;
@end

@implementation LievWhiteboardRecoredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 强制转为横屏
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    self.view.backgroundColor = [UIColor whiteColor];
    [self playerInit];  // .mp3
    if (!self.isMP4){
        [self configInit];
        
    }
    // 解压文件
    if (!self.isMP4) {
        [self unGZip];      // .gz
    }
    self.location = 0;
}

- (void)configInit{
    _docHander = [[NTESDocumentHandler alloc]initWithDelegate:self];
    self.lines = [[NTESWhiteboardLines alloc] init];
    [self drawView];
    self.docInfoDic = [NSMutableDictionary dictionary];
    self.wbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.playerView insertSubview:self.wbView belowSubview:self.playerView.controlView];
    //[self.wbView addSubview:self.docView];
    [self.wbView addSubview:self.drawView];
    //[self.wbView addSubview:self.laserView];
    [self.drawView addSubview:self.docView];
    [self.drawView addSubview:self.laserView];
    self.docView.hidden = YES;
    self.laserView.hidden = YES;
    CGFloat width = kScreenW;
    CGFloat height = kScreenH;
    CGRect frame;
    //(width - (height *4 / 3.0))/2.0
    frame = CGRectMake(0, 0, height *4 / 3.0, height);
    self.wbView.frame = frame;
    self.docView.frame = frame;
}

- (void)unGZip{
    //NSArray *arr = [self.wbPath componentsSeparatedByString:@"."];
    NSString *filepath;
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *name = self.titlename;
    NSString *toPath = [documentPath stringByAppendingString:name];
    filepath = [documentPath stringByAppendingPathComponent:self.wbPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:toPath]){
        NSData *data = [NSData dataWithContentsOfFile:toPath];
        self.data = data;
        [self.playerView play];
    } else {
        [[NVHTarGzip sharedInstance] unGzipFileAtPath:filepath toPath:toPath completion:^(NSError *error)
         {
             NSLog(@"%@", error);
             NSData *data = [NSData dataWithContentsOfFile:toPath];
             self.data = data;
             [self.playerView play];
         }];
    }
    
}

- (void)playerInit{
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    ZFPlayerModel *model = [[ZFPlayerModel alloc] init];
    model.fatherView = self.view;
    model.title = self.titlename;
    // 获取本地 url
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *videoFilePath = [documentPath stringByAppendingPathComponent:self.audioPath];
    
    NSArray *arr = [self.audioPath componentsSeparatedByString:@"."];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:arr.firstObject ofType:arr.lastObject];
    NSData *data = [NSData dataWithContentsOfFile:videoFilePath];
    model.videoURL = [NSURL fileURLWithPath:videoFilePath];
    model.placeholderImage = [UIImage imageNamed:@""];
    [self.playerView playerControlView:controlView playerModel:model];
    [self.playerView autoPlayTheVideo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)parseComond:(NSData *)data{
    
    NSString *cmdsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *cmdsArray = [cmdsString componentsSeparatedByString:@";"];
    
    for (NSString *cmdString in cmdsArray) {
        
        if (cmdString.length == 0) {
            continue;
        }
        
        NSArray *cmd = [cmdString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":,"]];
        
        NSInteger type = [cmd[0] integerValue];
        switch (type) {
            case NTESWhiteBoardCmdTypePointStart:
            case NTESWhiteBoardCmdTypePointMove:
            case NTESWhiteBoardCmdTypePointEnd:
            {
                if (cmd.count == 4) {
                    NTESWhiteboardPoint *point = [[NTESWhiteboardPoint alloc] init];
                    point.type = type;
                    point.xScale = [cmd[1] floatValue];
                    point.yScale = [cmd[2] floatValue];
                    point.colorRGB = [cmd[3] intValue];
                    
                    [_lines addPoint:point uid:@"123"];
                }
                else {
                    DDLogError(@"Invalid point cmd: %@", cmdString);
                }
                break;
            }
            case NTESWhiteBoardCmdTypeCancelLine:
            case NTESWhiteBoardCmdTypeClearLines:
            case NTESWhiteBoardCmdTypeClearLinesAck:
            case NTESWhiteBoardCmdTypeSyncPrepare:
            {
                
                    [self onReceiveCmd:type from:nil];
                
                break;
            }
            case NTESWhiteBoardCmdTypeSyncRequest:
            {
                
                [self onReceiveSyncRequestFrom:nil];
                
                break;
            }
            case NTESWhiteBoardCmdTypeSync:
            {
//                NSString *linesOwner = cmd[1];
//                int end = [cmd[2] intValue];
//                [self handleSync:cmdsArray linesOwner:linesOwner end:end sender:sender];
                return;
            }
            case NTESWhiteBoardCmdTypeLaserPenMove:
            {
                NTESWhiteboardPoint *point = [[NTESWhiteboardPoint alloc] init];
                point.type = type;
                point.xScale = [cmd[1] floatValue];
                point.yScale = [cmd[2] floatValue];
                point.colorRGB = [cmd[3] intValue];
                
                [self onReceiveLaserPoint:point from:nil];
                
                break;
            }
            case NTESWhiteBoardCmdTypeLaserPenEnd:
            {
                
                [self onReceiveHiddenLaserfrom:nil];
                
                break;
            }
            case NTESWhiteBoardCmdTypeDocShare:
            {
                [self handleReceivedDocShareData:cmd sender:@"123"];
                break;
            }
                
            default:
                break;
        }
    }
    
    
}

-(void)handleReceivedDocShareData:(NSArray *)cmd sender:(NSString *)sender
{
    NTESDocumentShareInfo *shareInfo = [[NTESDocumentShareInfo alloc]init];
    shareInfo.docId = cmd[1];
    shareInfo.currentPage = [cmd[2]intValue];
    shareInfo.pageCount = [cmd[3]intValue];
    shareInfo.type = [cmd[4]intValue];
    
    [self onReceiveDocShareInfo:shareInfo from:@"123"];
    
}

- (void)onReceiveCmd:(NTESWhiteBoardCmdType)type from:(NSString *)sender
{
    if (type == NTESWhiteBoardCmdTypeCancelLine) {
        [_lines cancelLastLine:sender];
    }
    else if (type == NTESWhiteBoardCmdTypeClearLines) {
        [_lines clear];
        //[_cmdHander sendPureCmd:NTESWhiteBoardCmdTypeClearLinesAck to:nil];
    }
    else if (type == NTESWhiteBoardCmdTypeClearLinesAck) {
        [_lines clearUser:sender];
    }
    else if (type == NTESWhiteBoardCmdTypeSyncPrepare) {
        [_lines clear];
        //[_cmdHander sendPureCmd:NTESWhiteBoardCmdTypeSyncPrepareAck to:sender];
    }
}

- (void)onReceiveSyncRequestFrom:(NSString *)sender
{
    
        //[_cmdHander sync:[_lines allLines] toUser:sender];
        if (!self.docView.hidden) {
            [self onSendDocShareInfoToUser:sender];
        }
    
}

- (void)onReceiveSyncPoints:(NSMutableArray *)points owner:(NSString *)owner
{
    [_lines clearUser:owner];
    
    for (NTESWhiteboardPoint *point in points) {
        [_lines addPoint:point uid:owner];
    }
}

- (void)onReceiveLaserPoint:(NTESWhiteboardPoint *)point from:(NSString *)sender
{
    [self.laserView setHidden:NO];
    CGPoint p = CGPointMake(point.xScale * self.drawView.frame.size.width , point.yScale * self.drawView.frame.size.height);
    self.laserView.center = p;
}

-(void)onReceiveHiddenLaserfrom:(NSString *)sender
{
    [self.laserView setHidden:YES];
}

-(void)onReceiveDocShareInfo:(NTESDocumentShareInfo *)shareInfo from:(NSString *)sender
{
    self.currentPage = shareInfo.currentPage;
    if (shareInfo.currentPage == 0) {
        self.drawView.backgroundColor = [UIColor whiteColor];
        //[self.pageNumLabel setHidden:YES];
        return;
    }
    if (![self.docInfoDic objectForKey:shareInfo.docId])
    {
        [_docHander inquireDocInfo:shareInfo.docId];
    }
    else
    {
        self.docInfo = [self.docInfoDic objectForKey:shareInfo.docId];
        [self showDocOnStdWhiteboard];
    }
}

#pragma mark - NTESDocumentHandlerDelegate
-(void)notifyGetDocInfo:(NIMDocTranscodingInfo *)docInfo
{
    self.docInfo = docInfo;
    //self.pageNumLabel.text = [NSString stringWithFormat:@"%d/%lu",_currentPage,(unsigned long)_docInfo.numberOfPages];
    //[self.pageNumLabel sizeToFit];
    [self.docInfoDic setObject:docInfo forKey:docInfo.docId];
    [self showDocOnStdWhiteboard];
}

#pragma mark - NTESDocumentViewControllerDelegate
-(void)showDocOnWhiteboard:(NIMDocTranscodingInfo *)info
{
    self.docInfo = info;
    self.docView.hidden = NO;
    self.currentPage = 1;
    [self loadImageOnWhiteboard];
    
//    self.pageNumLabel.hidden = NO;
//    self.nextButton.hidden = NO;
//    self.previousButton.hidden = NO;
//    self.closeDocButton.hidden = NO;
    self.drawView.backgroundColor = [UIColor clearColor];
}

- (void)showDocOnStdWhiteboard
{
    NSString * url= [self.docInfo transcodedUrl:_currentPage ofQuality:NIMDocTranscodingQualityMedium];
    [self.docView sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.docView setHidden:NO];
    //[self.pageNumLabel setHidden:NO];
    self.drawView.backgroundColor = [UIColor clearColor];
}

- (void)onSendDocShareInfoToUser:(NSString*)sender{
    
    NTESDocumentShareInfo *shareInfo = [[NTESDocumentShareInfo alloc]init];
    shareInfo.docId = self.docInfo.docId;
    shareInfo.currentPage = _currentPage;
    shareInfo.pageCount = (int)self.docInfo.numberOfPages;
    shareInfo.type = NTESDocShareTypeTurnThePage;
    
    //[_cmdHander sendDocShareInfo:shareInfo toUser:sender];
}

#pragma mark - NIMLoginManagerDelegate


#pragma mark - private method
-(void)loadImageOnWhiteboard
{
    NSString *filePath = [self getFilePathWithPage:_currentPage];
    UIImage* image = [self loadImage:filePath];
    //重新下载
    if (!image) {
        //[self.imgloadLabel setHidden:NO];
        __weak typeof(self) weakself = self;
        [[NTESDocDownloadManager sharedManager]downLoadDoc:self.docInfo page:_currentPage completeBlock:^(NSError *error) {
            if (!error) {
                UIImage *image = [weakself loadImage:filePath];
                //[weakself.imgloadLabel setHidden:YES];
                [weakself.docView setImage:image];
            }
            else
            {
                //加载失败
                //[weakself.imgloadLabel setText:@"加载失败"];
                //[weakself.imgloadLabel setHidden:NO];
            }
        }];
    }
    else
    {
        //[self.imgloadLabel setHidden:YES];
        [self.docView setImage:image];
    }
    [self onSendDocShareInfoToUser:nil];
}

-(NSString *)getFilePathWithPage:(NSInteger)pageNum
{
    NSString *filePath = [[NTESDocumentHandler getFilePathPrefix:self.docInfo.docId]stringByAppendingString:[NSString stringWithFormat:@"%@_%zd.png",self.docInfo.docName,pageNum]];
    
    return filePath;
}

-(UIImage *)loadImage:(NSString*)filePath{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSData * data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    return nil;
}








- (UIImageView*)docView
{
    if (!_docView) {
        CGFloat width = kScreenW;
        CGFloat height = kScreenH;
        CGRect frame;
        
        frame = CGRectMake((width - height *4 / 3)/2, 0, height *4 / 3, height);
        _docView = [[UIImageView alloc]initWithFrame:frame];
        _docView.contentMode = UIViewContentModeScaleAspectFit;
        _docView.backgroundColor = [UIColor whiteColor];
    }
    return _docView;
}

- (UIView *)drawView
{
    if (!_drawView) {
        CGFloat width = kScreenW;
        CGFloat height = kScreenH;
        CGRect frame;
        
        frame = CGRectMake((width - height *4 / 3)/2, 0, height *4 / 3, height);
        
        _drawView = [[NTESWhiteboardDrawView alloc] initWithFrame:frame];
        _drawView.backgroundColor = [UIColor whiteColor];
        _drawView.layer.borderWidth = 1;
        _drawView.layer.borderColor = UIColorFromRGB(0xd7dade).CGColor;
        _drawView.dataSource = _lines;
    }
    return _drawView;
}

- (UIView *)laserView
{
    if (!_laserView) {
        _laserView = [[UIView alloc]initWithFrame:CGRectZero];
        _laserView.width = 7;
        _laserView.height = 7;
        _laserView.backgroundColor = [UIColor redColor];
        _laserView.layer.cornerRadius = 3.5;
        _laserView.layer.masksToBounds = YES;
    }
    return _laserView;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        [self.view addSubview:_playerView];
        
//        [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(0);
//        }];
        _playerView.delegate = self;
    }
    return _playerView;
}

#pragma mark - 返回
- (void)zf_playerBackAction{
    [self.playerView.player removeTimeObserver:self.timeobserver];
    [self.playerView resetPlayer];
    [self.playerView removeFromSuperview];
    [self.playerView bk_removeAllBlockObservers];
    self.playerView = nil;
    [self.navigationController popViewControllerAnimated:NO];
    //[self.navigationController popViewControllerAnimated:NO];
}

/*
 * 解析解压后的服务器录制文件
 */
- (void)parseData:(NSData *)data atSeconds:(NSInteger) seconds{
    
    NSInteger location = self.location;
    if ((location + 8 < data.length) && (self.wbTime < seconds)) {
        // 获取 包长
        NSData *bagLengthData = [data subdataWithRange:NSMakeRange(location, 4)];
        int baglength;
        [bagLengthData getBytes: &baglength length: sizeof(4)];
        // 获取 时间戳
        NSData *timeData = [data subdataWithRange:NSMakeRange(location + 4 , 4)];
        int time;
        [timeData getBytes:&time length:sizeof(timeData)];
        self.wbTime = time;
        NSInteger length = baglength - 8;
        // 获取 包内容
        NSData *content = [data subdataWithRange:NSMakeRange(location + 8 , length)];
        //NSString *str = [[NSString alloc]initWithData:content encoding:NSUTF8StringEncoding];
        [self parseComond:content];
        //NSLog(@"包长: %d 时间戳: %d  包内容: %@", baglength, time, str);
        self.location += baglength;
    };
    
}

- (void)playerSeekToTime:(CMTime)time{
    // TODO: 添加快进快退逻辑
    self.wbTime = 0;
    self.location = 0;
    _lines.isdrag = YES;
    do {
        // 获取 包长
        NSData *bagLengthData = [self.data subdataWithRange:NSMakeRange(self.location, 4)];
        int baglength;
        [bagLengthData getBytes: &baglength length: sizeof(4)];
        // 获取 时间戳
        NSData *timeData = [self.data subdataWithRange:NSMakeRange(self.location + 4 , 4)];
        int time11;
        [timeData getBytes:&time11 length:sizeof(timeData)];
        self.wbTime = time11;
        NSInteger length = baglength - 8;
        // 获取 包内容
        NSData *content = [self.data subdataWithRange:NSMakeRange(self.location + 8 , length)];
        //NSString *str = [[NSString alloc]initWithData:content encoding:NSUTF8StringEncoding];
        [self parseComond:content];
        //NSLog(@"包长: %d 时间戳: %d  包内容: %@", baglength, time, str);
        self.location += baglength;
        
    }while ((self.wbTime < time.value * 1000));
    _lines.isdrag = NO;
    [self.playerView play];
}

- (void)blockPer50ms:(NSInteger)time{
    //NSLog(@"%ld", time);
    [self parseData:self.data atSeconds:time];
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
