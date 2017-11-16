//
//  smartgroupvolumeVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartgroupvolumeVC.h"
#import "smartgroupCell.h"
#import "smartgroupModel.h"
#import "headView.h"
#import "cardVC.h"
#import "LYMenu.h"

// 分享
#import "ZTVendorManager.h"
#import "ActionSheetView.h"

@interface smartgroupvolumeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDataSource,myTabVdelegate>
{
    dispatch_source_t timer;
}
@property (nonatomic, assign) int timeCount;
@property (nonatomic, strong) NSString *timestr;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) headView *head;
/**
 *  当前的位置
 */
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayDatasource;
@property (nonatomic, copy)   NSString *pidstr;
@end

@implementation smartgroupvolumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"智能组卷";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"1e2b3b"];
    [self prepareLayout];
    [self.view addSubview:self.head];
    self.dataSource = [NSMutableArray array];
    self.arrayDatasource = [NSMutableArray array];

    if (@available(iOS 11.0, *)){
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH-NAVIGATION_HEIGHT-60);
    }
    else
    {
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, 60, kScreenW, kScreenH-60);
    }
    [self loaddata];
    [self startCount];
}

-(headView *)head
{
    if(!_head)
    {
        _head = [[headView alloc] init];
        [_head.rightbtn addTarget:self action:@selector(cardclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _head;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint pInView = [self.view convertPoint:self.collectionV.center toView:self.collectionV];
    self.indexPathNow = [self.collectionV indexPathForItemAtPoint:pInView];
    int inter = (int)self.indexPathNow.item;
    int newint = inter+1;
    NSString *newstr = [NSString stringWithFormat:@"%ld",(long)newint];
    self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",newstr,@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
    
    smartgroupModel *model = [self.dataSource objectAtIndex:inter];
    self.pidstr = model.qid;
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
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *data = [obj objectForKey:@"data"];
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = [data objectAtIndex:i];
                smartgroupModel *model = [[smartgroupModel alloc] init];
                model.qid = [dic objectForKey:@"qid"];
                model.accuracy = [dic objectForKey:@"accuracy"];
                model.come = [dic objectForKey:@"come"];
                model.kaodian = [dic objectForKey:@"kaodian"];
                model.playnum = [dic objectForKey:@"playnum"];
                model.qanswer = [NSMutableArray array];
                model.qanswer = [dic objectForKey:@"qanswer"];
                model.qcid = [dic objectForKey:@"qcid"];
                model.qcontent = [NSMutableArray array];
                model.qcontent = [dic objectForKey:@"qcontent"];
                model.qctypeid = [dic objectForKey:@"qctypeid"];
                model.qdegree = [dic objectForKey:@"qdegree"];
                model.qdes = [NSMutableArray array];
                model.qdes = [dic objectForKey:@"qdes"];
                model.qerror = [dic objectForKey:@"qerror"];
                model.qsuccess = [dic objectForKey:@"qsuccess"];
                model.qtid = [dic objectForKey:@"qtid"];
                model.qtgroup = [dic objectForKey:@"qtgroup"];
                model.qtitle = [dic objectForKey:@"qtitle"];
                model.qtype = [dic objectForKey:@"qtype"];
                model.qtpath = [dic objectForKey:@"qtpath"];
                model.successnum = [dic objectForKey:@"successnum"];
                model.time = [dic objectForKey:@"time"];
                [self.dataSource addObject:model];
            }
            for (int i = 0; i<self.dataSource.count; i++) {
                [self.arrayDatasource addObject:@""];
            }
            [self.collectionV reloadData];
            self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",@"1",@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
            
            
            smartgroupModel *model = [self.dataSource objectAtIndex:0];
            self.pidstr = model.qid;
            
        }
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
    self.layout .itemSize = CGSizeMake(kScreenW, kScreenH - NAVIGATION_HEIGHT-60);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH - NAVIGATION_HEIGHT-60) collectionViewLayout:self.layout];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    smartgroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExamCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.dataSource.count - 1) {
        cell.copystr = @"1";
    }else{
        cell.copystr = @"2";
    }
    [cell setarray:self.arrayDatasource[indexPath.item]];
    cell.delegate = self;
    [cell setdata:self.dataSource[indexPath.item]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - 实现方法

/**
 开始倒计时方法
 */

-(void)startCount
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    //_isCreat = YES;
    
    //    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        int hours = _timeCount / 3600;
        int minutes = (_timeCount - (3600*hours)) / 60;
        int seconds = _timeCount%60;
        NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //           ======在这根据自己的需求去刷新UI==============
            
            self.timestr = strTime;
            self.head.timelab.text = strTime;
            
        });
        _timeCount ++;
    });
    dispatch_resume(timer);
}

-(void)myTabVClickA:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"A"];
}

-(void)myTabVClickB:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"B"];
    
}

-(void)myTabVClickC:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"C"];
}

-(void)myTabVClickD:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"D"];
}

-(void)cardclick
{
    cardVC *vc = [[cardVC alloc] init];
    vc.dataSource = self.arrayDatasource;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightAction
{
    LYMenu * menu = [[LYMenu alloc]initWithTitles:@[@"收藏本题",@"分享本题"] images:@[@"shoucangtimu_icon_gengduo",@"fenxiang_icon"] menuType:LYMenuTypeRight buttonAction:^(NSInteger buttonIndex) {
        NSLog(@"RightMenu INDEX %d",(int)buttonIndex);
        if (buttonIndex==0) {
            NSLog(@"收藏本题");
            NSLog(@"pid------%@",self.pidstr);
            NSString *uid = [userDefault objectForKey:user_uid];
            NSString *token = [userDefault objectForKey:user_token];
            NSDictionary *dic = @{@"uid":uid,@"token":token,@"qid":self.pidstr};
            [DNNetworking postWithURLString:POST_userCollection parameters:dic success:^(id obj) {
                if ([[obj objectForKey:@"code"] intValue]==200) {
                    [MBProgressHUD showSuccess:@"收藏成功" toView:self.collectionV];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        if (buttonIndex==1) {
            NSLog(@"分享本题");
            [self screenShot:self.collectionV];
        }
    }];
    [menu show];
}

#pragma mark - 截图发送

- (void)screenShot:(UIScrollView *)basetable{
    UIImage* image = nil;
//    UIGraphicsBeginImageContext(basetable.contentSize);
//    {
//        CGPoint savedContentOffset = basetable.contentOffset;
//        CGRect savedFrame = basetable.frame;
//        basetable.contentOffset = CGPointZero;
//
//        basetable.frame = CGRectMake(0, 0, basetable.contentSize.width, basetable.contentSize.height);
//        [basetable.layer renderInContext: UIGraphicsGetCurrentContext()];
//
//        image = UIGraphicsGetImageFromCurrentImageContext();
//
//        basetable.contentOffset = savedContentOffset;
//        basetable.frame = savedFrame;
//    }
//    UIGraphicsEndImageContext();
//
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (image != nil) {
        NSLog(@"截图成功!");
//    UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);

        NSArray *titlearr = @[@"微信朋友圈",@"微信好友",@"QQ"];
        NSArray *imageArr = @[@"wechatquan",@"wechat",@"tcentQQ"];
        
        ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享" and:ShowTypeIsShareStyle];
        [actionsheet setBtnClick:^(NSInteger btnTag) {
            NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",btnTag,titlearr[btnTag]);
            if (btnTag==0) {
                
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
               // model.shareimage = [UIImage imageNamed:@"shuliangguanxi_image_shouye"];
                [ZTVendorManager shareWith:ZTVendorPlatformTypeWechatFriends shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];

            }
            if (btnTag==1) {
                
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeWechat shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];
                
            }
            if (btnTag==2) {
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeQQ shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    
                }];
            }
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
        
    }
}


@end
