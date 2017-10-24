//
//  HomeBannerCell.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBLoopScrollView.h"

@interface HomeBannerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet HYBLoopScrollView *bannerV;
@property (weak, nonatomic) IBOutlet UIControl *shujubaogao;
@property (weak, nonatomic) IBOutlet UIControl *zhinengzujuan;
@property (weak, nonatomic) IBOutlet UIControl *yuceshiti;
@property (weak, nonatomic) IBOutlet UIControl *monishiti;

@end
