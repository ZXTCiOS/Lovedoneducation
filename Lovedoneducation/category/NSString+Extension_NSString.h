//
//  NSString+Extension_NSString.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString ()

@end

@implementation
NSString (Extension_NSString)

//// 截取字符串方法封装//
//截取字符串方法封装

- (NSString*)subStringFrom:(NSString
                    *)startString to:(NSString
                                      *)endString{
    
    NSRange
    startRange = [self
                  rangeOfString:startString];
    
    NSRange
    endRange = [self
                rangeOfString:endString];
    
    NSRange
    range = NSMakeRange(startRange.location
                        + startRange.length,
                        endRange.location
                        - startRange.location
                        - startRange.length);
    
    return
    [self
     substringWithRange:range];
    
}

@end
