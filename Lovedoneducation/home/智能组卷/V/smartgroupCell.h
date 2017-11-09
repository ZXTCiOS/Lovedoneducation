//
//  smartgroupCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "headView.h"
@class smartgroupModel;
@interface smartgroupCell : UICollectionViewCell
@property (nonatomic,strong) headView *head;
-(void)setdata:(smartgroupModel *)model andinitger:(NSString *)numstr andnumstr:(NSString *)numitem;
@end
