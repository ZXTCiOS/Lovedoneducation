//
//  realparticularsCell1.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myTabVdelegate <NSObject>
-(void)myTabVClickA:(UITableViewCell *)cell;
-(void)myTabVClickB:(UITableViewCell *)cell;
-(void)myTabVClickC:(UITableViewCell *)cell;
-(void)myTabVClickD:(UITableViewCell *)cell;
-(void)myimgbtnclick:(UITableViewCell *)cell;
-(void)textstr:(UITableViewCell *)cell andtextstr:(NSString *)str;
@end
@interface realparticularsCell1 : UITableViewCell
-(void)setarray:(NSMutableArray *)array andtype:(NSString *)type andimgarr:(NSMutableArray *)imgarr;
-(void)setanswer:(NSString *)str;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
