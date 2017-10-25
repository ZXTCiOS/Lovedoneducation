//
//  liveViewController.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "liveViewController.h"
#import "LiveModel.h"
#import "LiveCourseCell.h"


@interface liveViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation liveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableheaderView];
    [self netWorking];
}

- (void)tableheaderView{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    view.backgroundColor = krgb(8, 210, 278);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 14, 70, 16)];
    label.text = @"我的课程";
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 20, 15.5, 7, 13)];
    imgV.image = [UIImage imageNamed:@"weizhankai_button_default"];
    [view addSubview:imgV];
    [view bk_addEventHandler:^(id sender) {
        // TODO: 跳转到我的课程
        
    } forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = view;
}

- (void)netWorking{
    [self.tableView addHeaderRefresh:^{
        
    }];
    [self.tableView addFooterRefresh:^{
        
    }];
}
- (void)headerRefresh{
    
}
- (void)footerRefresh{
    
}


#pragma mark tableview delegate & datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}


#pragma mark lazy load

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
