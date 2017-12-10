//
//  realpartfinishVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartfinishVC.h"
#import "finishheadView.h"
#import "realpartfinishCell.h"
#import "smartgroupModel.h"
#import "realpartanalysisVC0.h"
#import "realpartanalysisVC1.h"

@interface realpartfinishVC ()<UICollectionViewDelegate,UICollectionViewDataSource,finishVdelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) finishheadView *headView;
@property (nonatomic, strong) NSMutableArray *selectarray;
@property (nonatomic, strong) NSString  *interstr;
@end


static NSString *realpartfinishidentfid0 = @"realpartfinishidentfid0";
static NSString *realpartfinishidentfid1 = @"realpartfinishidentfid1";

@implementation realpartfinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"练习报告";
    self.interstr = @"";
    self.headView.timeLab.text = [NSString stringWithFormat:@"%@%@",@"交卷时间: ",self.timestr];
    if ([self.typestr isEqualToString:@"1"]) {
       // self.leftLab.text = @"智能组卷";
        self.headView.nameLab.text = @"练习类型：智能组卷";
    }
    if ([self.typestr isEqualToString:@"2"]) {
        //self.leftLab.text = @"预测试题";
        self.headView.nameLab.text = @"练习类型：预测试题";
    }
    if ([self.typestr isEqualToString:@"3"]) {
        //self.leftLab.text = @"模拟试题";
        self.headView.nameLab.text = @"练习类型：模拟试题";
    }
    if ([self.typestr isEqualToString:@"4"]) {
        //self.leftLab.text = @"历年真题";
        self.headView.nameLab.text = @"练习类型：历年真题";
    }
    if ([self.typestr isEqualToString:@"5"]) {
       // self.leftLab.text = @"专项练习";
        self.headView.nameLab.text = @"练习类型：专项练习";
    }
    self.selectarray = [NSMutableArray array];
    for (int i = 0; i<self.dataArr.count; i++) {
        [self.selectarray addObject:@""];
    }
    [self.view addSubview:self.headView];
    [self prepareLayout];
    if (@available(iOS 11.0, *)){
        self.headView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collection.frame = CGRectMake(30, NAVIGATION_HEIGHT+80, kScreenW-60, kScreenH-NAVIGATION_HEIGHT-80);
    }
    else
    {
        self.headView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collection.frame = CGRectMake(30, 80, kScreenW-60, kScreenH-80);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(finishheadView *)headView
{
    if(!_headView)
    {
        _headView = [[finishheadView alloc] init];
        _headView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];

    }
    return _headView;
}

- (void)prepareLayout {
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(30, NAVIGATION_HEIGHT+60, kScreenW-60, kScreenH - NAVIGATION_HEIGHT-60) collectionViewLayout:self.layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.pagingEnabled = YES;
    self.collection.bounces = YES;
    self.layout.footerReferenceSize = CGSizeMake(kScreenW-60, 200);
    [self.collection registerClass:[realpartfinishCell class] forCellWithReuseIdentifier:realpartfinishidentfid0];
    [self.view addSubview:self.collection];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:realpartfinishidentfid1];
}

#pragma mark -UICollectionViewDataSource&&UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    realpartfinishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:realpartfinishidentfid0 forIndexPath:indexPath];
    cell.delegate = self;
    int intnum = (int)indexPath.item;
    int intnum2 = intnum+1;
    NSString *numstr = [NSString stringWithFormat:@"%d",intnum2];
    NSString *selectstr = self.selectarray[indexPath.item];
    [cell setdata:numstr answer0:self.answerarray0[indexPath.item] andanswer1:self.answerarray1[indexPath.item] andsetbtnstr:selectstr];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 0);//上下左右
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//头部显示的内容(此处可放置UIScrollview)

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionFooter withReuseIdentifier:realpartfinishidentfid1 forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];

    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setTitleColor:[UIColor colorWithHexString:@"FEFEFE"] forState:normal];
    [self.leftBtn setTitle:@"解析选中的题目" forState:normal];
    self.leftBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.leftBtn addTarget:self action:@selector(leftbtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    self.rightBtn = [[UIButton alloc] init];
    [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"FEFEFE"] forState:normal];
    [self.rightBtn setTitle:@"全部解析" forState:normal];
    self.rightBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [self.rightBtn addTarget:self action:@selector(rightbtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.frame = CGRectMake(30, 20, kScreenW/2-80, 40);
    self.rightBtn.frame = CGRectMake(kScreenW/2+30, 20, kScreenW/2-80, 40);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:self.leftBtn];
    [headerView addSubview:self.rightBtn];
    return headerView;
}

-(void)finish:(UICollectionViewCell *)cell
{
    self.selectarray = [NSMutableArray array];
    NSIndexPath *index = [self.collection indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    self.interstr = [NSString stringWithFormat:@"%ld",index.item];
    for (int i = 0; i<self.dataArr.count; i++) {
        [self.selectarray addObject:@"1"];
    }
    [self.selectarray replaceObjectAtIndex:index.item withObject:@"233"];
    [self.collection reloadData];
}

-(void)leftbtnclick
{
    smartgroupModel *model = [[smartgroupModel alloc] init];
    NSLog(@"inter----%@",self.interstr);
    int index = [self.interstr intValue];
    model = [self.modeldata objectAtIndex:index];
    realpartanalysisVC0 *vc = [realpartanalysisVC0 new];
    vc.model = model;
    vc.answer0 = self.answerarray0;
    vc.answer1 = self.answerarray1;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightbtnclick
{
    realpartanalysisVC1 *vc = [realpartanalysisVC1 new];
    vc.dataSource = self.modeldata;
    vc.answer0 = self.answerarray0;
    vc.answer1 = self.answerarray1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
