//
//  mineViewController.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineViewController.h"
#import "mineCell0.h"
#import "mineCell1.h"
#import "mineCell2.h"
#import "myinfoVC.h"
#import "securitiesVC.h"
#import "myinfomessageVC.h"
#import "coursescacheVC.h"
#import "feedbackVC.h"
#import "rankingVC.h"
#import "aboutVC.h"
#import "typeVC0.h"

@interface mineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy)   NSString *typestr;
@property (nonatomic,copy)   NSString *phonestr;
@property (nonatomic,copy)   NSString *nicknamestr;
@property (nonatomic,copy)   NSString *passwordstr;
@property (nonatomic,assign) BOOL firstenload;
@end

static NSString *mineidentfid0 = @"mineidentfid0";
static NSString *mineidentfid1 = @"mineidentfid1";
static NSString *mineidentfid2 = @"mineidentfid2";
static NSString *mineidentfid3 = @"mineidentfid3";
static NSString *mineidentfid4 = @"mineidentfid4";
static NSString *mineidentfid5 = @"mineidentfid5";
static NSString *mineidentfid6 = @"mineidentfid6";
static NSString *mineidentfid7 = @"mineidentfid7";
static NSString *mineidentfid8 = @"mineidentfid8";
static NSString *mineidentfid9 = @"mineidentfid9";


@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.firstenload = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"444444"]}];
    [self.view addSubview:self.table];
    
     if (@available(iOS 11.0, *)){
         self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT-LL_TabbarHeight);
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loaddata];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT-LL_TabbarHeight)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_INFO,uid,token];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSDictionary *dic = [obj objectForKey:@"data"];
            self.firstenload = YES;
            NSArray *utest_typearr = [dic objectForKey:@"utest_type"];
            NSArray *typearr = [utest_typearr objectAtIndex:0];
            NSString *string = [typearr componentsJoinedByString:@","];
            //self.typestr = [dic objectForKey:@"utest_type"];
            self.typestr = string;
            self.nicknamestr = [dic objectForKey:@"uname"];
            self.phonestr = [dic objectForKey:@"uphone"];
            self.passwordstr = [dic objectForKey:@"upwd"];
            [userDefault setObject:self.phonestr forKey:user_phone];
            NSArray* array = [self.typestr componentsSeparatedByString:@">>"];
            NSString *str = array.firstObject;
            [userDefault setObject:str forKey:user_type];
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        
    }];;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 9;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        mineCell0 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid0];
        if (!cell) {
            cell = [[mineCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid1];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid1];
            }
            cell.leftLab.text = @"考试类型";
            cell.typeLab.text = self.typestr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==1) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid2];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid2];
            }
            cell.leftLab.text = @"代金劵";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==2) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid3];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid3];
            }
            cell.leftLab.text = @"爱唐播报";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==3) {
            mineCell2 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid4];
            if (!cell) {
                cell = [[mineCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid4];
            }
            [cell.mainSwitch setOn:YES];
            if ([cell.mainSwitch isOn]){
                NSLog(@"The switch is on.");
            } else {
                NSLog(@"The switch is off.");
            }
            
            [cell.mainSwitch addTarget:self
                                action:@selector(switchIsChanged:)
                      forControlEvents:UIControlEventValueChanged];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==4) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid5];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid5];
            }
            cell.leftLab.text = @"课程缓存";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==5) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid6];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid6];
            }
            cell.leftLab.text = @"问题反馈";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==6) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid7];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid7];
            }
            cell.leftLab.text = @"山东名师琅琊榜";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        if (indexPath.row==7) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid8];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid8];
            }
            cell.leftLab.text = @"当前版本";
            cell.typeLab.text = @"1.0";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row==8) {
            mineCell1 *cell = [tableView dequeueReusableCellWithIdentifier:mineidentfid9];
            if (!cell) {
                cell = [[mineCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineidentfid9];
            }
            cell.leftLab.text = @"联系我们";
            cell.typeLab.text = @"";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50;
    }
    else
    {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (self.firstenload) {
            myinfoVC *vc = [[myinfoVC alloc] init];
            vc.phonestr = self.phonestr;
            vc.passwordstr = self.passwordstr;
            vc.nicknamestr = self.nicknamestr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            typeVC0 *vc = [[typeVC0 alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==1) {
            //代金劵
            securitiesVC *vc = [[securitiesVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==2) {
            myinfomessageVC *vc = [[myinfomessageVC alloc] init];
            vc.InActionType = ENUM_ViewController_ActionTypePush;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==4) {
            //课程缓存
            coursescacheVC *vc = [[coursescacheVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==5) {
            feedbackVC *vc = [[feedbackVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==6) {
            rankingVC *vc = [[rankingVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==8) {
            aboutVC *vc = [[aboutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 实现方法

- (void) switchIsChanged:(UISwitch *)paramSender {
    NSLog(@"Sender is = %@", paramSender);
    if ([paramSender isOn]){
        NSLog(@"The switch is turned on.");
    } else {
        NSLog(@"The switch is turned off.");
    }
}
@end
