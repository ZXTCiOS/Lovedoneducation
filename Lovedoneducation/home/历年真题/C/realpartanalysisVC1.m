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
#import "UIBarButtonItem+ZYExtension.h"
#import "LYMenu.h"
// 分享
#import "ZTVendorManager.h"
#import "ActionSheetView.h"
@interface realpartanalysisVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *head;
@property (nonatomic, strong) UILabel *headnameLab;
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic,copy) NSString *pidstr;
@end

static NSString *realanalysisCellidentfid = @"realanalysisCellidentfid";

@implementation realpartanalysisVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"错题分析";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"gengduo_icon_default_cuotifenxi-" highImage:@"gengduo_icon_selected_cuotifenxi" target:self action:@selector(rightAction)];
    
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
    self.indexPathNow = [NSIndexPath indexPathForItem:0 inSection:0];
    smartgroupModel *model = [self.dataSource firstObject];
    self.pidstr = model.qid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint pInView = [self.view convertPoint:self.collectionV.center toView:self.collectionV];
    self.indexPathNow = [self.collectionV indexPathForItemAtPoint:pInView];
    int inter = (int)self.indexPathNow.item;
    smartgroupModel *model = [self.dataSource objectAtIndex:inter];
    self.pidstr = model.qid;
}

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
        
    } failure:^(NSError *error) {
        
    }];
}

@end
