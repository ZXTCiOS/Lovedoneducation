//
//  predictexamVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "predictexamVC.h"

@interface predictexamVC ()

@end

@implementation predictexamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预测试题";
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *practiceType = @"2";
    //1 智能组卷 2预测试题 3专项智能练习
    NSString *url = [NSString stringWithFormat:GET_practice,uid,token,practiceType];
    [DNNetworking getWithURLString:url success:^(id obj) {
        
    } failure:^(NSError *error) {
        
    }];;
}

@end
