//
//  essayVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayVC.h"
#import "essayModel.h"
#import "essayCell.h"
#import "headView.h"
#import "TZImagePickerController.h"
#import "TZAssetModel.h"
#import "TZImageManager.h"
#import "NSArray+JSON.h"
#import "LYMenu.h"
// 分享
#import "ZTVendorManager.h"
#import "ActionSheetView.h"
#import "essaycardVC.h"

@interface essayVC ()<UICollectionViewDelegate,UICollectionViewDataSource,myTabVdelegate,TZImagePickerControllerDelegate>
{
    dispatch_source_t timer;
}
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) headView *head;
@property (nonatomic, assign) int timeCount;
@property (nonatomic, strong) NSString *timestr;
@property (nonatomic, strong) UICollectionView *collectionV;
/**
 *  当前的位置
 */
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *imgarr;
@property (nonatomic, strong) NSMutableArray *uplistarr;
@property (nonatomic, strong) NSMutableArray *cardtypeArray;

@property (nonatomic,copy) NSString *pidstr;
@end

static NSString *essayidentfid = @"essayidentfid";

@implementation essayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@专项联系%@", self.qtname,@"(需付费)"];
    kSetNaviBarColor_50;
    self.imgarr = [NSMutableArray array];
    self.uplistarr = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.cardtypeArray = [NSMutableArray array];
    [self prepareLayout];
    self.indexPathNow = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.view addSubview:self.head];
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
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"确定"];
    self.indexPathNow = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint pInView = [self.view convertPoint:self.collectionV.center toView:self.collectionV];
    self.indexPathNow = [self.collectionV indexPathForItemAtPoint:pInView];
    int inter = (int)self.indexPathNow.item;
    int newint = inter+1;
    NSString *newstr = [NSString stringWithFormat:@"%ld",(long)newint];
    self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",newstr,@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
    essayModel *model = [self.dataSource objectAtIndex:inter];
    self.pidstr = model.qcid;
}


#pragma mark - 数据源

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_specialpractice,uid,token,self.qtid];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *data = [obj objectForKey:@"data"];
            for (int i = 0; i<data.count; i++) {
                essayModel *model = [[essayModel alloc] init];
                NSDictionary *dic = [data objectAtIndex:i];
                model.areaid = [dic objectForKey:@"areaid"];
                model.dateflag = [dic objectForKey:@"dataflag"];
                model.mqid = [dic objectForKey:@"mqid"];
                model.mqintro = [NSMutableArray array];
                model.mqintro = [dic objectForKey:@"mqintro"];
                model.mqtitle = [dic objectForKey:@"mqtitle"];
                model.price = [dic objectForKey:@"price"];
                model.qcid = [dic objectForKey:@"qcid"];
                model.qtid = [dic objectForKey:@"qtid"];
                model.qtpath = [dic objectForKey:@"qtpath"];
                model.time = [dic objectForKey:@"time"];
                [self.dataSource addObject:model];
            }
            for (int j = 0; j<data.count; j++) {
                [self.cardtypeArray addObject:@""];
                [self.uplistarr addObject:@""];
            }
            [self.collectionV reloadData];
            self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",@"1",@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
            essayModel *model = [self.dataSource objectAtIndex:0];
            self.pidstr = model.qcid;
            [self startCount];
        }
    } failure:^(NSError *error) {
        
    }];;
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
    [self.collectionV registerClass:[essayCell class] forCellWithReuseIdentifier:essayidentfid];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    essayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:essayidentfid forIndexPath:indexPath];
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

-(void)cardclick
{
    essaycardVC *vc = [[essaycardVC alloc] init];
    vc.dataSource = self.cardtypeArray;
    vc.titlestr = [NSString stringWithFormat:@"%@专项联系%@", self.qtname,@"(需付费)"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 协议方法

-(void)queren:(UICollectionViewCell *)cell
{
    
}

-(void)imgchoose:(UICollectionViewCell *)cell
{
    TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    pickerController.naviBgColor = [UIColor colorWithHexString:@"08D2B2"];
    pickerController.needCircleCrop = YES;
    pickerController.circleCropRadius = 100;
    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photo.count) {
            
            UIImage *img = [photo firstObject];
            UIImage *originImage = img;
            NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            NSLog(@"encodedImageStr==%@",encodedImageStr);
            
            NSString *file = encodedImageStr;
            NSString *type = @"png";
            NSDictionary *para = @{@"file":file,@"type":type};
            
            [MBProgressHUD showMessage:@"正在上传" toView:self.view];
            
            [DNNetworking postWithURLString:GET_uploadImage parameters:para success:^(id obj) {
                [MBProgressHUD hideHUDForView:self.view];
                
                if ([[obj objectForKey:@"code"] intValue]==200) {
                    
                    NSString *imgurl = [obj objectForKey:@"data"];
                    NSLog(@"imgurl = %@",imgurl);
                    [self.imgarr addObject:imgurl];
                    int inter = (int)self.indexPathNow.item;
                    essayModel *model = [self.dataSource objectAtIndex:inter];
                    NSLog(@"model----%@",model);
                    [model.answerimgarr addObject:img];
                    [self.collectionV reloadItemsAtIndexPaths:@[self.indexPathNow]];
                    
                    NSIndexPath *index = [_collectionV indexPathForCell:cell];
                    NSLog(@"333===%ld",index.item);
                    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];

                    [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
                    
                    //uplist数组方法
                    NSMutableArray *arr = [self.uplistarr objectAtIndex:inter];
                    NSDictionary *imgdic = @{@"img":self.imgarr};
                    [arr addObject:imgdic];
                    
                }
                else
                {
                    [MBProgressHUD showSuccess:@"上传失败" toView:self.view];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:@"上传失败，请检查网络" toView:self.view];
            }];;
            
        }
    }];
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)textstr:(UICollectionViewCell *)cell andtextstr:(NSString *)str
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);

    if (str.length!=0) {
        [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
    }
    essayModel *model = self.dataSource[index.item];
    model.textstr = str;
    [self.collectionV reloadData];
}
@end
