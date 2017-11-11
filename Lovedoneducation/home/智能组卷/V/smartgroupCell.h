//
//  smartgroupCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headView.h"

//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClickA:(UICollectionViewCell *)cell;
-(void)myTabVClickB:(UICollectionViewCell *)cell;
-(void)myTabVClickC:(UICollectionViewCell *)cell;
-(void)myTabVClickD:(UICollectionViewCell *)cell;
@end

@class smartgroupModel;
@interface smartgroupCell : UICollectionViewCell
@property (nonatomic,strong) headView *head;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
-(void)setdata:(smartgroupModel *)model andinitger:(NSString *)numstr andnumstr:(NSString *)numitem;
@end
