//
//  smartgroupvolumeVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartgroupvolumeVC.h"
#import "smartgroupCell.h"
@interface smartgroupvolumeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
/**
 *  当前的位置
 */
@property (nonatomic, strong) NSIndexPath *indexPathNow;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation smartgroupvolumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"智能组卷";
    [self prepareLayout];
    if (@available(iOS 11.0, *)){
        self.collectionV.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.collectionV.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    [self loaddata];
}

#pragma mark - 数据源

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *practiceType = @"1";
    //1 智能组卷 2预测试题 3专项智能练习
    NSString *url = [NSString stringWithFormat:GET_practice,uid,token,practiceType];
    [DNNetworking getWithURLString:url success:^(id obj) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareLayout {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout .scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout .itemSize = CGSizeMake(kScreenW, kScreenH - 64);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) collectionViewLayout:self.layout];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    self.collectionV.bounces = YES;
    [self.collectionV registerClass:[smartgroupCell class] forCellWithReuseIdentifier:@"ExamCell"];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    smartgroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExamCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


@end
