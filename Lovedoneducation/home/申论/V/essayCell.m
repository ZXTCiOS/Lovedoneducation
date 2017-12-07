//
//  essayCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayCell.h"
#import "essaytableCell0.h"
#import "essaytableCell0.h"
#import "essayModel.h"

@interface essayCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) essayModel *essmodel;
@end

static NSString *essaytableidentfid0 = @"essaytableidentfid0";
static NSString *essaytableidentfid1 = @"essaytableidentfid1";

@implementation essayCell

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

#pragma mark - getters

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        essaytableCell0 *cell = [tableView dequeueReusableCellWithIdentifier:essaytableidentfid0];
        if (!cell) {
            cell = [[essaytableCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essaytableidentfid0];
        }
        [cell setdata:self.essmodel.mqintro andtitle:self.essmodel.mqtitle];
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

-(void)setdata:(essayModel *)model
{
    self.essmodel = model;
    [self.table reloadData];
}

@end
