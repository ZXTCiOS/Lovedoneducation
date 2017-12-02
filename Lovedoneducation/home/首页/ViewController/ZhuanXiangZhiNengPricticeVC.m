//
//  ZhuanXiangZhiNengPricticeVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "ZhuanXiangZhiNengPricticeVC.h"

@interface ZhuanXiangZhiNengPricticeVC ()

@end

@implementation ZhuanXiangZhiNengPricticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@专项联系", self.qtname];
    kSetNaviBarColor_50;
}


-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    
    
    
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
