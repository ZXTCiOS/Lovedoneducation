//
//  realpartanalysisVC0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/30.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartanalysisVC0.h"
#import "realparticularsCell0.h"
#import "realparticularsCell1.h"
#import "realpartanalysisCell1.h"
#import "realpartanalysisCell2.h"
#import "realpartanalysisCell3.h"
#import "UIBarButtonItem+ZYExtension.h"
#import "LYMenu.h"
// 分享
#import "ZTVendorManager.h"
#import "ActionSheetView.h"
@interface realpartanalysisVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSString *pidstr;
@end

static NSString *realparticularsCellidentfid0 = @"realparticularsCellidentfid0";
static NSString *realparticularsCellidentfid1 = @"realparticularsCellidentfid1";
static NSString *realparticularsCellidentfid2 = @"realparticularsCellidentfid2";
static NSString *realparticularsCellidentfid3 = @"realparticularsCellidentfid3";
static NSString *realparticularsCellidentfid4 = @"realparticularsCellidentfid4";

@implementation realpartanalysisVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"错题分析";
    [self.view addSubview:self.table];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"gengduo_icon_default_cuotifenxi-" highImage:@"gengduo_icon_selected_cuotifenxi" target:self action:@selector(rightAction)];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        realparticularsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid0];
        if (!cell) {
            cell = [[realparticularsCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid0];
        }
        [cell setdata:self.model.qcontent andtype:self.model.qtype andtitle:self.model.qtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        realparticularsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid1];
        if (!cell) {
            cell = [[realparticularsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid1];
        }
        [cell setarray:self.model.qanswer andtype:self.model.qtype andimgarr:self.model.answerimgarr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell clickanswer0:self.answer0[indexPath.row] andanswer1:self.answer1[indexPath.row]];
        return cell;
    }
    if (indexPath.row==2) {
        realpartanalysisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid2];
        if (!cell) {
            cell = [[realpartanalysisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata: self.model.come];
        return cell;
    }
    if (indexPath.row==3) {
        realpartanalysisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid3];
        if (!cell) {
            cell = [[realpartanalysisCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.model.qdes anderrorstr:self.model.qerror andaccuracystr:self.model.accuracy];
        return cell;
    }
    if (indexPath.row==4) {
        realpartanalysisCell3 *cell = [tableView dequeueReusableCellWithIdentifier:realparticularsCellidentfid4];
        if (!cell) {
            cell = [[realpartanalysisCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realparticularsCellidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdatacomestr:self.model.come];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

-(void)rightAction
{
    LYMenu * menu = [[LYMenu alloc]initWithTitles:@[@"收藏本题",@"分享本题"] images:@[@"shoucangtimu_icon_gengduo",@"fenxiang_icon"] menuType:LYMenuTypeRight buttonAction:^(NSInteger buttonIndex) {
        NSLog(@"RightMenu INDEX %d",(int)buttonIndex);
        if (buttonIndex==0) {
            NSLog(@"收藏本题");
            NSString *uid = [userDefault objectForKey:user_uid];
            NSString *token = [userDefault objectForKey:user_token];
            self.pidstr = self.model.qid;
            NSDictionary *dic = @{@"uid":uid,@"token":token,@"qid":self.pidstr};
            [DNNetworking postWithURLString:POST_userCollection parameters:dic success:^(id obj) {
                if ([[obj objectForKey:@"code"] intValue]==200) {
                    [MBProgressHUD showSuccess:@"收藏成功" toView:self.table];
                }
                if ([[obj objectForKey:@"code"] intValue]==014) {
                    [MBProgressHUD showSuccess:@"已收藏本题" toView:self.table];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        if (buttonIndex==1) {
            NSLog(@"分享本题");
            [self screenShot:self.table];
        }
    }];
    [menu show];
}

#pragma mark - 截图发送

- (void)screenShot:(UIScrollView *)basetable{
    UIImage* image = nil;
    UIView *cell = self.table;
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
        [MBProgressHUD showSuccess:@"分享成功" toView:self.view];
    } failure:^(NSError *error) {
        
    }];
}
@end
