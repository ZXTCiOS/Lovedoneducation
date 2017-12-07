//
//  realCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myTabVdelegate <NSObject>

-(void)myTabVClickA:(UICollectionViewCell *)cell;
-(void)myTabVClickB:(UICollectionViewCell *)cell;
-(void)myTabVClickC:(UICollectionViewCell *)cell;
-(void)myTabVClickD:(UICollectionViewCell *)cell;
-(void)queren:(UICollectionViewCell *)cell;
-(void)imgchoose:(UICollectionViewCell *)cell;
-(void)textstr:(UICollectionViewCell *)cell andtextstr:(NSString *)str;
@end

@class smartgroupModel;
@interface realCell : UICollectionViewCell
@property (nonatomic,copy) NSString *copystr;
-(void)setdata:(smartgroupModel *)model;
-(void)setarray:(NSString *)str;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
