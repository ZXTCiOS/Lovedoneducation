//
//  essaytableCell1.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myTabVdelegate <NSObject>
-(void)myimgbtnclick:(UITableViewCell *)cell;
-(void)textstr:(UITableViewCell *)cell andtextstr:(NSString *)str;
@end
@interface essaytableCell1 : UITableViewCell
@property(assign,nonatomic)id<myTabVdelegate>delegate;
-(void)setimgarr:(NSMutableArray *)array andtextstr:(NSString *)textstr;
@end
