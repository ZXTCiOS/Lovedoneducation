//
//  UIScrollView+Refresh.h
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)
- (void)addHeaderRefresh:(void(^)(void))block;
- (void)addFooterRefresh:(void(^)(void))block;
- (void)addFooterRefreshAuto:(void(^)(void))block;
- (void)beginHeaderRefresh;
- (void)endHeaderRefresh;

- (void)endFooterRefresh;
@end











