//
//  ZTShare&PayConfig.h
//  Share&PayDemo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 shang. All rights reserved.
//

#ifndef ZTShare_PayConfig_h
#define ZTShare_PayConfig_h

//UMeng https://i.umeng.com
static NSString * const kUMAppKey = @"59eff819a40fa33f25000038";

//Vendor: Sina http://open.weibo.com
static NSString * const kSinaAppKey = @"427975783";
static NSString * const kSinaRedirectURL =  @"http://sns.whalecloud.com/sina2/callback";
static NSString * const kSinaAppSecret = @"975144dcda0487b4e36a48f85d98c8e0";

//Vendor:Tencnet QQ http://open.qq.com
static NSString * const kTencentQQAppID = @"1106415033"; //0x41DF4788
static NSString * const kTencentQQAppKey = @"I1M4WRjPVIValZ0g";

//Vendor:WeChat  https://open.weixin.qq.com
static NSString * const kWeChatAppID = @"wx6861c74177fde4f6";
static NSString * const kWeChatAppSecret = @"07c9fdd3be5df5b91b2dd83110460fad";
static NSString * const kWeChatAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact, snsapi_base";
static NSString * const kWeChatStateCode = @"10017179517";

#endif /* ZTShare_PayConfig_h */
