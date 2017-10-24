//
//  changepasswordCell0.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>
-(void)myTabVClick:(UITableViewCell *)cell;

@end
@interface changepasswordCell0 : UITableViewCell
@property (nonatomic,strong) UITextField *valuetext;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
