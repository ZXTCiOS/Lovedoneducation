//
//  forgetVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "forgetVC.h"
#import "forgetCell0.h"
#import "logupCell1.h"
#import "logupCell2.h"


@interface forgetVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,assign) BOOL ischoose;
@property (nonatomic,copy)   NSString *verifycode;
@end

static NSString *forgetidentfid0 = @"forgetidentfid0";
static NSString *forgetidentfid1 = @"forgetidentfid1";
static NSString *forgetidentfid2 = @"forgetidentfid2";
static NSString *forgetidentfid3 = @"forgetidentfid3";
static NSString *forgetidentfid4 = @"forgetidentfid4";

@implementation forgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    self.ischoose = NO;
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)) {
        self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    self.table.tableFooterView = self.footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - getters


-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
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
        _footView.frame = CGRectMake(0, 0, kScreenW, 150*HEIGHT_SCALE);
        [_footView addSubview:self.submitBtn];
    }
    return _footView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"完成" forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        _submitBtn.frame = CGRectMake(kScreenW/2-175/2*WIDTH_SCALE, 40*HEIGHT_SCALE, 175*WIDTH_SCALE, 44*HEIGHT_SCALE);
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
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
        forgetCell0 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid0];
        if (!cell) {
            cell = [[forgetCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid1];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.delegate = self;
        cell.infotext.placeholder = @"请输入手机号";
        cell.infotext.keyboardType = UIKeyboardTypePhonePad;
        cell.infotext.tag = 301;
        return cell;
    }
    if (indexPath.row==2) {
        logupCell2 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid2];
        if (!cell) {
            cell = [[logupCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.yanzhengtext.delegate = self;
        cell.yanzhengtext.placeholder = @"请输入手机验证码";
        cell.yanzhengtext.keyboardType = UIKeyboardTypePhonePad;
        cell.yanzhengtext.tag = 302;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row==3) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid3];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.delegate = self;
        cell.infotext.placeholder = @"请输入密码";
        cell.infotext.secureTextEntry = YES;
        cell.infotext.tag = 303;
        return cell;
    }
    if (indexPath.row==4) {
        logupCell1 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid4];
        if (!cell) {
            cell = [[logupCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infotext.delegate = self;
        cell.infotext.placeholder = @"请确认密码";
        cell.infotext.secureTextEntry = YES;
        cell.infotext.tag = 304;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

-(void)tabletap
{
    UITextField *text0 = [self.table viewWithTag:301];
    UITextField *text1 = [self.table viewWithTag:302];
    UITextField *text2 = [self.table viewWithTag:303];
    UITextField *text3 = [self.table viewWithTag:304];
    [text0 resignFirstResponder];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    UITextField *text1 = [self.table viewWithTag:302];
    NSString *phone = @"";
    if (text1.text.length==0) {
        phone = @"";
    }else
    {
        phone = text1.text;
    }
    NSString *type = @"2";
    NSDictionary *para = @{@"phone":phone,@"type":type};
    [DNNetworking postWithURLString:POST_value parameters:para success:^(id obj) {
        NSLog(@"obj-----%@",obj);
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.verifycode = [dic objectForKey:@"verifycode"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
}

-(void)submitbtnclick
{
    UITextField *text0 = [self.table viewWithTag:301];
    UITextField *text1 = [self.table viewWithTag:302];
    UITextField *text2 = [self.table viewWithTag:303];
    UITextField *text3 = [self.table viewWithTag:304];
    
    NSString *phone = @"";
    NSString *value = @"";
    NSString *password0 = @"";
    NSString *password1 = @"";
    
    if (text0.text.length==0) {
        
    }
    else
    {
        phone = text0.text;
    }
    if (text1.text.length==0) {
        
    }
    else
    {
        value = text1.text;
    }
    if (text2.text.length==0) {
        
    }
    else
    {
        password0 = text2.text;
    }
    if (text3.text.length==0) {
        
    }
    else
    {
        password1 = text3.text;
    }
    
    if ([self.verifycode isEqualToString:value]&&self.verifycode.length!=0) {
        self.ischoose = YES;
    }else
    {
        self.ischoose = YES;
    }
    if ([password1 isEqualToString:password0]&&password0.length!=0) {
        NSString *str = password0;
        NSString *uphone = phone;
        NSString *upwd = [MD5Tool MD5ForLower32Bate:str];
        NSDictionary *para = @{@"uname":uphone,@"upwd":upwd};
        [DNNetworking postWithURLString:POST_forget parameters:para success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

@end
