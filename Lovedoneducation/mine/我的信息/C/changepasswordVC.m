//
//  changepasswordVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changepasswordVC.h"
#import "changephoneCell0.h"
#import "changepasswordCell0.h"
#import "changepasswordCell1.h"

@interface changepasswordVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,assign) BOOL ischoose;
@property (nonatomic,copy)   NSString *valuestr;
@end

static NSString *changepassidentfid0 = @"changepassidentfid0";
static NSString *changepassidentfid1 = @"changepassidentfid1";
static NSString *changepassidentfid2 = @"changepassidentfid2";
static NSString *changepassidentfid3 = @"changepassidentfid3";
static NSString *changepassidentfid4 = @"changepassidentfid4";

@implementation changepasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    self.ischoose = NO;
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
        [_footView addSubview:self.submitBtn];
        _footView.frame = CGRectMake(0, 0, kScreenW, 120);
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitBtn setTitle:@"提交修改" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.frame = CGRectMake(100, 50, kScreenW-200, 44);
    }
    return _submitBtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changepassidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepassidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"修改密码";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changepassidentfid1];
        if (!cell) {
            cell = [[changephoneCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepassidentfid1];
        }
        NSString *phonestr = [userDefault objectForKey:user_phone];
        cell.phoneLabel.text = phonestr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        changepasswordCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changepassidentfid2];
        if (!cell) {
            cell = [[changepasswordCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepassidentfid2];
        }
        cell.valuetext.delegate = self;
        cell.delegate = self;
        cell.valuetext.tag = 301;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==3) {
        changepasswordCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changepassidentfid3];
        if (!cell) {
            cell = [[changepasswordCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepassidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"新的密码";
        cell.passwordText.placeholder = @"不少于6位";
        cell.passwordText.delegate = self;
        cell.passwordText.tag = 302;
        return cell;
    }
    if (indexPath.row==4) {
        changepasswordCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changepassidentfid4];
        if (!cell) {
            cell = [[changepasswordCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepassidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.text = @"重复密码";
        cell.passwordText.placeholder = @"再次输入密码";
        cell.passwordText.delegate = self;
        cell.passwordText.tag = 303;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50;
    }
    if (indexPath.row==1) {
        return 200;
    }
    if (indexPath.row==2) {
        return 100;
    }
    if (indexPath.row==3) {
        return 70;
    }
    if (indexPath.row==4) {
        return 70;
    }
    return 0.01f;
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSString *phone = [userDefault objectForKey:user_phone];
    NSString *type = @"2";
    NSDictionary *para = @{@"phone":phone,@"type":type};
    [DNNetworking postWithURLString:POST_value parameters:para success:^(id obj) {
        NSLog(@"obj-----%@",obj);
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.valuestr = [dic objectForKey:@"verifycode"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
}

-(void)submitbtnclick
{
    UITextField *value = [self.table viewWithTag:301];
    NSString *str = @"";
    if (value.text==0) {
        str = @"";
    }
    else
    {
        str = value.text;
    }
    if ([str isEqualToString:self.valuestr]) {
        self.ischoose = YES;
    }
    else
    {
        [MBProgressHUD showSuccess:@"验证码不正确" toView:self.view];
        //self.ischoose = YES;
    }
    NSString *password0 = @"";
    NSString *password1 = @"";
    
    UITextField *text1 = [self.table viewWithTag:302];
    UITextField *text2 = [self.table viewWithTag:303];
    
    if (text1.text.length==0) {
        password0 = @"";
    }
    else
    {
        password0 = text1.text;
    }
    if (text2.text.length==0) {
        password1 = @"";
    }
    else
    {
        password1 = text2.text;
    }
    
    
    if (self.ischoose) {
        //验证码正确
        if ([password0 isEqualToString:password1]&&password0.length!=0) {
            
            NSString *password = password0;
            NSString *uid = [userDefault objectForKey:user_uid];
            NSString *token = [userDefault objectForKey:user_token];
            NSDictionary *dic = @{@"upwd":password};
            NSString *para = [self convertToJsonData:dic];
            NSDictionary *postdic = @{@"uid":uid,@"token":token,@"param":para};
            [DNNetworking postWithURLString:POST_CHANGEINFO parameters:postdic success:^(id obj) {
                if ([[obj objectForKey:@"code"] intValue]==200) {
                    [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    //[self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"请输入正确的验证码" toView:self.view];
    }
}

-(void)tabletap
{
    UITextField *text0 = [self.table viewWithTag:301];
    UITextField *text1 = [self.table viewWithTag:302];
    UITextField *text2 = [self.table viewWithTag:303];
    [text0 resignFirstResponder];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
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
