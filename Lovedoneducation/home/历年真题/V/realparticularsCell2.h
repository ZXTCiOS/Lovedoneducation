//
//  realparticularsCell2.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tijiaoVdelegate <NSObject>

-(void)querentijiao:(UITableViewCell *)cell;

@end

@interface realparticularsCell2 : UITableViewCell
@property(assign,nonatomic)id<tijiaoVdelegate>delegate;
@end
