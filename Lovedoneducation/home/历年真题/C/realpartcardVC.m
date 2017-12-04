//
//  realpartcardVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartcardVC.h"
#import "realpardcardCell.h"
#import "realparlcardModel.h"
#import "realpartfinishVC.h"

@interface realpartcardVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIView *footView;
@end


static NSString *realpardcardientfid0 = @"realpardcardientfid0";
static NSString *realpardcardientfid1 = @"realpardcardientfid1";

@implementation realpartcardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.typestr isEqualToString:@"1"]) {
        self.leftLab.text = @"智能组卷";
    }
    if ([self.typestr isEqualToString:@"2"]) {
        self.leftLab.text = @"预测试题";
    }
    if ([self.typestr isEqualToString:@"3"]) {
        self.leftLab.text = @"模拟试题";
    }
    if ([self.typestr isEqualToString:@"4"]) {
        self.leftLab.text = @"历年真题";
    }
    if ([self.typestr isEqualToString:@"5"]) {
        self.leftLab.text = @"专项练习";
    }
    self.title = @"答题卡";
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

-(UIView *)headView
{
    if(!_headView)
    {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_headView addSubview:self.leftLab];
    }
    return _headView;
}

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.frame = CGRectMake(15, 10, kScreenW-30, 40);
        _leftLab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _leftLab.font = [UIFont systemFontOfSize:15];
    }
    return _leftLab;
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
    [self.collection registerClass:[realpardcardCell class] forCellWithReuseIdentifier:realpardcardientfid0];
    [self.view addSubview:self.collection];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:realpardcardientfid1];
}

#pragma mark -UICollectionViewDataSource&&UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    realpardcardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:realpardcardientfid0 forIndexPath:indexPath];
    int intnum = (int)indexPath.item;
    int intnum2 = intnum+1;
    NSString *numstr = [NSString stringWithFormat:@"%d",intnum2];
    [cell setdata:self.dataSource[indexPath.item] andnumitem:numstr];
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
                                            UICollectionElementKindSectionFooter withReuseIdentifier:realpardcardientfid1 forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    self.submitBtn = [[UIButton alloc] init];
    [self.submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    [self.submitBtn setTitle:@"交卷并查看结果" forState:normal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    self.submitBtn.frame = CGRectMake(headerView.frame.size.width/2-110, 30, 220, 44);
    [self.submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.submitBtn];
    return headerView;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
//    NSLog(@"submit");
//    NSLog(@"array----%@",self.xuanzearr);
//    NSLog(@"upno-----%@",self.upnoarray);
//    NSLog(@"upquestion---%@",self.upquestion);
//
//
//    NSString *uid = [userDefault objectForKey:user_uid];
//    NSString *token = [userDefault objectForKey:user_token];
//
//    NSDictionary *dic = @{@"uid":uid,@"token":token,@"practiceType":self.practiceType,@"uptimes":self.uptimes,@"upno":self.upno,@"upquestion":self.upquestion,@"upyes":self.upyes,@"uplist":self.uplist};
//
//    NSLog(@"dic-----%@",dic);
//
//    [DNNetworking postWithURLString:POST_practiceing parameters:dic success:^(id obj) {
//
//    } failure:^(NSError *error) {
//
//    }];
//
    realpartfinishVC *vc = [[realpartfinishVC alloc] init];
    vc.dataArr = self.dataSource;
    vc.answerarray0 = self.xuanzearr;
    vc.answerarray1 = self.upnoarray;
    vc.modeldata = self.modeldata;
    vc.typestr = self.typestr;
    vc.timestr = [self getCurrentTimes];
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end
