//
//  realpartanalysisVC1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisVC1.h"
#import "realanalysisCell.h"
#import "smartgroupModel.h"

@interface realpartanalysisVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *head;
@property (nonatomic, strong) UILabel *headnameLab;
@end

static NSString *realanalysisCellidentfid = @"realanalysisCellidentfid";

@implementation realpartanalysisVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"错题分析";
    [self.view addSubview:self.head];
    [self prepareLayout];
    if (@available(iOS 11.0, *)){
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH-NAVIGATION_HEIGHT-60);
    }
    else
    {
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, 60, kScreenW, kScreenH-60);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters


-(UIView *)head
{
    if(!_head)
    {
        _head = [[UIView alloc] init];
        _head.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _head;
}

-(UILabel *)headnameLab
{
    if(!_headnameLab)
    {
        _headnameLab = [[UILabel alloc] init];
        _headnameLab.text = @"练习练习";
        _headnameLab.font = [UIFont systemFontOfSize:15];
        _headnameLab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
    }
    return _headnameLab;
}

- (void)prepareLayout {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout .scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout .itemSize = CGSizeMake(kScreenW, kScreenH - NAVIGATION_HEIGHT-60);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH - NAVIGATION_HEIGHT-60) collectionViewLayout:self.layout];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    self.collectionV.bounces = YES;
    [self.collectionV registerClass:[realanalysisCell class] forCellWithReuseIdentifier:realanalysisCellidentfid];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    realanalysisCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:realanalysisCellidentfid forIndexPath:indexPath];
    //[cell setdata:self.dataSource[indexPath.item]];
    [cell setdata:self.dataSource[indexPath.item] andanswer0:self.answer0[indexPath.item] andanswer1:self.answer1[indexPath.item]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
