//
//  logupCell2.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"
//创建一个代理
@protocol myTabVdelegate <NSObject>
-(void)myTabVClick:(UITableViewCell *)cell;
@end

@interface logupCell2 : UITableViewCell
@property (nonatomic,strong) UITextField *yanzhengtext;
@property (nonatomic,strong) JKCountDownButton *fasongbtn;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
