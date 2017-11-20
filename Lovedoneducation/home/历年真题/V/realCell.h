//
//  realCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class smartgroupModel;
@interface realCell : UICollectionViewCell
@property (nonatomic,copy) NSString *copystr;
-(void)setdata:(smartgroupModel *)model;
@end
