//
//  homeViewController.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeViewController.h"

@interface homeViewController ()

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"国家公务员考试";
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    UIBarButtonItem *rightitem0 = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction0)];
    UIBarButtonItem *rightitem1 = [[UIBarButtonItem alloc] initWithTitle:@"签到" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction1)];
    [rightitem0 setTintColor:[UIColor redColor]];
    NSArray *actionButtonItems = @[rightitem0, rightitem1];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现方法

-(void)rightAction0
{
    
}

-(void)rightAction1
{
    
}

@end
