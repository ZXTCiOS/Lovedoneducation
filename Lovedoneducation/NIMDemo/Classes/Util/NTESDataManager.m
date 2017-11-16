//
//  NTESDataManager.m
//  NIM
//
//  Created by amao on 8/13/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESDataManager.h"
#import "NTESMeetingManager.h"

@interface NTESDataRequestArray : NSObject

@property (nonatomic,assign) NSInteger maxMergeCount; //最大合并数

- (void)requestUserIds:(NSArray *)userIds;

@end


@interface NTESDataManager()

@property (nonatomic,strong) NTESDataRequestArray *requestArray;

@end

@implementation NTESDataManager

+ (instancetype)sharedInstance{
    static NTESDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _defaultUserAvatar = [UIImage imageNamed:@"avatar_user"];
        _defaultTeamAvatar = [UIImage imageNamed:@"avatar_team"];
        _requestArray = [[NTESDataRequestArray alloc] init];
        _requestArray.maxMergeCount = 20;
    }
    return self;
}

- (NIMKitInfo *)infoByUser:(NSString *)userId
                 inSession:(NIMSession *)session
{
    BOOL needFetchInfo = NO;
    NIMSessionType sessionType = session.sessionType;
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.infoId = userId;
    info.showName = userId; //默认值
    switch (sessionType) {
        case NIMSessionTypeP2P:
        case NIMSessionTypeTeam:
        {
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
            NIMUserInfo *userInfo = user.userInfo;
            NIMTeamMember *member = nil;
            if (sessionType == NIMSessionTypeTeam)
            {
                member = [[NIMSDK sharedSDK].teamManager teamMember:userId
                                                             inTeam:session.sessionId];
            }
            NSString *name = [self nickname:user
                                 memberInfo:member];
            if (name)
            {
                info.showName = name;
            }
            info.avatarUrlString = userInfo.thumbAvatarUrl;
            info.avatarImage = self.defaultUserAvatar;
            
            if (userInfo == nil)
            {
                needFetchInfo = YES;
            }
        }
            break;
        case NIMSessionTypeChatroom:
             NSAssert(0, @"invalid type"); //聊天室的Info不会通过这个回调请求
            break;
        default:
            NSAssert(0, @"invalid type");
            break;
    }
    
    if (needFetchInfo)
    {
        [self.requestArray requestUserIds:@[userId]];
    }
    return info;
}

- (NIMKitInfo *)infoByTeam:(NSString *)teamId
{
    NIMTeam *team    = [[NIMSDK sharedSDK].teamManager teamById:teamId];
    NIMKitInfo *info = [[NIMKitInfo alloc] init];
    info.showName    = team.teamName;
    info.infoId      = teamId;
    info.avatarImage = self.defaultTeamAvatar;
    return info;
}

- (NIMKitInfo *)infoByUser:(NSString *)userId
               withMessage:(NIMMessage *)message
{
    if (message.session.sessionType == NIMSessionTypeChatroom)
    {
        NIMKitInfo *info = [[NIMKitInfo alloc] init];
        info.infoId = userId;
        if ([userId isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]) {
            NIMChatroomMember *member = [[NTESMeetingManager sharedInstance] myInfo:message.session.sessionId];
            info.showName        = member.roomNickname;
            info.avatarUrlString = member.roomAvatar;
        }else{
            NIMMessageChatroomExtension *ext = [message.messageExt isKindOfClass:[NIMMessageChatroomExtension class]] ?
            (NIMMessageChatroomExtension *)message.messageExt : nil;
            info.showName = ext.roomNickname;
            info.avatarUrlString = ext.roomAvatar;
        }
        info.avatarImage = self.defaultUserAvatar;
        return info;
    }
    else
    {
        return [self infoByUser:userId
                      inSession:message.session];
    }
}

#pragma mark - nickname
- (NSString *)nickname:(NIMUser *)user
            memberInfo:(NIMTeamMember *)memberInfo
{
    NSString *name = nil;
    do{
        if ([user.alias length])
        {
            name = user.alias;
            break;
        }
        if (memberInfo && [memberInfo.nickname length])
        {
            name = memberInfo.nickname;
            break;
        }
        
        if ([user.userInfo.nickName length])
        {
            name = user.userInfo.nickName;
            break;
        }
    }while (0);
    return name;
}

@end




@implementation NTESDataRequestArray{
    NSMutableArray *_requstUserIdArray; //待请求池
    BOOL _isRequesting;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _requstUserIdArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)requestUserIds:(NSArray *)userIds
{
    for (NSString *userId in userIds)
    {
        if (![_requstUserIdArray containsObject:userId])
        {
            [_requstUserIdArray addObject:userId];
            DDLogInfo(@"should request info for userid %@",userId);
        }
    }
    [self request];
}


- (void)request
{
    static NSUInteger MaxBatchReuqestCount = 10;
    if (_isRequesting || [_requstUserIdArray count] == 0) {
        return;
    }
    _isRequesting = YES;
    NSArray *userIds = [_requstUserIdArray count] > MaxBatchReuqestCount ?
    [_requstUserIdArray subarrayWithRange:NSMakeRange(0, MaxBatchReuqestCount)] : [_requstUserIdArray copy];
    
    DDLogInfo(@"request user ids %@",userIds);
    __weak typeof(self) weakSelf = self;
    [[NIMSDK sharedSDK].userManager fetchUserInfos:userIds
                                        completion:^(NSArray *users, NSError *error) {
                                            [weakSelf afterReuquest:userIds];
                                            if (!error) {
                                                [[NIMKit sharedKit] notfiyUserInfoChanged:userIds];
                                            }
                                        }];
}

- (void)afterReuquest:(NSArray *)userIds
{
    _isRequesting = NO;
    [_requstUserIdArray removeObjectsInArray:userIds];
    [self request];
    
}

@end