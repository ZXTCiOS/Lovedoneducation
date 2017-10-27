//
//  typeVC1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "typeVC1.h"

@interface typeVC1 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation typeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择考试类型";
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}
@end
