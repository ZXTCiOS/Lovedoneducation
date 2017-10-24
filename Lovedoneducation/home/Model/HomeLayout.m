//
//  HomeLayout.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeLayout.h"

@interface HomeLayout ()

@property (nonatomic, assign) CGFloat size_h;


@end

@implementation HomeLayout


- (void)prepareLayout{
    [super prepareLayout];
    
    // banner  height
    CGFloat banner_H = kScreenW * 7 / 15 + 100;
    
    // HomeSortCell height
    CGFloat cell_H = (kScreenW - 34)/ 2 * 9 / 17 + 16;
    CGFloat cell_totalH = (self.list.count + 1) / 2 * (cell_H + 20) + 20;
    
    
    for (HomeQuestionsModel *quetion in self.list) {
        
        // 在网络请求完成之后处理
        if (!quetion.child.count) {
            HomeChildModel *model = [HomeChildModel new];
            model.img = quetion.img;
            model.qtid = quetion.qtid;
            model.qtname = quetion.qtname;
            NSArray *arr = @[model ];
            quetion.child = arr;
        } else {
            
        }
    }
    
    
    
    
    
    
    
    
    
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(kScreenW, self.size_h);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [[UICollectionViewLayoutAttributes alloc] init];
    //attribute.center =
    
    return attribute;
}















@end
