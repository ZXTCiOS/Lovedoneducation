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
@end
@interface realparticularsCell1 : UITableViewCell
-(void)setarray:(NSMutableArray *)array andtype:(NSString *)type;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
