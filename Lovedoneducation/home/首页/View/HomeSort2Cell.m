//
//  HomeSort2Cell.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeSort2Cell.h"
#import "HomeSort3Cell.h"
#import "HomeSort3View.h"

@interface HomeSort2Cell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionview;

@end

@implementation HomeSort2Cell



- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 14;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 30, 0);
        layout.itemSize = CGSizeMake((kScreenW - 34)/2, 16);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionview];
        [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerClass:[HomeSort3Cell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionview registerClass:[HomeSort3View class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSort3Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textL.text = @"易燃易爆炸";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) return nil;
    HomeSort3View *view = [[HomeSort3View alloc] init];
    view.textL.text = @"陈大哥";
    return view;
}




@end
