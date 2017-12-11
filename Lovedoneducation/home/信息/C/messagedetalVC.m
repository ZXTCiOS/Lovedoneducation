//
//  messagedetalVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messagedetalVC.h"

@interface messagedetalVC ()

@end

@implementation messagedetalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    // Do any additional setup after loading the view.
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
    NSString *url = [NSString stringWithFormat:GET_messageDetail,uid,token,self.questionid,self.type];
    [DNNetworking getWithURLString:url success:^(id obj) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
