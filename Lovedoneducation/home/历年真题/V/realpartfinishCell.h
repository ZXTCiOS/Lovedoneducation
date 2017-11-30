//
//  realpartfinishCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/29.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol finishVdelegate <NSObject>
-(void)finish:(UICollectionViewCell *)cell;
@end

@interface realpartfinishCell : UICollectionViewCell

-(void)setdata:(NSString *)itemstr answer0:(NSString *)answer0 andanswer1:(NSString *)answer1 andsetbtnstr:(NSString *)btnstr;
@property(assign,nonatomic)id<finishVdelegate>delegate;
@end
