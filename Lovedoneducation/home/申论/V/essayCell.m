//
//  essayCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayCell.h"
#import "essaytableCell0.h"
#import "essaytableCell1.h"
#import "essaytableCell2.h"
#import "essayModel.h"

@interface essayCell()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) essayModel *essmodel;

@end

static NSString *essaytableidentfid0 = @"essaytableidentfid0";
static NSString *essaytableidentfid1 = @"essaytableidentfid1";
static NSString *essaytableidentfid2 = @"essaytableidentfid2";

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
    return 3;
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
    if (indexPath.row==1) {
        essaytableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:essaytableidentfid1];
        if (!cell) {
            cell = [[essaytableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essaytableidentfid1];
        }
        cell.delegate = self;
        [cell setimgarr:self.essmodel.answerimgarr andtextstr:self.essmodel.textstr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        essaytableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:essaytableidentfid2];
        if (!cell) {
            cell = [[essaytableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:essaytableidentfid2];
        }
        [cell setnumberstr:@"1" andpricestr:@"20"];
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

#pragma mark - 协议绑定

-(void)querentijiao:(UITableViewCell *)cell
{
    [self.delegate queren:self];
}

-(void)myimgbtnclick:(UITableViewCell *)cell
{
    [self.delegate imgchoose:self];
}

-(void)textstr:(UITableViewCell *)cell andtextstr:(NSString *)str
{
    [self.delegate textstr:self andtextstr:str];
}
@end
