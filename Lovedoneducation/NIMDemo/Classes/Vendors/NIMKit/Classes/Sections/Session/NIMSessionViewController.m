//
//  NIMSessionViewController.m
//  NIMKit
//
//  Created by NetEase.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NIMSessionViewController.h"
#import "NIMInputView.h"
#import "NIMInputTextView.h"
#import "UIView+NIM.h"
#import "NIMMessageCellProtocol.h"
#import "NIMMessageModel.h"
#import "NIMKitUtil.h"
#import "NIMCustomLeftBarView.h"
#import "NIMBadgeView.h"
#import "UITableView+NIMScrollToBottom.h"
#import "NIMMessageMaker.h"
#import "NIMDefaultValueMaker.h"
#import "NIMTimestampModel.h"
#import "NIMMessageCellMaker.h"
#import "NIMUIConfig.h"
#import <AVFoundation/AVFoundation.h>

@interface NIMSessionViewController ()
<UITableViewDataSource,
UITableViewDelegate,
NIMConversationManagerDelegate,
NIMTeamManagerDelegate,
NIMMediaManagerDelegate,
NIMMessageCellDelegate,
NIMUserManagerDelegate>

@property (nonatomic,strong,readwrite) UITableView *tableView;

@property (nonatomic,strong) NIMSessionMsgDatasource *sessionDatasource;
@property (nonatomic,strong) NSMutableArray *insertMessages;
@property (nonatomic,readwrite)   NIMMessage *messageForMenu;
@property (nonatomic,strong) NSIndexPath *lastVisibleIndexPathBeforeRotation;
@property (nonatomic,assign) BOOL isRefreshing;

@end

@implementation NIMSessionViewController

- (instancetype)initWithSession:(NIMSession *)session{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _session = session;
        _insertMessages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self makeHandlerAndDataSource];
}


-(void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [self.conversationManager removeDelegate:self];
    [[NIMSDK sharedSDK].teamManager removeDelegate:self];
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)makeUI
{
    self.navigationItem.title = [self sessionTitle];
    NIMCustomLeftBarView *leftBarView = [[NIMCustomLeftBarView alloc] init];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = NIMKit_UIColorFromRGB(0xe4e7ec);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.tableView addSubview:_refreshControl];
    [self.refreshControl addTarget:self action:@selector(headerRereshing:) forControlEvents:UIControlEventValueChanged];
    
    CGRect inputViewRect = CGRectMake(0, 0, self.view.nim_width, [NIMUIConfig topInputViewHeight]);
    BOOL disableInputView = NO;
    if ([self.sessionConfig respondsToSelector:@selector(disableInputView)]) {
        disableInputView = [self.sessionConfig disableInputView];
    }
    if (!disableInputView) {
        _sessionInputView = [[NIMInputView alloc] initWithFrame:inputViewRect];
        _sessionInputView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        self.sessionInputView.nim_bottom = self.view.nim_height;
        [self.sessionInputView setInputConfig:[self sessionConfig]];
        [self.sessionInputView setInputActionDelegate:self];
        [self.view addSubview:self.sessionInputView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
}

- (void)makeHandlerAndDataSource
{
    _layoutManager = [[NIMSessionViewLayoutManager alloc] initWithInputView:self.sessionInputView tableView:self.tableView];
    
    //数据
    id<NIMKitMessageProvider> dataProvider = [self.sessionConfig respondsToSelector:@selector(messageDataProvider)] ? [self.sessionConfig messageDataProvider] : nil;
    NSInteger limit = [NIMUIConfig messageLimit];
    if ([self.sessionConfig respondsToSelector:@selector(messageLimit)]) {
        limit = self.sessionConfig.messageLimit;
    }
    NSTimeInterval showTimestampInterval = [NIMUIConfig messageTimeInterval];
    if ([self.sessionConfig respondsToSelector:@selector(showTimeInterval)]) {
        showTimestampInterval = [self.sessionConfig showTimestampInterval];
    }
    _sessionDatasource = [[NIMSessionMsgDatasource alloc] initWithSession:_session dataProvider:dataProvider showTimeInterval:showTimestampInterval limit:limit];
    [self.conversationManager markAllMessagesReadInSession:_session];
    
    _sessionDatasource.delegate = self;
    
    if (![self.sessionConfig respondsToSelector:@selector(autoFetchWhenOpenSession)] || self.sessionConfig.autoFetchWhenOpenSession) {
        [_sessionDatasource resetMessages:nil];
    }

    
    NSMutableArray *messageArray = [[NSMutableArray alloc] init];
    for (id model in _sessionDatasource.modelArray) {
        if ([model isKindOfClass:[NIMMessageModel class]])
        {
            [messageArray addObject:[model message]];
        }
    }
    [self checkAttachmentState:messageArray];

    [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
    [self.conversationManager addDelegate:self];
    if (self.session.sessionType == NIMSessionTypeTeam) {
        [[[NIMSDK sharedSDK] teamManager] addDelegate:self];
    }
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_sessionInputView endEditing:YES];
}


- (void)viewDidLayoutSubviews{
    [self changeLeftBarBadge:self.conversationManager.allUnreadCount];
    BOOL isFirstLayout = CGRectEqualToRect(_layoutManager.viewRect, CGRectZero);
    if (isFirstLayout) {
        [self.tableView nim_scrollToBottom:NO];
    }
    [_layoutManager setViewRect:self.view.frame];
    
    //fix bug: 竖屏进入会话界面，然后右上角进入群信息，再横屏，左上角返回，横屏的会话界面显示的就是竖屏时的大小
    [self.sessionDatasource cleanCache];
    [self.tableView reloadData];
}

- (void)checkAttachmentState:(NSArray *)messages{
    for (NIMMessage *message in messages) {
        if (message.attachmentDownloadState == NIMMessageAttachmentDownloadStateNeedDownload) {
            [[NIMSDK sharedSDK].chatManager fetchMessageAttachment:message error:nil];
        }
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sessionDatasource.modelArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    id model = [[_sessionDatasource modelArray] objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[NIMMessageModel class]]) {
        cell = [NIMMessageCellMaker cellInTable:tableView
                                 forMessageMode:model];
        [(NIMMessageCell *)cell setMessageDelegate:self];
    }
    else if ([model isKindOfClass:[NIMTimestampModel class]])
    {
        cell = [NIMMessageCellMaker cellInTable:tableView
                                   forTimeModel:model];
    }
    else
    {
        NSAssert(0, @"not support model");
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    id modelInArray = [[_sessionDatasource modelArray] objectAtIndex:indexPath.row];
    if ([modelInArray isKindOfClass:[NIMMessageModel class]])
    {
        NIMMessageModel *model = (NIMMessageModel *)modelInArray;
        NSAssert([model respondsToSelector:@selector(contentSize)], @"config must have a cell height value!!!");
        [self layoutConfig:model];
        CGSize size = model.contentSize;
        UIEdgeInsets contentViewInsets = model.contentViewInsets;
        UIEdgeInsets bubbleViewInsets  = model.bubbleViewInsets;
        cellHeight = size.height + contentViewInsets.top + contentViewInsets.bottom + bubbleViewInsets.top + bubbleViewInsets.bottom;
    }
    else if ([modelInArray isKindOfClass:[NIMTimestampModel class]])
    {
        cellHeight = [(NIMTimestampModel *)modelInArray height];
    }
    else
    {
        NSAssert(0, @"not support model");
    }
    return cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    CGFloat offset = 44.f;
    if (scrollView.contentOffset.y <= -offset && !self.isRefreshing && self.tableView.isDragging) {
        self.isRefreshing = YES;
        [self.refreshControl beginRefreshing];
        [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
        [scrollView endEditing:YES];
    }
    else if(scrollView.contentOffset.y >= 0)
    {
        self.isRefreshing = NO;
    }
}

#pragma mark - 消息收发接口
- (void)sendMessage:(NIMMessage *)message
{
    [[[NIMSDK sharedSDK] chatManager] sendMessage:message toSession:_session error:nil];
}

//发送消息
- (void)willSendMessage:(NIMMessage *)message
{
    if ([message.session isEqual:_session]) {
        if ([self findModel:message]) {
            [self uiUpdateMessage:message];
        }else{
            [self uiAddMessages:@[message]];
        }
    }
}

//发送结果
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error
{
    if ([message.session isEqual:_session]) {
        NIMMessageModel *model = [self makeModel:message];
        NSInteger index = [self.sessionDatasource indexAtModelArray:model];
        [self.layoutManager updateCellAtIndex:index model:model];
    }
}

//发送进度
-(void)sendMessage:(NIMMessage *)message progress:(CGFloat)progress
{
    if ([message.session isEqual:_session]) {
        NIMMessageModel *model = [self makeModel:message];
        [_layoutManager updateCellAtIndex:[self.sessionDatasource indexAtModelArray:model] model:model];
    }
}

//接收消息
- (void)onRecvMessages:(NSArray *)messages
{
    NIMMessage *message = messages.firstObject;
    NIMSession *session = message.session;
    if (![session isEqual:self.session] || !messages.count){
        return;
    }
    
    if (session.sessionType == NIMSessionTypeChatroom) {
        [self uiAddChatroomMessages:messages];
    }
    else{
        [self uiAddMessages:messages];
        [self.conversationManager markAllMessagesReadInSession:self.session];
    }
}


- (void)fetchMessageAttachment:(NIMMessage *)message progress:(CGFloat)progress
{
    if ([message.session isEqual:_session]) {
        NIMMessageModel *model = [self makeModel:message];
        [_layoutManager updateCellAtIndex:[self.sessionDatasource indexAtModelArray:model] model:model];
    }
}

- (void)fetchMessageAttachment:(NIMMessage *)message didCompleteWithError:(NSError *)error
{
    if ([message.session isEqual:_session]) {
        NIMMessageModel *model = [self makeModel:message];
        [_layoutManager updateCellAtIndex:[self.sessionDatasource indexAtModelArray:model] model:model];
    }
}


#pragma mark - NIMConversationManagerDelegate
- (void)messagesDeletedInSession:(NIMSession *)session{
    [self.sessionDatasource resetMessages:nil];
    [self.tableView reloadData];
}

- (void)didAddRecentSession:(NIMRecentSession *)recentSession
           totalUnreadCount:(NSInteger)totalUnreadCount{
    [self changeUnreadCount:recentSession totalUnreadCount:totalUnreadCount];
}

- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    [self changeUnreadCount:recentSession totalUnreadCount:totalUnreadCount];
}

- (void)didRemoveRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    [self changeUnreadCount:recentSession totalUnreadCount:totalUnreadCount];
}


- (void)changeUnreadCount:(NIMRecentSession *)recentSession
         totalUnreadCount:(NSInteger)totalUnreadCount{
    if ([recentSession.session isEqual:self.session]) {
        return;
    }
    [self changeLeftBarBadge:totalUnreadCount];
}

- (void)changeLeftBarBadge:(NSInteger)unreadCount{
    NIMCustomLeftBarView *leftBarView = (NIMCustomLeftBarView *)self.navigationItem.leftBarButtonItem.customView;
    leftBarView.badgeView.badgeValue = @(unreadCount).stringValue;
    leftBarView.badgeView.hidden = !unreadCount;
}

#pragma mark - NIMTeamManagerDelegate
- (void)onTeamUpdated:(NIMTeam *)team
{
    if (self.session.sessionType == NIMSessionTypeTeam &&
        [self.session.sessionId isEqualToString:team.teamId]) {
        self.navigationItem.title = [self sessionTitle];
    }
}

- (void)onTeamMemberChanged:(NIMTeam *)team{
    if (self.session.sessionType == NIMSessionTypeTeam &&
        [team.teamId isEqualToString:self.session.sessionId]) {
        [self.tableView reloadData];
        self.navigationItem.title = [self sessionTitle];
    }
}

#pragma mark - NIMUserManagerDelegate
- (void)onUserInfoChanged:(NIMUser *)user {
    self.navigationItem.title = [self sessionTitle];
    [self.tableView reloadData];
}

- (void)onFriendChanged:(NIMUser *)user {
    self.navigationItem.title = [self sessionTitle];
    [self.tableView reloadData];
}


- (void)onUserInfoHasUpdatedNotification:(NSNotification *)notification {
    self.navigationItem.title = [self sessionTitle];
    [self.tableView reloadData];
}


#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_sessionInputView endEditing:YES];
}

#pragma marlk - 通知
- (void)messageDataIsReady{
    [self.tableView reloadData];
    [self.tableView nim_scrollToBottom:NO];
}


#pragma mark - 会话title
- (NSString *)sessionTitle
{
    NSString *title = @"";
    NIMSessionType type = self.session.sessionType;
    switch (type) {
        case NIMSessionTypeTeam:{
            NIMTeam *team = [[[NIMSDK sharedSDK] teamManager] teamById:self.session.sessionId];
            title = [NSString stringWithFormat:@"%@(%zd)",[team teamName],[team memberNumber]];
        }
            break;
        case NIMSessionTypeP2P:{
            title = [NIMKitUtil showNick:self.session.sessionId inSession:self.session];
        }
            break;
        default:
            break;
    }
    return title;
}

#pragma mark - NIMMediaManagerDelegate
- (void)recordAudio:(NSString *)filePath didBeganWithError:(NSError *)error {
    if (!filePath || error) {
        _sessionInputView.recording = NO;
        [self onRecordFailed:error];
    }
}

- (void)recordAudio:(NSString *)filePath didCompletedWithError:(NSError *)error {
    if(!error) {
        if ([self recordFileCanBeSend:filePath]) {
            [self sendMessage:[NIMMessageMaker msgWithAudio:filePath]];
        }else{
            [self showRecordFileNotSendReason];
        }
    } else {
        [self onRecordFailed:error];
    }
    _sessionInputView.recording = NO;
}

- (void)recordAudioDidCancelled {
    _sessionInputView.recording = NO;
}

- (void)recordAudioProgress:(NSTimeInterval)currentTime {
    [_sessionInputView updateAudioRecordTime:currentTime];
}

- (void)recordAudioInterruptionBegin {
    [[NIMSDK sharedSDK].mediaManager cancelRecord];
}

#pragma mark - 录音相关接口
- (void)onRecordFailed:(NSError *)error{}

- (BOOL)recordFileCanBeSend:(NSString *)filepath
{
    return YES;
}

- (void)showRecordFileNotSendReason{}


#pragma mark - NIMInputActionDelegate
- (void)onTapMediaItem:(NIMMediaItem *)item{}

- (void)onTextChanged:(id)sender{}

- (void)onSendText:(NSString *)text
{
    NIMMessage *message = [NIMMessageMaker msgWithText:text];
    [self sendMessage:message];
}

- (void)onSelectChartlet:(NSString *)chartletId
                 catalog:(NSString *)catalogId{}

- (void)onCancelRecording
{
    [[NIMSDK sharedSDK].mediaManager cancelRecord];
}

- (void)onStopRecording
{
    [[NIMSDK sharedSDK].mediaManager stopRecord];
}

- (void)onStartRecording
{
    _sessionInputView.recording = YES;
    [[[NIMSDK sharedSDK] mediaManager] addDelegate:self];
    [[NIMSDK sharedSDK].mediaManager recordForDuration:60.f];
}

#pragma mark - CellActionDelegate
- (void)onTapCell:(NIMKitEvent *)message{}

- (void)onRetryMessage:(NIMMessage *)message
{
    if (message.isReceivedMsg) {
        [[[NIMSDK sharedSDK] chatManager] fetchMessageAttachment:message
                                                           error:nil];
    }else{
        [[[NIMSDK sharedSDK] chatManager] resendMessage:message
                                                  error:nil];
    }
}

- (void)onLongPressCell:(NIMMessage *)message
                 inView:(UIView *)view
{
    NSArray *items = [self menusItems:message];
    if ([items count] && [self becomeFirstResponder]) {
        UIMenuController *controller = [UIMenuController sharedMenuController];
        controller.menuItems = items;
        _messageForMenu = message;
        [controller setTargetRect:view.bounds inView:view];
        [controller setMenuVisible:YES animated:YES];
        
    }
}

#pragma mark - 配置项
- (id<NIMSessionConfig>)sessionConfig
{
    return nil;
}

#pragma mark - 菜单
- (NSArray *)menusItems:(NIMMessage *)message
{
    NSMutableArray *items = [NSMutableArray array];
    
    if (message.messageType == NIMMessageTypeText) {
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制"
                                                    action:@selector(copyText:)]];
    }
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
                                                action:@selector(deleteMsg:)]];
    return items;
    
}

- (NIMMessage *)messageForMenu
{
    return _messageForMenu;
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSArray *items = [[UIMenuController sharedMenuController] menuItems];
    for (UIMenuItem *item in items) {
        if (action == [item action]){
            return YES;
        }
    }
    return NO;
}


- (void)copyText:(id)sender
{
    NIMMessage *message = [self messageForMenu];
    if (message.text.length) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:message.text];
    }
}

- (void)deleteMsg:(id)sender
{
    NIMMessage *message    = [self messageForMenu];
    NIMMessageModel *model = [self makeModel:message];
    [self.layoutManager deleteCellAtIndexs:[self.sessionDatasource deleteMessageModel:model]];
    [self.conversationManager deleteMessage:model.message];
}

- (void)menuDidHide:(NSNotification *)notification
{
    [UIMenuController sharedMenuController].menuItems = nil;
}


#pragma mark - 操作接口
- (void)uiAddMessages:(NSArray *)messages
{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (NIMMessage *message in messages)
    {
        NIMMessageModel *model = [[NIMMessageModel alloc] initWithMessage:message];
        [self layoutConfig:model];
        [models addObject:model];
    }
    NSArray *insert = [self.sessionDatasource addMessageModels:models];
    [self.tableView beginUpdates];
    [self.layoutManager insertTableViewCellAtRows:insert animated:YES];
    [self.tableView endUpdates];
}

- (void)uiAddChatroomMessages:(NSArray *)messages
{
    dispatch_async(NTESMessageDataPrepareQueue(), ^{
        //后台线程处理宽度计算，处理完之后同步抛到主线程插入
        BOOL needCheck  = self.insertMessages.count == 0;
        [self.insertMessages addObjectsFromArray:messages];
        if (needCheck) {
            [self checkInsert];
        }
    });
}

- (void)uiDeleteMessage:(NIMMessage *)message{
    NIMMessageModel *model = [self makeModel:message];
    NSArray *indexs = [self.sessionDatasource deleteMessageModel:model];
    [self.tableView beginUpdates];
    [self.layoutManager deleteCellAtIndexs:indexs];
    [self.tableView endUpdates];
}

- (void)uiUpdateMessage:(NIMMessage *)message{
    NIMMessageModel *model = [self makeModel:message];
    NSInteger index = [self.sessionDatasource indexAtModelArray:model];
    [self.sessionDatasource.modelArray replaceObjectAtIndex:index withObject:model];
    [self.layoutManager updateCellAtIndex:index model:model];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

#pragma mark - 旋转处理 (iOS7)
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    
    self.lastVisibleIndexPathBeforeRotation = [self.tableView indexPathsForVisibleRows].lastObject;
    if (self.view.window) {
        [self.sessionInputView endEditing:YES];
        [[NIMSDK sharedSDK].mediaManager cancelRecord];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView scrollToRowAtIndexPath:self.lastVisibleIndexPathBeforeRotation atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - 旋转处理 (iOS8 or above)
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    self.lastVisibleIndexPathBeforeRotation = [self.tableView indexPathsForVisibleRows].lastObject;
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (self.view.window) {
        __weak typeof(self) wself = self;
        [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context)
         {
             [[NIMSDK sharedSDK].mediaManager cancelRecord];
             [wself.tableView scrollToRowAtIndexPath:wself.lastVisibleIndexPathBeforeRotation atScrollPosition:UITableViewScrollPositionBottom animated:NO];
         } completion:nil];
    }
}


#pragma mark - Private

- (void)layoutConfig:(NIMMessageModel *)model{
    model.sessionConfig = self.sessionConfig;
    if (model.layoutConfig == nil)
    {
        id<NIMCellLayoutConfig> layoutConfig = nil;
        if ([self.sessionConfig respondsToSelector:@selector(layoutConfigWithMessage:)]) {
            layoutConfig = [self.sessionConfig layoutConfigWithMessage:model.message];
        }
        if (!layoutConfig) {
            layoutConfig = [NIMDefaultValueMaker sharedMaker].cellLayoutDefaultConfig;
        }
        model.layoutConfig = layoutConfig;
    }
    [model calculateContent:self.tableView.nim_width];
}


- (NIMMessageModel *)makeModel:(NIMMessage *)message{
    NIMMessageModel *model = [self findModel:message];
    if (!model) {
        model = [[NIMMessageModel alloc] initWithMessage:message];
    }
    [self layoutConfig:model];
    return model;
}

- (NIMMessageModel *)findModel:(NIMMessage *)message{
    NIMMessageModel *model;
    for (NIMMessageModel *item in self.sessionDatasource.modelArray.reverseObjectEnumerator.allObjects) {
        if ([item isKindOfClass:[NIMMessageModel class]] && [item.message isEqual:message]) {
            model = item;
            //防止那种进了会话又退出去再进来这种行为，防止SDK里回调上来的message和会话持有的message不是一个，导致刷界面刷跪了的情况
            model.message = message;
        }
    }
    return model;
}


- (void)headerRereshing:(id)sender
{
    __weak NIMSessionViewLayoutManager *layoutManager = self.layoutManager;
    __weak typeof(self) wself = self;
    __weak UIRefreshControl *refreshControl = self.refreshControl;
    [self.sessionDatasource loadHistoryMessagesWithComplete:^(NSInteger index,NSArray *memssages, NSError *error) {
        [refreshControl endRefreshing];
        [layoutManager reloadDataToIndex:index atScrollPosition:UITableViewScrollPositionBottom withAnimation:NO];
        [wself checkAttachmentState:memssages];
    }];
}

- (id<NIMConversationManager>)conversationManager{
    switch (self.session.sessionType) {
        case NIMSessionTypeChatroom:
            return nil;
            break;
        case NIMSessionTypeP2P:
        case NIMSessionTypeTeam:
        default:
            return [NIMSDK sharedSDK].conversationManager;
    }
}


- (void)checkInsert
{
    __weak typeof(self) weakSelf = self;
    if (!weakSelf) {
        return;
    }
    if (weakSelf.tableView.isDecelerating || weakSelf.tableView.isDragging)
    {
        //滑动的时候为保证流畅，暂停插入
        NSTimeInterval delay = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), NTESMessageDataPrepareQueue(), ^{
            [weakSelf checkInsert];
        });
        return;
    }
    static NSInteger NTESMaxInsert = 1;
    NSArray *insert;
    NSRange range;
    if (self.insertMessages.count > NTESMaxInsert)
    {
        range = NSMakeRange(0, NTESMaxInsert);
    }
    else
    {
        range = NSMakeRange(0, self.insertMessages.count);
    }
    insert = [self.insertMessages subarrayWithRange:range];
    [self.insertMessages removeObjectsInRange:range];
    
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (NIMMessage *message in insert)
    {
        NIMMessageModel *model = [[NIMMessageModel alloc] initWithMessage:message];
        [self layoutConfig:model];
        [models addObject:model];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSArray *insert = [weakSelf.sessionDatasource addMessageModels:models];
        [weakSelf.tableView beginUpdates];
        BOOL animated = !self.insertMessages.count;
        [weakSelf.layoutManager insertTableViewCellAtRows:insert animated:animated];
        [weakSelf.tableView endUpdates];
    });
    
    if (self.insertMessages.count)
    {
        NSTimeInterval delay = 0.1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), NTESMessageDataPrepareQueue(), ^{
            [weakSelf checkInsert];
        });
    }
}

static const void * const NTESDispatchMessageDataPrepareSpecificKey = &NTESDispatchMessageDataPrepareSpecificKey;
dispatch_queue_t NTESMessageDataPrepareQueue()
{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("nim.demo.message.queue", 0);
        dispatch_queue_set_specific(queue, NTESDispatchMessageDataPrepareSpecificKey, (void *)NTESDispatchMessageDataPrepareSpecificKey, NULL);
    });
    return queue;
}

@end
