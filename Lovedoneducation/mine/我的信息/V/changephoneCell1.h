//
//  changephoneCell1.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>
-(void)myTabVClick:(UITableViewCell *)cell;
-(void)nextTabVClick:(UITableViewCell *)cell;
@end
@interface changephoneCell1 : UITableViewCell
@property (nonatomic,strong) UITextField *valuetext;
@property(assign,nonatomic)id<myTabVdelegate>delegate;

@end
