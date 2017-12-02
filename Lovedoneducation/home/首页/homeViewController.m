//
//  homeViewController.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeViewController.h"
#import "HomeModel.h"
// view
#import "HomeSortCell.h"
#import "HomeSort2Cell.h"
#import "HomeBannerView.h"
#import "HomeQiandaoView.h"
#import "HomeMoreView.h"
// viewcontroller
#import "HomeSortDetailVC.h"
#import "ZhuanXiangZhiNengPricticeVC.h"

//
#import "realquestionVC.h"
#import "typeVC0.h"

#import "messageVC.h"
#import "datareportVC.h"
#import "exerciseweeklyVC.h"
#import "wrongtopicVC.h"
#import "smartgroupvolumeVC.h"
#import "predictexamVC.h"
#import "simulationtestVC.h"
#import "collecttopicVC.h"

@interface homeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomeMoreView *moreV;
@property (nonatomic, strong) HomeDataModel *data;
@property (nonatomic, strong) UIButton *qiandao;
@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBar];
    [self.collectionView registerClass:[HomeSortCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeBannerView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self networking];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf networking];
    }];
}

- (void)configNaviBar{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if ( [userDefault objectForKey:user_type]) {
        
        self.title = [userDefault objectForKey:user_type];
    }
    UIButton *more = [UIButton buttonWithType:UIButtonTypeSystem];
    more.frame = CGRectMake(0, 0, 30, 15);
    more.titleLabel.font = [UIFont systemFontOfSize:14];
    more.tintColor = krgb(100, 100, 100);
    [more addTarget:self action:@selector(rightActionMore) forControlEvents:UIControlEventTouchUpInside];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    UIBarButtonItem *rightitemMore = [[UIBarButtonItem alloc] initWithCustomView:more];
    
    // message_icon_default_nav   message_icon_selected_nav
    UIImage *img = [UIImage imageNamed:@"message_icon_default_nav"];
    UIImage *image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightitemMsg = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightActionMessage)];
    [rightitemMore setTintColor:krgb(100, 100, 100)];
    
    
    UIButton *qiandao = [UIButton buttonWithType:UIButtonTypeSystem];
    qiandao.frame = CGRectMake(0, 0, 42, 15);
    qiandao.titleLabel.font = [UIFont systemFontOfSize:12];
    qiandao.tintColor = krgb(255,155,25);
    [qiandao addTarget:self action:@selector(leftActionQiandao:) forControlEvents:UIControlEventTouchUpInside];
    [qiandao setTitle:@"签到" forState:UIControlStateNormal];
    [qiandao setTitle:@"已签到" forState:UIControlStateDisabled];
    
    self.qiandao = qiandao;
    UIBarButtonItem *leftItemQiandao = [[UIBarButtonItem alloc] initWithCustomView:qiandao];
    //leftItemQiandao.tintColor = krgb(255,155,25);
    UIBarButtonItem *leftItemChange = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"kechengxuanze_icon_nav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftActionChange)];
    
    UIBarButtonItem * space_8 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_8.width = - 8;
    UIBarButtonItem * space_6 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_6.width = - 12;
    self.navigationItem.rightBarButtonItems = @[space_8, rightitemMore, space_6, rightitemMsg];
    self.navigationItem.leftBarButtonItems = @[space_8, leftItemChange, space_6, leftItemQiandao];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]}];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.moreV.hidden = YES;
}

- (void)networking{
    NSString *uid = [userDefault valueForKey:user_uid];
    NSString *token = [userDefault valueForKey:user_token];
    
    [DNNetworking getWithURLString:get_shouye parameters:@{@"uid": uid, @"token": token} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            HomeModel *model = [HomeModel parse:obj];
            self.data = model.data;
            [self.collectionView reloadData];
            self.qiandao.enabled = !model.data.isdeport;
            self.title = self.data.user.utest_type;
            [userDefault setObject:self.title forKey:user_type];
        }
        [self.collectionView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.collectionView endHeaderRefresh];
    }];
}

#pragma mark - UICollectionView  delegate && datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.quetions.count ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.quetions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    HomeQuestionsModel *quetion = self.data.quetions[indexPath.row];
    [cell.imgV setImageWithURL:quetion.img.xd_URL placeholder:[UIImage imageNamed:@"background_tixing_shouye"]];
    cell.titleL.text = quetion.qtname;
    cell.titleL.textColor = krgb(50, 50, 50);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HomeQuestionsModel *quetion = self.data.quetions[indexPath.row];
    for (HomeChildModel *quetion in self.data.quetions[indexPath.row].child) {
        if (!quetion.child.count) {
            HomeChild2Model *model = [HomeChild2Model new];
            model.img = quetion.img;
            model.qtid = quetion.qtid;
            model.qtname = quetion.qtname;
            NSArray *arr = @[model];
            quetion.child = arr;
        }
    }
    // 第一层为空 则直接跳转专项练习
    if (!quetion.child.count) {
        ZhuanXiangZhiNengPricticeVC *vc = [[ZhuanXiangZhiNengPricticeVC alloc] init];
        vc.qtid = quetion.qtid;
        vc.qtname = quetion.qtname;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    // 否则跳向二级
    HomeSortDetailVC *vc = [[HomeSortDetailVC alloc] init];
    vc.child = quetion.child;
    vc.title = quetion.qtname;
    HomeChildModel *childmodel = quetion.child[indexPath.item];
    if ([childmodel.ischarge isEqualToString:@"1"]) {
        [MBProgressHUD showSuccess:@"请先付费" toView:self.view];
    }
    else
    {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }
    HomeBannerView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenW *7 / 15 + 100);
    [view.shujubaogao addTarget:self action:@selector(shujubaogaoclick) forControlEvents:UIControlEventTouchUpInside];
    [view.zhinengzujuan addTarget:self action:@selector(zhinengzujuanclick) forControlEvents:UIControlEventTouchUpInside];
    [view.yuceshiti addTarget:self action:@selector(yuceshiticlick) forControlEvents:UIControlEventTouchUpInside];
    [view.monishiti addTarget:self action:@selector(monishiticlick) forControlEvents:UIControlEventTouchUpInside];
    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 7 / 15.0) imageUrls:nil timeInterval:2 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
        
    }];
    // TODO: add default image
    loop.placeholder = [UIImage imageNamed:@"background_banner_shouye"];
    [view.bannerV addSubview:loop];
    NSMutableArray *arr = [NSMutableArray array];
    for (HomeSlideModel *slide in self.data.slide) {
        [arr addObject:slide.posterimg];
        if (slide == self.data.slide.lastObject) {
            loop.imageUrls = arr;
        }
    }
    loop.pageControlEnabled = YES;
    return view;
}

#pragma mark FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, kScreenW *7 / 15 + 100);
}


#pragma mark - 实现方法

-(void)rightActionMore
{
    self.moreV.hidden = !self.moreV.hidden;
}

-(void)rightActionMessage
{
    messageVC *vc = [[messageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftActionQiandao:(UIButton *)button{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    [DNNetworking postWithURLString:post_qiandao_fenxiang_pinglun parameters:@{@"uid": uid, @"token": token, @"type": @(1)} success:^(id obj) {
        NSString *code = [obj objectForKey:@"code"];
        NSDictionary *data = [obj objectForKey:@"data"];
        if ([code isEqualToString:@"200"]) {
            HomeQiandaoView *qiandao = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HomeQiandaoView class]) owner:nil options:nil].firstObject;
            qiandao.frame = CGRectMake(0, 0, kScreenW, kScreenH);
            qiandao.tip.text = [data valueForKey:@"tip"];
            qiandao.dayL.text = [data valueForKey:@"day"];
            if ([[data valueForKey:@"tip"] isEqualToString:@"zxtc"]) {
                qiandao.tip.text = @"Tips: 连续签到10天可截图至微信公众号领取更多现金抵用券哦~";
            }
            [qiandao.cancelBtn bk_addEventHandler:^(id sender) {
                qiandao.hidden = YES;
                [qiandao removeFromSuperview];
            } forControlEvents:UIControlEventTouchUpInside];
            self.qiandao.enabled = NO;
            [self.view addSubview:qiandao];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络异常, 签到失败"];
    }];
}

- (void)leftActionChange{
    typeVC0 *vc = [[typeVC0 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 30, 12);
        CGFloat width = (kScreenW - 34) / 2;
        layout.itemSize = CGSizeMake(width, width * 9 / 17.0 + 31);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        if (@available(iOS 11.0, *)) {
            _collectionView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH - NAVIGATION_HEIGHT);
        } else {
            _collectionView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        }
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (HomeMoreView *)moreV{
    if (!_moreV) {
        _moreV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HomeMoreView class]) owner:nil options:nil].firstObject;
        // 计算导航栏高度
        _moreV.frame = CGRectMake(0, LL_StatusBarAndNavigationBarHeight, kScreenW, kScreenH - LL_StatusBarAndNavigationBarHeight);
        [self.view addSubview:_moreV];
        _moreV.hidden = YES;
        [_moreV.linianzhenti addTarget:self action:@selector(linianzhenticlick) forControlEvents:UIControlEventTouchUpInside];
        [_moreV.cuotiben addTarget:self action:@selector(cuotibenclick) forControlEvents:UIControlEventTouchUpInside];
        [_moreV.shoucangtimu addTarget:self action:@selector(shoucangtimuclick) forControlEvents:UIControlEventTouchUpInside];
        [_moreV.lianxizhoubao addTarget:self action:@selector(lianxizhoubaoclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreV;
}

#pragma mark - 实现方法

-(void)linianzhenticlick
{
    realquestionVC *vc = [[realquestionVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)cuotibenclick
{
    wrongtopicVC *vc = [[wrongtopicVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)shoucangtimuclick
{
    collecttopicVC *vc = [[collecttopicVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)lianxizhoubaoclick
{
    exerciseweeklyVC *vc = [[exerciseweeklyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark banner-click

//数据报告
-(void)shujubaogaoclick
{
    datareportVC *vc = [[datareportVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//智能组卷
-(void)zhinengzujuanclick
{
    smartgroupvolumeVC *vc = [[smartgroupvolumeVC alloc] init];
    vc.InActionType = ENUM_ViewController_ActionType0;
    [self.navigationController pushViewController:vc animated:YES];
}
//预测试题
-(void)yuceshiticlick
{
    smartgroupvolumeVC *vc = [[smartgroupvolumeVC alloc] init];
    vc.InActionType = ENUM_ViewController_ActionType1;
    [self.navigationController pushViewController:vc animated:YES];
}
//模拟试题
-(void)monishiticlick
{
    smartgroupvolumeVC *vc = [[smartgroupvolumeVC alloc] init];
    vc.InActionType = ENUM_ViewController_ActionType2;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
