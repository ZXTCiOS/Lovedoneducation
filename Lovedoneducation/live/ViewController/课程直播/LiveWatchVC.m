//
//  LiveWatchVC.m
//  Lovedoneducation
//
//  Created by apple on 2017/10/28.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "LiveWatchVC.h"

@interface LiveWatchVC ()<UITableViewDelegate, UITableViewDataSource>

// 播放器



// 聊天室
@property (nonatomic, strong) UITableView *chatView;



@property (nonatomic, strong) NSMutableArray *datalist;

@end

@implementation LiveWatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datalist = [NSMutableArray array];
    
    
    
    
}




















#pragma mark - table view delegate , datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

#pragma mark - lazy loading

- (UITableView *)chatView{
    if (!_chatView) {
        _chatView = [[UITableView alloc] init];
        [self.view addSubview:_chatView];
        [_chatView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        _chatView.delegate = self;
        _chatView.dataSource = self;
    }
    return _chatView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
