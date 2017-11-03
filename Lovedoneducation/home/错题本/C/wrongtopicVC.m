//
//  wrongtopicVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/2.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wrongtopicVC.h"
#import "wrongtopicModel.h"
#import "wrongtopicCell.h"

@interface wrongtopicVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation wrongtopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"错题本";
    [self.view addSubview:self.table];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    //模拟数据
    _dataArr = [NSMutableArray array];
    
    NSArray *first_indexs = @[@1,@2];
    NSArray *second_indexs = @[@0,@1];
    NSArray *third_indexs = @[@0,@1,@2];
    
    for (int i=0; i<first_indexs.count; i++) {
        for (int j=0; j<second_indexs.count; j++) {
            for (int k=0; k<third_indexs.count; k++) {
                wrongtopicModel *model = [wrongtopicModel new];
                model.first_index = [first_indexs[i] integerValue];
                if (j==0) {
                    if (k==0) {
                        model.second_index = 0;
                        model.third_index = 0;
                        model.is_open = YES;
                        model.is_show = YES;
                        [_dataArr addObject:model];
                    }
                    continue;
                }
                model.second_index = [second_indexs[j] integerValue];
                model.third_index = [third_indexs[k] integerValue];
                model.is_open = YES;
                model.is_show = YES;
                [_dataArr addObject:model];
            }
        }
    }
    [self.table reloadData];
}

#pragma mark - getters

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

#pragma mark - data update

- (void)clickCellAtIndexPath:(NSIndexPath *)indexPath
{
    wrongtopicModel *current_model = _dataArr[indexPath.row];
    //如果点击的是一级cell
    if (current_model.second_index == 0 && current_model.third_index == 0) {
        //如果该一级cell是展开的
        if (current_model.is_open) {
            for (wrongtopicModel *model in _dataArr) {
                BOOL is_belong = model.first_index == current_model.first_index;    //是否在当前分组
                BOOL is_current = model.second_index == 0;                           //是否是一级cell
                //如果在当前分组下，并且不是一级cell,则全部隐藏，关闭
                if (is_belong && !is_current) {
                    model.is_open = NO;
                    model.is_show = NO;
                }
                else
                {
                    //其他一级cell，不操作
                }
            }
            //关闭该一级cell
            current_model.is_open = NO;
            [self.table reloadData];
            return;
        }
        //如果该一级cell是关闭的
        else
        {
            for (wrongtopicModel *model in _dataArr) {
                BOOL is_belong = model.first_index == current_model.first_index;    //是否在当前分组
                BOOL is_current = model.second_index == 0;                           //是否是一级cell
                //如果在当前分组下，并且不是一级cell,则二级cell显示,三级cell不操作
                if (is_belong && !is_current) {
                    //如果是二级cell
                    if (model.third_index == 0) {
                        model.is_show = YES;
                    }
                    else
                    {
                        //三级cell，不操作
                    }
                }
                else
                {
                    //其他一级cell，不操作
                }
            }
            //打开该一级cell
            current_model.is_open = YES;
            [self.table reloadData];
            return;
        }
    }
    
    //如果点击的是二级cell
    if (current_model.third_index == 0) {
        //如果该二级cell是展开的
        if (current_model.is_open) {
            for (wrongtopicModel *model in _dataArr) {
                BOOL is_belong = model.second_index == current_model.second_index && model.first_index == current_model.first_index;  //是否在当前分组
                BOOL is_current = model.third_index == 0;                           //是否是二级cell
                //如果在当前分组下，并且不是二级cell，则全部隐藏
                if (is_belong && !is_current) {
                    model.is_show = NO;
                }
                else
                {
                    //其他二级cell，不操作
                }
            }
            //关闭该二级cell
            current_model.is_open = NO;
            [self.table reloadData];
            return;
        }
        //如果该二级cell是关闭的
        else
        {
            for (wrongtopicModel *model in _dataArr) {
                BOOL is_belong = model.second_index == current_model.second_index && model.first_index == current_model.first_index;  //是否在当前分组
                BOOL is_current = model.third_index == 0;                           //是否是二级cell
                //如果在当前分组下，并且不是二级cell，则全部显示
                if (is_belong && !is_current) {
                    model.is_show = YES;
                }
                else
                {
                    //其他二级cell，不操作
                }
            }
            //打开该二级cell
            current_model.is_open = YES;
            [self.table reloadData];
            return;
        }
    }
    
    //如果点击的是三级cell
    NSLog(@"点击了三级cell");
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickCellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wrongtopicModel *model = _dataArr[indexPath.row];
    if (model.is_show) {
        return 44;
    }
    else
    {
        return 0;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"wrongtopicVC";
    wrongtopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[wrongtopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateCellWithModel:_dataArr[indexPath.row]];
    return cell;
}

@end
