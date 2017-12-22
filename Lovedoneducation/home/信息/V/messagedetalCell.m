//
//  messagedetalCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messagedetalCell.h"
#import "messagedetalModel.h"
#import "mdetalCell0.h"
#import "mdetalCell1.h"
#import "mdetalCell2.h"

@interface messagedetalCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) messagedetalModel *detalmodel;
@end

static NSString *messagedetalidentfid0 = @"messagedetalidentfid0";
static NSString *messagedetalidentfid1 = @"messagedetalidentfid1";
static NSString *messagedetalidentfid2 = @"messagedetalidentfid2";

@implementation messagedetalCell
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

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        mdetalCell0 *cell = [tableView dequeueReusableCellWithIdentifier:messagedetalidentfid0];
        if (!cell) {
            cell = [[mdetalCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messagedetalidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.detalmodel.questionintro];
        return cell;
    }
    if (indexPath.row==1) {
        mdetalCell1 *cell = [tableView dequeueReusableCellWithIdentifier:messagedetalidentfid1];
        if (!cell) {
            cell = [[mdetalCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messagedetalidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.detalmodel.content];
        return cell;
    }
    if (indexPath.row==2) {
        mdetalCell2 *cell = [tableView dequeueReusableCellWithIdentifier:messagedetalidentfid2];
        if (!cell) {
            cell = [[mdetalCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messagedetalidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.detalmodel.des];
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

#pragma mark - 数据方法

-(void)setdata:(messagedetalModel *)model
{
    self.detalmodel = [[messagedetalModel alloc] init];
    self.detalmodel = model;
    [self.table reloadData];
}

@end
