//
//  feedbackVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "feedbackVC.h"
#import "feedbackCell.h"
#import "WJGtextView.h"

@interface feedbackVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIView *footview;
@property (nonatomic,strong) UIButton *submitbtn;
@end

static NSString *feedbackidentfid0 = @"feedbackidentfid0";
static NSString *feedbackidentfid1 = @"feedbackidentfid1";

@implementation feedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程反馈";
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = self.footview;
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


-(UIView *)footview
{
    if(!_footview)
    {
        _footview = [[UIView alloc] init];
        _footview.backgroundColor = [UIColor whiteColor];
        _footview.frame = CGRectMake(0, 0, kScreenW, 200*HEIGHT_SCALE);
        [_footview addSubview:self.submitbtn];
    }
    return _footview;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitbtn setTitle:@"提交建议" forState:normal];
        [_submitbtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        _submitbtn.frame = CGRectMake(100, 40, kScreenW-200, 44);
    }
    return _submitbtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedbackidentfid0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:feedbackidentfid0];
        }
        cell.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"您的建议与感想对我们非常重要哦";
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        return cell;
    }
    if (indexPath.row==1) {
        feedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:feedbackidentfid1];
        if (!cell) {
            cell = [[feedbackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:feedbackidentfid1];
        }
        cell.feedtext.tag = 201;
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
        return 320;
    }
}

-(void)tabletap
{
    WJGtextView *textview = [self.table viewWithTag:201];
    [textview resignFirstResponder];
}

/**
 提交问题反馈
 */
-(void)submitbtnclick
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *prodes = @"";
    WJGtextView *textview = [self.table viewWithTag:201];
    if (textview.text.length==0) {
        prodes = @"";
    }
    else
    {
        prodes = textview.text;
    }
    NSDictionary *para = @{@"uid":uid,@"token":token,@"prodes":prodes};
    [DNNetworking postWithURLString:POST_proposal parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
