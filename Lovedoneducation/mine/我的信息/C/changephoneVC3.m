//
//  changephoneVC3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneVC3.h"
#import "changephoneCell0.h"
#import "changephoneCell1.h"

@interface changephoneVC3 ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) NSString *valuestr;
@property (nonatomic,assign) BOOL ischoose;
@end

static NSString *changephone3identfid0 = @"changephone3identfid0";
static NSString *changephone3identfid1 = @"changephone3identfid1";
static NSString *changephone3identfid2 = @"changephone3identfid2";

@implementation changephoneVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    self.ischoose = NO;
    [self.view addSubview:self.table];
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
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabletap)];
        [_table addGestureRecognizer:tap];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changephone3identfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephone3identfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"修改手机号";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changephone3identfid1];
        if (!cell) {
            cell = [[changephoneCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephone3identfid1];
        }
        cell.phoneLabel.text = self.phone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        changephoneCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changephone3identfid2];
        if (!cell) {
            cell = [[changephoneCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephone3identfid2];
        }
        cell.delegate = self;
        cell.valuetext.tag = 202;
        cell.valuetext.delegate = self;
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
    if (indexPath.row==1) {
        return 240;
    }
    if (indexPath.row==2) {
        return 360;
    }
    return 0.01f;
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSString *phone = self.phone;
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

-(void)nextTabVClick:(UITableViewCell *)cell
{
    UITextField *text1 = [self.table viewWithTag:202];
    NSString *str = @"";
    if (text1.text.length==0) {
        
    }
    else
    {
        str = text1.text;
    }
    if ([str isEqualToString:self.valuestr]) {
        self.ischoose = YES;
    }
    else
    {
        self.ischoose = YES;
    }
    if (self.ischoose) {
        
        NSString *uid = [userDefault objectForKey:user_uid];
        NSString *token = [userDefault objectForKey:user_token];
        NSDictionary *dic = @{@"uphone":self.phone};
        NSString *para = [self convertToJsonData:dic];
        NSDictionary *postdic = @{@"uid":uid,@"token":token,@"param":para};
        [DNNetworking postWithURLString:POST_CHANGEINFO parameters:postdic success:^(id obj) {
            if ([[obj objectForKey:@"code"] intValue]==200) {
                [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
                [userDefault setObject:_phone forKey:user_phone];
                [self.navigationController popToRootViewControllerAnimated:YES];
                //[self.navigationController popViewControllerAnimated:YES];
                
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
}

-(void)tabletap
{
    UITextField *text = [self.table viewWithTag:202];
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
