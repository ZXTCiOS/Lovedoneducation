//
//  typeVC1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "typeVC1.h"
#import "changeCell1.h"
#import "changeModel1.h"

@interface typeVC1 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSString *secondtype;
@end

static NSString *type1identfid0 = @"type1identfid0";
static NSString *type1identfid1 = @"type1identfid1";

@implementation typeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择要参加的考试";
    self.secondtype = @"0";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"646464"];
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
    
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    
}

#pragma mark -getters

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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:type1identfid0];
    if (!cell) {
        cell = [[changeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:type1identfid0];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    [cell setdata:self.dataSource[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"646464"];
    cell.textLabel.highlightedTextColor = [UIColor colorWithHexString:@"FFFFFF"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.secondtype = @"1";
    changeModel1 *model = self.dataSource[indexPath.row];
    self.testid = model.testid;
    self.utest_type = model.testpath;
    NSLog(@"testid---%@",self.testid);
    NSLog(@"utest_type====%@",model.testpath);
}


#pragma mark - 实现方法

-(void)rightAction
{
     if ([self.secondtype isEqualToString:@"1"])
     {
         NSString *uid = [userDefault objectForKey:user_uid];
         NSString *token = [userDefault objectForKey:user_token];
         NSDictionary *dic = @{@"testid":self.testid};
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
     else
     {
         [MBProgressHUD showSuccess:@"请选择类型" toView:self.view];
     }
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
