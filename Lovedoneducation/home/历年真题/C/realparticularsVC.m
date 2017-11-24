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
#import "realpartfinishVC.h"

#import "LDActionSheet.h"
#import "LDImagePicker.h"

@interface realparticularsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,myTabVdelegate,LDActionSheetDelegate,LDImagePickerDelegate>
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

@property (nonatomic, strong) LDActionSheet *originSheet;
@property (nonatomic, strong) LDActionSheet *customSheet;
@property (nonatomic, strong) NSMutableArray *imgarr;
@end

static NSString *realcellidentfid = @"realcellidentfid";

@implementation realparticularsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"真题详情";
    [self prepareLayout];
    [self.view addSubview:self.head];
    self.imgarr = [NSMutableArray array];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现数据

-(void)loaddata
{
    self.qcid = @"1";
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
                model.qsuccess = [dic objectForKey:@"qsuccess"];
                model.qtid = [dic objectForKey:@"qtid"];
                model.qtgroup = [dic objectForKey:@"qtgroup"];
                model.qtitle = [dic objectForKey:@"qtitle"];
                model.qtype = [dic objectForKey:@"qtype"];
                model.qtpath = [dic objectForKey:@"qtpath"];
                model.successnum = [dic objectForKey:@"successnum"];
                model.time = [dic objectForKey:@"time"];
                model.answerimgarr = [NSMutableArray array];
                
                [self.dataSource addObject:model];
            }
//            for (int i = 0; i<self.dataSource.count; i++) {
//                [self.arrayDatasource addObject:@""];
//            }
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
    //[cell setarray:self.arrayDatasource[indexPath.item]];
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
    
}

-(void)queren:(UICollectionViewCell *)cell
{
    realpartfinishVC *vc = [[realpartfinishVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)imgchoose:(UICollectionViewCell *)cell
{
    self.originSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"相册", nil];
    [self.originSheet showInView:self.view];
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([actionSheet isEqual:self.customSheet]) {
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
//        self.height.constant = 200*0.75;
    }else{
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showOriginalImagePickerWithType:buttonIndex InViewController:self];
    }
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
//    self.height.constant = editedImage.size.height/editedImage.size.width*200;
//    self.imgeView.image = editedImage;

    
    [self updateimg:editedImage];
}

-(void)updateimg:(UIImage *)img
{
//    UIImage *originImage = img;
//    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSLog(@"encodedImageStr==%@",encodedImageStr);
//
//
//    NSString *file = encodedImageStr;
//    NSString *type = @"png";
//    NSDictionary *para = @{@"file":file,@"type":type};
//
//    [DNNetworking postWithURLString:GET_uploadImage parameters:para success:^(id obj) {
//        if ([[obj objectForKey:@"code"] intValue]==200) {
//            NSString *imgurl = [obj objectForKey:@"data"];
//            NSLog(@"imgurl = %@",imgurl);
//            int inter = (int)self.indexPathNow.item;
//            smartgroupModel *model = [self.dataSource objectAtIndex:inter];
//            NSLog(@"model----%@",model);
//            [model.answerimgarr addObject:img];
//            [self.collectionV reloadItemsAtIndexPaths:@[self.indexPathNow]];
//        }
//    } failure:^(NSError *error) {
//
//    }];
    
    [MBProgressHUD showMessage:@"提升" toView:self.view];
    
}

-(void)myTabVClickA:(UICollectionViewCell *)cell
{
    
}

-(void)myTabVClickB:(UICollectionViewCell *)cell
{
    
}

-(void)myTabVClickC:(UICollectionViewCell *)cell
{
    
}

-(void)myTabVClickD:(UICollectionViewCell *)cell
{
    
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
@end
