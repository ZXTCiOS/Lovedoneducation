//
//  mymoneycell1.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>
-(void)myTabVClick0:(UITableViewCell *)cell;
-(void)myTabVClick1:(UITableViewCell *)cell;
-(void)myTabVClick2:(UITableViewCell *)cell;
-(void)submitVClick1:(UITableViewCell *)cell;
@end
@interface mymoneycell1 : UITableViewCell
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
