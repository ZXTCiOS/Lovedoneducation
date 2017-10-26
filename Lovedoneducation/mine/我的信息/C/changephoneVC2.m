//
//  changephoneVC2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneVC2.h"
#import "changephoneCell2.h"
#import "IBAlertView.h"

@interface changephoneVC2 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@end

static NSString *changephonevc2identfid0 = @"changephonevc2identfid0";
static NSString *changephonevc2identfid1 = @"changephonevc2identfid1";

@implementation changephoneVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
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
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
        [_table addGestureRecognizer:tap];
    }
    return _table;
}

-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor whiteColor];
        _footView.frame = CGRectMake(0, 0, kScreenW, kScreenH-NAVIGATION_HEIGHT-130);
        [_footView addSubview:self.submitBtn];
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"下一步" forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitBtn.frame = CGRectMake(100, 160*HEIGHT_SCALE, kScreenW-200, 44);
    }
    return _submitBtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changephonevc2identfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephonevc2identfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"添加新的手机号";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell2 *cell = [tableView dequeueReusableCellWithIdentifier:changephonevc2identfid1];
        if (!cell) {
            cell = [[changephoneCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephonevc2identfid1];
        }
        cell.phoneText.tag = 201;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50;
    }
    else
    {
        return 60;
    }
}

-(void)submitbtnclick
{
    NSString *phonestr = @"";
    UITextField *text = [self.table viewWithTag:201];
    if (text.text.length==0) {
        phonestr = @"";
    }
    else
    {
        phonestr = text.text;
    }
//    NSString *uid = [userDefault objectForKey:user_uid];
//    NSString *token = [userDefault objectForKey:user_token];
//    NSDictionary *dic = @{@"uphone":phonestr};
//    NSString *para = [self convertToJsonData:dic];
//    NSDictionary *postdic = @{@"uid":uid,@"token":token,@"param":para};
//    [DNNetworking postWithURLString:POST_CHANGEINFO parameters:postdic success:^(id obj) {
//        if ([[obj objectForKey:@"code"] intValue]==200) {
//            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            //[self.navigationController popViewControllerAnimated:YES];
//
//        }
//    } failure:^(NSError *error) {
//
//    }];
    IBConfigration *configration = [[IBConfigration alloc] init];
    configration.title = @"温馨提示";
    configration.message = @"我们即将发送短信验证码到这个手机";
    configration.cancelTitle = @"取消";
    configration.confirmTitle = @"确定";
    configration.phonestr = phonestr;
    configration.tintColor = [UIColor yellowColor];
    configration.messageAlignment = NSTextAlignmentLeft;
    
    IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
        if (index == 2) {
            NSLog(@"点击确定了");
        }
    }];
    [alerView show];
}

-(void)tabletap
{
    UITextField *text = [self.table viewWithTag:201];
    [text resignFirstResponder];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
@end
