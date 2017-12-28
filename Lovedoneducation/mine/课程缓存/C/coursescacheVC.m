//
//  coursescacheVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "coursescacheVC.h"
#import "coursescacheCell.h"

#import "LievWhiteboardRecoredVC.h"
#import "FileModel.h"
#import "NSObject+FileDBManager.h"
#import "HTTPSessionShare.h"





@interface coursescacheVC ()<UITableViewDataSource,UITableViewDelegate, DZNEmptyDataSetSource, HTTPSessionShareDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataSource;

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
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始下载" forState:UIControlStateNormal];
    [btn setTintColor:krgb(8, 210, 178)];
    btn.frame = CGRectMake(0, 0, 60, 18);
    [btn bk_addEventHandler:^(id sender) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"删除全部下载文件?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            for (FileModel *model in HttpShare.downloadingList) {
                [NSObject delFiles:model];
            }
            for (FileModel *model in HttpShare.diskFileList) {
                [NSObject delFiles:model];
            }
            [self updateTableViewData];
            
        }];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:act];
        [alert addAction:act1];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    HttpShare.sessionDelegate = self;
    [self updateTableViewData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateTableViewData];
}


- (void)updateTableViewData{
    [self.dataSource removeAllObjects];
    [self.whiteboardlist removeAllObjects];
    
    for (FileModel *model in HttpShare.diskFileList) {
        NSString *str = [model.fileName componentsSeparatedByString:@"."].lastObject;
        if ([str isEqualToString:@"gz"]){
            [self.whiteboardlist addObject:model];
        }else if ([str isEqualToString:@"aac"]){
            [self.dataSource addObject:model];
        } else if ([str isEqualToString:@"mp4"]){
            [self.dataSource addObject:model];
        }
    }
    for (FileModel *model in HttpShare.downloadingList) {
        NSString *str = [model.fileName componentsSeparatedByString:@"."].lastObject;
        if ([str isEqualToString:@"gz"]){
            //[self.whiteboardlist addObject:model];
        }else if ([str isEqualToString:@"aac"]){
            [self.dataSource addObject:model];
        } else if ([str isEqualToString:@"mp4"]){
            [self.dataSource addObject:model];
        }
    }
    [self.table reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark empty datasource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"huancun_icon_kechengwuhuancun"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *string = @"您还没有缓存课程";
    UIFont *font = [UIFont systemFontOfSize:16];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
    return str;
}


#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
        _table.emptyDataSetSource = self;
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
    FileModel *model = self.dataSource[indexPath.row];
    [self updatecell:cell WithModel:model];
    return cell;
}

- (void)updatecell:(coursescacheCell *)cell WithModel:(FileModel *)model{
    cell.headingslab.text = [model.fileName componentsSeparatedByString:@"."].firstObject;
    cell.messagelab.text = model.courseIntro;
    cell.timelab.text = model.courseTime;
    cell.personlab.text = model.teacherIntro;
    cell.namelab.text = model.teacherName;
    cell.livebtn.hidden = model.fileState == FileDownloaded ? NO : YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.progressV.hidden = model.fileState == FileDownloaded ? YES : NO;
    cell.progressV.progress = model.fileReceivedSize.longLongValue/model.fileSize.longLongValue;
    [cell.infoimg sd_setImageWithURL:[NSURL URLWithString:model.tpic]];
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
        FileModel *model = self.dataSource[indexPath.row];
        NSArray *arr = [model.fileName componentsSeparatedByString:@"."];
        if ([arr.lastObject isEqualToString:@"aac"]) {
            for (FileModel *model in self.whiteboardlist) {
                NSString *name = [model.fileName componentsSeparatedByString:@"."].firstObject;
                if ([name isEqualToString:arr.firstObject]) {
                    [NSObject delFiles:model];
                }
            }
        }
        [NSObject delFiles:model];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FileModel *model = self.dataSource[indexPath.row];
    if (model.fileState == FileDownloaded) {
        LievWhiteboardRecoredVC *vc = [[LievWhiteboardRecoredVC alloc] init];
        vc.isMP4 = YES;
        vc.audioPath = model.filePath;// filePath
        NSArray *arr = [model.fileName componentsSeparatedByString:@"."];
        vc.titlename = arr.firstObject;
        if ([arr.lastObject isEqualToString:@"aac"]) {
            for (FileModel *model in self.whiteboardlist) {
                NSString *name = [model.fileName componentsSeparatedByString:@"."].firstObject;
                if ([name isEqualToString:arr.firstObject]) {
                    vc.wbPath = model.filePath;
                    vc.isMP4 = NO;
                }
            }
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.view showWarning:@"还没有下载完成哦"];
    }
    
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark sessionsharedelegate 相关方法
- (void)updateProgressWithFlModel:(FileModel *)flModel{
    NSArray *arr = [self.table visibleCells];
    for (coursescacheCell *cell in arr) {
        if (flModel.fileState == FileDownloading) {
            [self updatecell:cell WithModel:flModel];
        }
    }
}


@end
