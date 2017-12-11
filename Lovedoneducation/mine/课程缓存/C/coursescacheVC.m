//
//  coursescacheVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "coursescacheVC.h"
#import "coursescacheCell.h"
#import <ZFDownloadManager.h>
#import "LiveModel.h"

@interface coursescacheVC ()<UITableViewDataSource,UITableViewDelegate, ZFDownloadDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ZFDownloadManager *downloadManager;
@property (nonatomic, strong) NSMutableArray *whiteboardlist;

@end

static NSString *coursecacheidentfid = @"coursecacheidentfid";

@implementation coursescacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程缓存";
    [self.view addSubview:self.table];
    self.dataSource = [NSMutableArray array];
    self.whiteboardlist = [NSMutableArray array];
    if (@available(iOS 11.0, *)){
        self.table.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, kScreenH-NAVIGATION_HEIGHT);
    }
    else
    {
        self.table.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }
    self.table.tableFooterView = [UIView new];
    self.dataSource = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    
    self.downloadManager = [ZFDownloadManager sharedDownloadManager];
    //[self.dataSource addObjectsFromArray:self.downloadManager.downinglist];
    //[self.dataSource addObjectsFromArray:self.downloadManager.finishedlist];
    
    for (ZFFileModel *model in self.downloadManager.downinglist) {
        if (model.downloadtype == ZFDownloadTypeWhiteboard) {
            [self.dataSource addObject:model];
        } else {
            [self.whiteboardlist addObject:model];
        }
    }
    for (ZFFileModel *model in self.downloadManager.finishedlist) {
        if (model.downloadtype == ZFDownloadTypeWhiteboard) {
            [self.dataSource addObject:model];
        } else {
            [self.whiteboardlist addObject:model];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 2;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    coursescacheCell *cell = [tableView dequeueReusableCellWithIdentifier:coursecacheidentfid];
    if (!cell) {
        cell = [[coursescacheCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coursecacheidentfid];
    }
    ZFFileModel *model = self.dataSource[indexPath.row];
    LiveCourseModel *course = model.extention;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.progressV.progress = 0.5;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
