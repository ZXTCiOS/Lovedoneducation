//
//  realanalysisCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realanalysisCell.h"
#import "smartgroupModel.h"
#import "realparticularsCell0.h"
#import "realparticularsCell1.h"
#import "realpartanalysisCell1.h"
#import "realpartanalysisCell2.h"
#import "realpartanalysisCell3.h"

@interface realanalysisCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) smartgroupModel *model;
@end

static NSString *realpartanalysisCellidentfid00 = @"realpartanalysisCellidentfid00";
static NSString *realpartanalysisCellidentfid01 = @"realpartanalysisCellidentfid01";
static NSString *realpartanalysisCellidentfid02 = @"realpartanalysisCellidentfid02";
static NSString *realpartanalysisCellidentfid03 = @"realpartanalysisCellidentfid03";
static NSString *realpartanalysisCellidentfid04 = @"realpartanalysisCellidentfid04";

@implementation realanalysisCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.table];
//        self.imgarray = [NSMutableArray array];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        realparticularsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:realpartanalysisCellidentfid00];
        if (!cell) {
            cell = [[realparticularsCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realpartanalysisCellidentfid00];
        }
        [cell setdata:self.model.qcontent andtype:self.model.qtype andtitle:self.model.qtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        realparticularsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realpartanalysisCellidentfid01];
        if (!cell) {
            cell = [[realparticularsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realpartanalysisCellidentfid01];
        }
        [cell setarray:self.model.qanswer andtype:self.model.qtype andimgarr:self.model.answerimgarr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        realpartanalysisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realpartanalysisCellidentfid02];
        if (!cell) {
            cell = [[realpartanalysisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realpartanalysisCellidentfid02];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata: self.model.come];
        return cell;
    }
    if (indexPath.row==3) {
        realpartanalysisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:realpartanalysisCellidentfid03];
        if (!cell) {
            cell = [[realpartanalysisCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realpartanalysisCellidentfid03];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.model.qdes anderrorstr:self.model.qerror andaccuracystr:self.model.accuracy];
        return cell;
    }
    if (indexPath.row==4) {
        realpartanalysisCell3 *cell = [tableView dequeueReusableCellWithIdentifier:realpartanalysisCellidentfid04];
        if (!cell) {
            cell = [[realpartanalysisCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realpartanalysisCellidentfid04];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdatacomestr:self.model.come];
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
    self.model = model;
    [self.table reloadData];
}

@end
