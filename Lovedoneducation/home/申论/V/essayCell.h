//
//  essayCell.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myTabVdelegate <NSObject>
-(void)queren:(UICollectionViewCell *)cell;
-(void)imgchoose:(UICollectionViewCell *)cell;
-(void)textstr:(UICollectionViewCell *)cell andtextstr:(NSString *)str;
@end
@class essayModel;
@interface essayCell : UICollectionViewCell
-(void)setdata:(essayModel *)model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
