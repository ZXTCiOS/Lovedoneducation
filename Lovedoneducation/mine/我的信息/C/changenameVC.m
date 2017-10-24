//
//  changenameVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changenameVC.h"
#import "changephoneCell2.h"

@interface changenameVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *submitBtn;
@end

static NSString *changenameidentfid0 = @"changenameidentfid0";
static NSString *changenameidentfid1 = @"changenameidentfid1";

@implementation changenameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    
    [self.view addSubview:self.table];
    self.table.tableFooterView = self.footView;
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changenameidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changenameidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"请输入新的昵称";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell2 *cell = [tableView dequeueReusableCellWithIdentifier:changenameidentfid1];
        if (!cell) {
            cell = [[changephoneCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changenameidentfid1];
        }
        cell.phoneText.tag = 201;
        cell.phoneText.placeholder = @"请输入新的昵称";
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
    NSString *namestr = @"";
    UITextField *nameText = [self.table viewWithTag:201];
    if (nameText.text.length==0) {
        namestr = @"";
    }
    else
    {
        namestr = nameText.text;
    }
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSDictionary *dic = @{@"uname":namestr};
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
