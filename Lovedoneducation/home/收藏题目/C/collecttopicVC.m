//
//  collecttopicVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "collecttopicVC.h"

@interface collecttopicVC ()

@end

@implementation collecttopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏题目";
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
    NSString *type = @"2";
    NSString *url = [NSString stringWithFormat:GET_userquestion,uid,token,type];
    [DNNetworking getWithURLString:url success:^(id obj) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
