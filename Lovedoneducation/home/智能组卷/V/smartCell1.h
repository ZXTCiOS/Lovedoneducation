//
//  smartCell1.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClickA:(UITableViewCell *)cell;
-(void)myTabVClickB:(UITableViewCell *)cell;
-(void)myTabVClickC:(UITableViewCell *)cell;
-(void)myTabVClickD:(UITableViewCell *)cell;
@end
@interface smartCell1 : UITableViewCell
-(void)setdata:(NSMutableArray *)answer;
-(void)setanswer:(NSString *)str;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
