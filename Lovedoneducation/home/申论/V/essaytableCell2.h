//
//  essaytableCell2.h
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mysubmitdelegate <NSObject>
-(void)submitbtn:(UITableViewCell *)cell;
@end
@interface essaytableCell2 : UITableViewCell
-(void)setnumberstr:(NSString *)numser andpricestr:(NSString *)pricestr;
@property(assign,nonatomic)id<mysubmitdelegate>delegate;
@end
