//
//  mymoneyVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import "mymoneyVC.h"
#import "mymoneycell0.h"
#import "mymoneycell1.h"
#import "mymoneycell2.h"
#import "YQInAppPurchaseTool.h"

@interface mymoneyVC ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate,YQInAppPurchaseToolDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSString *moneystr;
@property (nonatomic,assign) BOOL isxuanze;
@property (nonatomic,strong) NSMutableArray *productArray;
@end

static NSString *moneyidentfid0 = @"moneyidentfid0";
static NSString *moneyidentfid1 = @"moneyidentfid1";
static NSString *moneyidentfid2 = @"moneyidentfid2";

@implementation mymoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    self.isxuanze = NO;
    self.productArray = [NSMutableArray array];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    
    
    //获取单例
    YQInAppPurchaseTool *IAPTool = [YQInAppPurchaseTool defaultTool];
    //设置代理
    IAPTool.delegate = self;
    //购买后，向苹果服务器验证一下购买结果。默认为YES。不建议关闭
    //IAPTool.CheckAfterPay = NO;
    //向苹果询问哪些商品能够购买
    [IAPTool requestProductsWithProductArray:@[@"com.problenchild.YQIAPTest.product1",
                                               @"com.problenchild.YQIAPTest.product2",
                                               @"com.problenchild.YQIAPTest.product3"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        mymoneycell0 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid0];
        if (!cell) {
            cell = [[mymoneycell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid0];
        }
        cell.moneylab.text = [userDefault objectForKey:user_uprice];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        mymoneycell1 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid1];
        if (!cell) {
            cell = [[mymoneycell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row==2) {
        mymoneycell2 *cell = [tableView dequeueReusableCellWithIdentifier:moneyidentfid2];
        if (!cell) {
            cell = [[mymoneycell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moneyidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }
    if (indexPath.row==1) {
        return 200;
    }
    if (indexPath.row==2) {
        return 80;
    }
    return 0.01f;
}

#pragma mark - 协议方法

-(void)myTabVClick0:(UITableViewCell *)cell
{
    self.moneystr = @"1";
    self.isxuanze = YES;
}

-(void)myTabVClick1:(UITableViewCell *)cell
{
    self.moneystr = @"12";
    self.isxuanze = YES;
}

-(void)myTabVClick2:(UITableViewCell *)cell
{
    self.moneystr = @"30";
    self.isxuanze = YES;
}

-(void)submitVClick1:(UITableViewCell *)cell
{
    
    
//    SKProduct *objd = [self.productArray objectAtIndex:2];
//    [self BuyProduct:[self.productArray firstObject]];
//    [self BuyProduct:objd];
    if (self.isxuanze) {
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"请选择充值金额" toView:self.view];
    }
}

#pragma mark --------YQInAppPurchaseToolDelegate
//IAP工具已获得可购买的商品
-(void)IAPToolGotProducts:(NSMutableArray *)products {
    NSLog(@"GotProducts:%@",products);
    //    for (SKProduct *product in products){
    //        NSLog(@"localizedDescription:%@\nlocalizedTitle:%@\nprice:%@\npriceLocale:%@\nproductID:%@",
    //              product.localizedDescription,
    //              product.localizedTitle,
    //              product.price,
    //              product.priceLocale,
    //              product.productIdentifier);
    //        NSLog(@"--------------------------");
    //    }
    self.productArray = products;
    
   // [self.tabV reloadData];

    //[SVProgressHUD showSuccessWithStatus:@"成功获取到可购买的商品"];
}
//支付失败/取消
-(void)IAPToolCanceldWithProductID:(NSString *)productID {
    NSLog(@"canceld:%@",productID);
    [MBProgressHUD showSuccess:@"购买失败" toView:self.view];
    //[SVProgressHUD showInfoWithStatus:@"购买失败"];
}
//支付成功了，并开始向苹果服务器进行验证（若CheckAfterPay为NO，则不会经过此步骤）
-(void)IAPToolBeginCheckingdWithProductID:(NSString *)productID {
    NSLog(@"BeginChecking:%@",productID);
    [MBProgressHUD showSuccess:@"购买成功，正在验证购买" toView:self.view];
}
//商品被重复验证了
-(void)IAPToolCheckRedundantWithProductID:(NSString *)productID {
    NSLog(@"CheckRedundant:%@",productID);
    

    [MBProgressHUD showSuccess:@"重复验证了" toView:self.view];
}
//商品完全购买成功且验证成功了。（若CheckAfterPay为NO，则会在购买成功后直接触发此方法）
-(void)IAPToolBoughtProductSuccessedWithProductID:(NSString *)productID
                                          andInfo:(NSDictionary *)infoDic {
    NSLog(@"BoughtSuccessed:%@",productID);
    NSLog(@"successedInfo:%@",infoDic);
    [self zhifuchenggong];
   // [MBProgressHUD showSuccess:@"购买成功！(相关信息已打印)" toView:self.view];
}
//商品购买成功了，但向苹果服务器验证失败了
//2种可能：
//1，设备越狱了，使用了插件，在虚假购买。
//2，验证的时候网络突然中断了。（一般极少出现，因为购买的时候是需要网络的）
-(void)IAPToolCheckFailedWithProductID:(NSString *)productID
                               andInfo:(NSData *)infoData {
    NSLog(@"CheckFailed:%@",productID);
    
    [MBProgressHUD showSuccess:@"验证失败了" toView:self.view];
}
//恢复了已购买的商品（仅限永久有效商品）
-(void)IAPToolRestoredProductID:(NSString *)productID {
    NSLog(@"Restored:%@",productID);

    [MBProgressHUD showSuccess:@"成功恢复了商品（已打印）" toView:self.view];
}
//内购系统错误了
-(void)IAPToolSysWrong {
    NSLog(@"SysWrong");
    [MBProgressHUD showSuccess:@"内购系统出错" toView:self.view];
}
//购买商品
-(void)BuyProduct:(SKProduct *)product{
    
    [[YQInAppPurchaseTool defaultTool]buyProduct:product.productIdentifier];
}

-(void)zhifuchenggong
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSDictionary *para = @{@"uid":uid,@"token":token,@"price":self.moneystr};
    [DNNetworking postWithURLString:POST_PRICE parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            NSString *uprice = [dic objectForKey:@"uprice"];
            [userDefault setObject:uprice forKey:user_uprice];
            [MBProgressHUD showSuccess:@"充值成功" toView:self.view];
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
