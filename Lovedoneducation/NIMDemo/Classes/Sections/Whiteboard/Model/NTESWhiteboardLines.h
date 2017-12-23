//
//  NTESWhiteboardLines.h
//  NIMEducationDemo
//
//  Created by fenric on 16/10/26.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTESWhiteboardPoint.h"
#import "NTESWhiteboardDrawView.h"

@interface NTESWhiteboardLines : NSObject<NTESWhiteboardDrawViewDataSource>

@property (nonatomic, assign) BOOL isdrag;

- (void)addPoint:(NTESWhiteboardPoint *)point uid:(NSString *)uid;

- (void)cancelLastLine:(NSString *)uid;

- (void)clear;

- (void)clearUser:(NSString *)uid;

- (NSDictionary *)allLines;

- (BOOL)hasLines;

@end
