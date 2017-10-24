//
//  changephoneVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneVC.h"
#import "changephoneCell0.h"
#import "changephoneCell1.h"
#import "changephoneVC2.h"

@interface changephoneVC ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,assign) BOOL ischoose;
@property (nonatomic,copy)   NSString *valuestr;
@end
static NSString *changephoneidentfid0 = @"changephoneidentfid0";
static NSString *changephoneidentfid1 = @"changephoneidentfid1";
static NSString *changephoneidentfid2 = @"changephoneidentfdi2";
@implementation changephoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号信息";
    self.ischoose = NO;
    [self.view addSubview:self.table];
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changephoneidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephoneidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"修改手机号";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        changephoneCell0 *cell = [tableView dequeueReusableCellWithIdentifier:changephoneidentfid1];
        if (!cell) {
            cell = [[changephoneCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephoneidentfid1];
        }
        self.phonestr = [userDefault objectForKey:user_phone];
        cell.phoneLabel.text = self.phonestr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        changephoneCell1 *cell = [tableView dequeueReusableCellWithIdentifier:changephoneidentfid2];
        if (!cell) {
            cell = [[changephoneCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changephoneidentfid2];
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

    NSString *phone = self.phonestr;
   
    NSString *type = @"1";
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
        changephoneVC2 *vc = [[changephoneVC2 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)tabletap
{
    UITextField *text = [self.table viewWithTag:202];
    [text resignFirstResponder];
}
@end
