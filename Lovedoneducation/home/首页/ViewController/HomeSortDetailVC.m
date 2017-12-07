//
//  HomeSortDetailVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "HomeSortDetailVC.h"
#import "HomeSort3Cell.h"
#import "HomeSort3View.h"
#import "ZhuanXiangZhiNengPricticeVC.h"
#import "essayVC.h"

@interface HomeSortDetailVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation HomeSortDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionview.backgroundColor = [UIColor whiteColor];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.child.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.child[section].child.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSort3Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HomeChild2Model *model = self.child[indexPath.section].child[indexPath.row];
    cell.textL.text = model.qtname;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HomeChildModel *model = self.child[indexPath.section];
    NSString *ischarge = model.ischarge;
    
    if ([ischarge isEqualToString:@"1"]) {
        essayVC *vc = [[essayVC alloc] init];
        vc.qtid = self.child[indexPath.section].child[indexPath.row].qtid;
        vc.qtname = self.child[indexPath.section].child[indexPath.row].qtname;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ZhuanXiangZhiNengPricticeVC *vc = [[ZhuanXiangZhiNengPricticeVC alloc] init];
        vc.qtid = self.child[indexPath.section].child[indexPath.row].qtid;
        vc.qtname = self.child[indexPath.section].child[indexPath.row].qtname;
        [self.navigationController pushViewController:vc animated:YES];

    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) return nil;
    HomeSort3View *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    view.textL.text = self.child[indexPath.section].qtname;
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, 48);
}



#pragma mark - lazy load

- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 14;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(16, 0, 26, 0);
        layout.itemSize = CGSizeMake((kScreenW - 34)/2, 24);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionview];
        if (@available(iOS 11.0, *)){
            _collectionview.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
        }
        else
        {
            _collectionview.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        }
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerClass:[HomeSort3Cell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionview registerClass:[HomeSort3View class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
