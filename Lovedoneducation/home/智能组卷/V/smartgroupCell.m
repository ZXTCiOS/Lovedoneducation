//
//  smartgroupCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartgroupCell.h"
#import "smartCell0.h"
#import "smartgroupModel.h"

@interface smartgroupCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, copy) NSString *allnum;
@property (nonatomic, copy) NSString *itemstr;
@property (nonatomic, strong) NSMutableArray *contentarr;
@end

static NSString *smarttableidentfid0 = @"smarttableidentfid0";

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
        self.table.tableHeaderView = self.head;
        self.table.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - getters

-(headView *)head
{
    if(!_head)
    {
        _head = [[headView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];

    }
    return _head;
}

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    smartCell0 *cell = [tableView dequeueReusableCellWithIdentifier:smarttableidentfid0];
    if (!cell) {
        cell = [[smartCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:smarttableidentfid0];
    }
    [cell setdata:self.contentarr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

-(void)setdata:(smartgroupModel *)model andinitger:(NSString *)numstr andnumstr:(NSString *)numitem
{
    int itemint = [numitem intValue];
    int inem = itemint+1;
    self.itemstr = [NSString stringWithFormat:@"%d",inem];
    self.allnum = numstr;
    self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",self.itemstr,@"/",self.allnum];
    smartgroupModel *smodel = model;
    self.contentarr = [NSMutableArray array];
    self.contentarr = smodel.qcontent;
    [self.table reloadData];
}

@end
