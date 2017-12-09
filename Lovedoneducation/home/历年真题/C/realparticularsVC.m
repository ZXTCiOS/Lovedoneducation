//
//  realparticularsVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsVC.h"
#import "headView.h"
#import "realparticularsCell0.h"
#import "realparticularsCell1.h"
#import "realCell.h"
#import "smartgroupModel.h"
#import "realpartcardVC.h"
#import "TZImagePickerController.h"
#import "TZAssetModel.h"
#import "TZImageManager.h"
#import "NSArray+JSON.h"
#import "LYMenu.h"
// 分享
#import "ZTVendorManager.h"
#import "ActionSheetView.h"
@interface realparticularsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,myTabVdelegate,TZImagePickerControllerDelegate>
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
@property (nonatomic, strong) NSMutableArray *imgarr;
@property (nonatomic, strong) NSMutableArray *cardtypeArray;
@property (nonatomic,strong) NSMutableArray *xuanzearray;
@property (nonatomic,strong) NSMutableArray *upquestion;//题目id
@property (nonatomic,strong) NSMutableArray *uplistarr;
@end

static NSString *realcellidentfid = @"realcellidentfid";

@implementation realparticularsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"真题详情";
    [self prepareLayout];
    [self.view addSubview:self.head];
    self.uplistarr = [NSMutableArray array];
    self.upquestion = [NSMutableArray array];
    self.xuanzearray = [NSMutableArray array];
    self.imgarr = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.arrayDatasource = [NSMutableArray array];
    self.cardtypeArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"确定"];
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
    self.indexPathNow = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现数据

-(void)loaddata
{
    NSString *url = [NSString stringWithFormat:GET_realQuestionDetail,self.qcid];
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
                if (![[dic objectForKey:@"qsuccess"] isEqualToString:@"zxtc"]) {
                    model.qsuccess = [dic objectForKey:@"qsuccess"];
                }
                else
                {
                    model.qsuccess = @"";
                }
                model.qtid = [dic objectForKey:@"qtid"];
                model.qtgroup = [dic objectForKey:@"qtgroup"];
                model.qtitle = [dic objectForKey:@"qtitle"];
                model.qtype = [dic objectForKey:@"qtype"];
                model.qtpath = [dic objectForKey:@"qtpath"];
                model.successnum = [dic objectForKey:@"successnum"];
                model.time = [dic objectForKey:@"time"];
                model.answerimgarr = [NSMutableArray array];
                [self.xuanzearray addObject: model.qsuccess];
                [self.upquestion addObject:model.qid];
                [self.dataSource addObject:model];
                
                
                if ([model.qtype isEqualToString:@"3"]) {
                    NSMutableArray *arr = [NSMutableArray new];
                    NSMutableDictionary *qiddic = [NSMutableDictionary dictionaryWithObject:model.qid forKey:@"qid"];
                    NSMutableDictionary *contentdic = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"content"];
                    NSMutableDictionary *imgdic = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"img"];
                    [arr addObject:qiddic];
                    [arr addObject:contentdic];
                    [arr addObject:imgdic];
                    [self.uplistarr addObject:arr];
                }

            }
            for (int i = 0; i<self.dataSource.count; i++) {
                [self.arrayDatasource addObject:@""];
                [self.cardtypeArray addObject:@""];
            }
            [self.collectionV reloadData];
            self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",@"1",@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
            smartgroupModel *model = [self.dataSource objectAtIndex:0];
            self.pidstr = model.qid;
            [self startCount];
            
        }
    } failure:^(NSError *error) {
        
    }];;
}

#pragma mark - getters

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
    [self.collectionV registerClass:[realCell class] forCellWithReuseIdentifier:realcellidentfid];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    realCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:realcellidentfid forIndexPath:indexPath];
    if (indexPath.row == self.dataSource.count - 1) {
        cell.copystr = @"1";
    }else{
        cell.copystr = @"2";
    }
    cell.delegate = self;
    [cell setarray:self.arrayDatasource[indexPath.item]];
    [cell setdata:self.dataSource[indexPath.item]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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

#pragma mark - 实现方法

-(void)cardclick
{
    NSLog(@"arr-----%@",self.uplistarr);
    NSMutableArray *arr0 = [NSMutableArray new];
    for (int i = 0; i<self.uplistarr.count; i++) {
        NSObject *obj = [self.uplistarr objectAtIndex:i];
        if ([obj isKindOfClass:[NSArray class]]) {
            [arr0 addObject:obj];
        }
        else
        {
            
        }
    }
    NSLog(@"arr0-----%@",arr0);
    NSString *upliststr = [arr0 toReadableJSONString];
    NSLog(@"str-----%@",upliststr);
    //错误答案
    NSString *upno = [self.arrayDatasource componentsJoinedByString:@","];
    //题目id
    NSString *upquestion = [self.upquestion componentsJoinedByString:@","];
    //正确答案
    NSString *upyes = [self.xuanzearray componentsJoinedByString:@","];
    //时间
    NSString *uptimes = self.timestr;
    //类型
    NSString *practiceType = @"4";
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSDictionary *dic = @{@"uid":uid,@"token":token,@"practiceType":practiceType,@"uptimes":uptimes,@"upno":upno,@"upquestion":upquestion,@"upyes":upyes,@"uplist":upliststr};
    NSLog(@"dic-----%@",dic);
    
    realpartcardVC *vc = [[realpartcardVC alloc] init];
    vc.modeldata = self.dataSource;
    vc.dataSource = self.cardtypeArray;
    vc.xuanzearr = self.arrayDatasource;
    vc.upnoarray = self.xuanzearray;
    vc.practiceType = practiceType;
    vc.uptimes = uptimes;
    vc.upno = upno;
    vc.upquestion = upquestion;
    vc.upyes = upyes;
    vc.uplist = upliststr;
    vc.typestr = @"4";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)queren:(UICollectionViewCell *)cell
{
    NSLog(@"选择题array====%@",self.self.arrayDatasource);
    NSMutableArray *arr0 = [NSMutableArray new];
    for (int i = 0; i<self.uplistarr.count; i++) {
        NSObject *obj = [self.uplistarr objectAtIndex:i];
        if ([obj isKindOfClass:[NSArray class]]) {
            [arr0 addObject:obj];
        }
        else
        {
            
        }
    }
    NSLog(@"arr0-----%@",arr0);
    NSString *upliststr = [arr0 toReadableJSONString];
    NSLog(@"str-----%@",upliststr);
    //错误答案
    NSString *upno = [self.arrayDatasource componentsJoinedByString:@","];
    //题目id
    NSString *upquestion = [self.upquestion componentsJoinedByString:@","];
    //正确答案
    NSString *upyes = [self.xuanzearray componentsJoinedByString:@","];
    //时间
    NSString *uptimes = self.timestr;
    //类型
    NSString *practiceType = @"4";
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSDictionary *dic = @{@"uid":uid,@"token":token,@"practiceType":practiceType,@"uptimes":uptimes,@"upno":upno,@"upquestion":upquestion,@"upyes":upyes,@"uplist":upliststr};
    NSLog(@"dic-----%@",dic);
    
    [DNNetworking postWithURLString:POST_practiceing parameters:dic success:^(id obj) {
        
        realpartcardVC *vc = [[realpartcardVC alloc] init];
        vc.modeldata = self.dataSource;
        vc.dataSource = self.cardtypeArray;
        vc.xuanzearr = self.arrayDatasource;
        vc.upnoarray = self.xuanzearray;
        //    vc.upquestion = self.upquestion;
        vc.practiceType = practiceType;
        vc.uptimes = uptimes;
        vc.upno = upno;
        vc.upquestion = upquestion;
        vc.upyes = upyes;
        vc.uplist = upliststr;
        vc.typestr = @"4";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)imgchoose:(UICollectionViewCell *)cell
{
    //__weak typeof(self)weakSelf = self;
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
                    smartgroupModel *model = [self.dataSource objectAtIndex:inter];
                    NSLog(@"model----%@",model);
                    [model.answerimgarr addObject:img];
                    [self.collectionV reloadItemsAtIndexPaths:@[self.indexPathNow]];
                    
                    NSIndexPath *index = [_collectionV indexPathForCell:cell];
                    NSLog(@"333===%ld",index.item);
                    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
                    
                    [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
                    
                    //uplist数组方法
                    int k = 0;
                    for (int i = 0; i<self.uplistarr.count; i++) {
                        NSArray *arr = [self.uplistarr objectAtIndex:i];
                        NSDictionary *qiddic = [arr firstObject];
                        NSString *qidstr = [qiddic objectForKey:@"qid"];
                        if ([qidstr isEqualToString:model.qid]) {
                            k = i;
                            break;
                        }
                    }
                    
                    NSMutableArray *arr2 = [self.uplistarr objectAtIndex:k];
                    NSMutableDictionary *imgdic2 = [arr2 objectAtIndex:2];
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

-(void)myTabVClickA:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"A"];
}

-(void)myTabVClickB:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"B"];
}

-(void)myTabVClickC:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"C"];
}

-(void)myTabVClickD:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
    [self.arrayDatasource replaceObjectAtIndex:index.item withObject:@"D"];
}

-(void)textstr:(UICollectionViewCell *)cell andtextstr:(NSString *)str
{
    NSIndexPath *index = [_collectionV indexPathForCell:cell];
    NSLog(@"333===%ld",index.item);
    smartgroupModel *model = self.dataSource[index.item];
    int k = 0;
    for (int i = 0; i<self.uplistarr.count; i++) {
        NSArray *arr = [self.uplistarr objectAtIndex:i];
        NSDictionary *qiddic = [arr firstObject];
        NSString *qidstr = [qiddic objectForKey:@"qid"];
        if ([qidstr isEqualToString:model.qid]) {
            k = i;
            break;
        }
    }
    NSMutableArray *arr2 = [self.uplistarr objectAtIndex:k];
    NSMutableDictionary *contentdic = [arr2 objectAtIndex:1];
    [contentdic setValue:str forKey:@"content"];
    [self.cardtypeArray replaceObjectAtIndex:index.item withObject:@"1"];
}

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

#pragma mark - 截图分享

- (void)screenShot:(UIScrollView *)basetable{
    UIImage* image = nil;
    UICollectionViewCell *cell = [self.collectionV cellForItemAtIndexPath:self.indexPathNow];
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, NO, 0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
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
