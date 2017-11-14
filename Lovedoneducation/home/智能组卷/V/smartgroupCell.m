//
//  smartgroupCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartgroupCell.h"
#import "smartCell0.h"
#import "smartCell1.h"
#import "smartCell2.h"
#import "smartgroupModel.h"


@interface smartgroupCell()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate>

@property (nonatomic, copy) NSString *allnum;
@property (nonatomic, copy) NSString *itemstr;
@property (nonatomic, strong) NSMutableArray *contentarr;
@property (nonatomic, strong) NSMutableArray *answerarr;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, copy) NSString *answerstr;
@end

static NSString *smarttableidentfid0 = @"smarttableidentfid0";
static NSString *smarttableidentfid1 = @"smarttableidentfid1";
static NSString *smarttableidentfid2 = @"smarttableidentfid2";

@implementation smartgroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.table];
        [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        self.table.tableFooterView = [UIView new];
    }
    return self;
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
    if ([self.copystr isEqualToString:@"2"]) {
        return 2;
    }
    if ([self.copystr isEqualToString:@"1"])
    {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        smartCell0 *cell = [tableView dequeueReusableCellWithIdentifier:smarttableidentfid0];
        if (!cell) {
            cell = [[smartCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:smarttableidentfid0];
        }
        [cell setdata:self.contentarr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        smartCell1 *cell = [tableView dequeueReusableCellWithIdentifier:smarttableidentfid1];
        if (!cell) {
            cell = [[smartCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:smarttableidentfid1];
        }
        [cell setdata:self.answerarr];
        [cell setanswer:self.answerstr];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        smartCell2 *cell = [tableView dequeueReusableCellWithIdentifier:smarttableidentfid2];
        if (!cell) {
            cell = [[smartCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:smarttableidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
}

-(void)setdata:(smartgroupModel *)model
{
    smartgroupModel *smodel = model;
    self.contentarr = [NSMutableArray array];
    self.contentarr = smodel.qcontent;
    self.answerarr = [NSMutableArray array];
    self.answerarr = smodel.qanswer;
    
    [self.table reloadData];
}

-(void)setarray:(NSString *)str
{
    self.answerstr = str;
}

#pragma mark - 选择方式

-(void)myTabVClickA:(UITableViewCell *)cell
{
    [self.delegate myTabVClickA:self];
}

-(void)myTabVClickB:(UITableViewCell *)cell
{
    [self.delegate myTabVClickB:self];
}

-(void)myTabVClickC:(UITableViewCell *)cell
{
    [self.delegate myTabVClickC:self];
}

-(void)myTabVClickD:(UITableViewCell *)cell
{
    [self.delegate myTabVClickD:self];
}

-(void)setbtnclick
{
    NSLog(@"setbtnclick");
}

@end
