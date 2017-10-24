//
//  HomeLayout.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeLayout : UICollectionViewLayout

@property (nonatomic, strong) NSArray<HomeQuestionsModel *> *list;

@end
