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
#import "essayorderVC.h"
@interface essayVC ()<UICollectionViewDelegate,UICollectionViewDataSource,myTabVdelegate,TZImagePickerControllerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
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
@property (nonatomic,strong) NSMutableArray *pricearray;
@property (nonatomic,assign) BOOL isclick;
@end

static NSString *essayidentfid = @"essayidentfid";

@implementation essayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isclick = NO;
    self.title = [NSString stringWithFormat:@"%@专项联系%@", self.qtname,@"(需付费)"];
    kSetNaviBarColor_50;
    self.imgarr = [NSMutableArray array];
    self.uplistarr = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.cardtypeArray = [NSMutableArray array];
    self.pricearray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    [self prepareLayout];
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

/*!
  @header essayVC.h
  申论题目信息
 */
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
                model.answerimgarr = [NSMutableArray array];
                [self.dataSource addObject:model];
            }
            for (int j = 0; j<data.count; j++) {
                [self.cardtypeArray addObject:@""];
                [self.uplistarr addObject:@""];
            }
            
            for (int k = 0; k<self.dataSource.count; k++) {
                NSMutableArray *arr = [NSMutableArray new];
                NSMutableDictionary *contentdic = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"content"];
                NSMutableDictionary *imgdic = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"img"];
                [arr addObject:contentdic];
                [arr addObject:imgdic];
                [self.uplistarr replaceObjectAtIndex:k withObject:arr];
            }
            
            self.isclick = YES;
            [self.collectionV reloadData];
            self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",@"1",@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
            essayModel *model = [self.dataSource objectAtIndex:0];
            self.pidstr = model.qcid;
            [self startCount];
        }
        else
        {
            [MBProgressHUD showSuccess:@"该分类暂时没有题目" toView:self.view];
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
/*!
 @header essayVC.h
 申论界面布局
 */
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
    self.collectionV.emptyDataSetSource = self;
    self.collectionV.emptyDataSetDelegate = self;
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
    if (indexPath.row == self.dataSource.count - 1) {
        cell.copystr = @"1";
    }else{
        cell.copystr = @"2";
    }
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

/**
 答题卡
 */
-(void)cardclick
{
    if (self.isclick) {
        int numd = 0;
        NSString *numstr = @"";
        [self.pricearray removeAllObjects];
        for (int i = 0; i<self.cardtypeArray.count; i++) {
            NSString *str = [self.cardtypeArray objectAtIndex:i];
            essayModel *model = [self.dataSource objectAtIndex:i];
            if ([str isEqualToString: @"1"]) {
                NSString *money = model.price;
                [self.pricearray addObject:money];
                numd++;
                numstr = [NSString stringWithFormat:@"%d",numd];
            }
        }
        NSNumber *sum = [self.pricearray valueForKeyPath:@"@sum.floatValue"];
        NSString *sumstr = [NSString stringWithFormat:@"%@",sum];
        
        //数组重组
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i<self.cardtypeArray.count; i++) {
            NSString *str = [self.cardtypeArray objectAtIndex:i];
            NSObject *obj = [self.uplistarr objectAtIndex:i];
            if ([str isEqualToString:@"1"]) {
                [array addObject:obj];
            }
        }
        
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSString * markintro = [strisNull arrayToJSONString:array];
        NSMutableArray *idarr = [NSMutableArray array];
        for (int i = 0; i<self.dataSource.count; i++) {
            [idarr addObject:@""];
        }
        for (int i = 0; i<self.cardtypeArray.count; i++) {
            NSString *str = [self.cardtypeArray objectAtIndex:i];
            if ([str isEqualToString:@"1"]) {
                essayModel *model = [self.dataSource objectAtIndex:i];
                NSString *mqid2 = model.mqid;
                [idarr replaceObjectAtIndex:i withObject:mqid2];
            }
        }
        NSString *mqid = [idarr componentsJoinedByString:@","];
        NSMutableDictionary *paradic = [NSMutableDictionary dictionary];
        [paradic setValue:uid forKey:@"uid"];
        [paradic setValue:token forKey:@"token"];
        [paradic setValue:mqid forKey:@"mqid"];
        [paradic setValue:markintro forKey:@"markintro"];

        
        essaycardVC *vc = [[essaycardVC alloc] init];
        vc.dataSource = self.cardtypeArray;
        vc.pricestr = sumstr;
        vc.numstr = numstr;
        vc.para = [NSMutableDictionary dictionary];
        vc.para = paradic;
        vc.titlestr = [NSString stringWithFormat:@"%@专项联系%@", self.qtname,@"(需付费)"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 协议方法

-(void)submit:(UICollectionViewCell *)cell
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i<self.cardtypeArray.count; i++) {
        NSString *str = [self.cardtypeArray objectAtIndex:i];
        NSObject *obj = [self.uplistarr objectAtIndex:i];
        if ([str isEqualToString:@"1"]) {
            [array addObject:obj];
        }
    }
    
    int numd = 0;
    NSString *numstr = @"";
    [self.pricearray removeAllObjects];
    for (int i = 0; i<self.cardtypeArray.count; i++) {
        NSString *str = [self.cardtypeArray objectAtIndex:i];
        essayModel *model = [self.dataSource objectAtIndex:i];
        if ([str isEqualToString: @"1"]) {
            NSString *money = model.price;
            [self.pricearray addObject:money];
            numd++;
            numstr = [NSString stringWithFormat:@"%d",numd];
        }
    }
    NSNumber *sum = [self.pricearray valueForKeyPath:@"@sum.floatValue"];
    NSString *sumstr = [NSString stringWithFormat:@"%@",sum];
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];

    NSString * markintro = [strisNull arrayToJSONString:array];
    NSMutableArray *idarr = [NSMutableArray array];
    for (int i = 0; i<self.dataSource.count; i++) {
        [idarr addObject:@""];
    }
    for (int i = 0; i<self.cardtypeArray.count; i++) {
        NSString *str = [self.cardtypeArray objectAtIndex:i];
        if ([str isEqualToString:@"1"]) {
            essayModel *model = [self.dataSource objectAtIndex:i];
            NSString *mqid2 = model.mqid;
            [idarr replaceObjectAtIndex:i withObject:mqid2];
        }
    }
    NSString *mqid = [idarr componentsJoinedByString:@","];
    NSMutableDictionary *paradic = [NSMutableDictionary dictionary];
    [paradic setValue:uid forKey:@"uid"];
    [paradic setValue:token forKey:@"token"];
    [paradic setValue:mqid forKey:@"mqid"];
    [paradic setValue:markintro forKey:@"markintro"];
    essayorderVC *vc = [[essayorderVC alloc] init];
    vc.pricestr = sumstr;
    vc.numstr = numstr;
    vc.para = [NSMutableDictionary dictionary];
    vc.para = paradic;
    vc.timestr = [self getCurrentTimes];
    [self.navigationController pushViewController:vc animated:YES];
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
                    [model.answerimgarr addObject:imgurl];
                    [self.collectionV reloadItemsAtIndexPaths:@[self.indexPathNow]];
                    NSIndexPath *index = [_collectionV indexPathForCell:cell];
                    NSLog(@"333===%ld",index.item);
                    [self.cardtypeArray replaceObjectAtIndex:inter withObject:@"1"];
                    [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
                    //uplist数组方法
                    NSMutableArray *arr = [self.uplistarr objectAtIndex:inter];
                    NSMutableDictionary *imgdic2 = [arr objectAtIndex:1];
                    NSObject *imgobj = [imgdic2 objectForKey:@"img"];
                    NSMutableArray *imgarr = [NSMutableArray new];
                    if ([imgobj isKindOfClass:[NSString class]]) {
                        [imgarr addObject:imgurl];
                        [imgdic2 setValue:imgarr forKey:@"img"];
                    }
                    else
                    {
                        imgarr = [imgdic2 objectForKey:@"img"];
                        [imgarr addObject:imgurl];
                        [imgdic2 setValue:imgarr forKey:@"img"];
                    }
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
        NSMutableArray *arr = [self.uplistarr objectAtIndex:index.item];
        NSMutableDictionary *strdic = [arr firstObject];
        [strdic setValue:str forKey:@"content"];
    }
    else
    {
        
    }
    essayModel *model = self.dataSource[index.item];
    model.textstr = str;
    [self.collectionV reloadData];
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
                if ([[obj objectForKey:@"code"] intValue]==014) {
                    [MBProgressHUD showSuccess:@"已收藏本题" toView:self.collectionV];
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
                    if (success) {
                        [self fenxiangblock];
                    }
                }];
                
            }
            if (btnTag==1) {
                
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeWechat shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    if (success) {
                        [self fenxiangblock];
                    }
                }];
                
            }
            if (btnTag==2) {
                ZTVendorShareModel *model = [[ZTVendorShareModel alloc]init];
                model.shareimage = image;
                [ZTVendorManager shareWith:ZTVendorPlatformTypeQQ shareModel:model completionHandler:^(BOOL success, NSError * error) {
                    if (success) {
                        [self fenxiangblock];
                    }
                }];
            }
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
        
    }
}

-(void)fenxiangblock
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *type = @"2";
    NSDictionary *dic = @{@"uid":uid,@"token":token,@"type":type};
    [DNNetworking postWithURLString:post_qiandao_fenxiang_pinglun parameters:dic success:^(id obj) {
        [MBProgressHUD showSuccess:@"分享成功" toView:self.view];
    } failure:^(NSError *error) {
        
    }];
}

//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *title = @"该分类暂时没有题目";
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
//                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
//                                 };
//    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
//}

@end
