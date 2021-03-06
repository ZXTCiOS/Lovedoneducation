//
//  realCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realCell.h"
#import "realparticularsCell0.h"
#import "realparticularsCell1.h"
#import "realparticularsCell2.h"

#import "smartgroupModel.h"

@interface realCell()<UITableViewDataSource,UITableViewDelegate,tijiaoVdelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic, copy) NSString *allnum;
@property (nonatomic, copy) NSString *itemstr;
@property (nonatomic, strong) NSMutableArray *contentarr;
@property (nonatomic, strong) NSMutableArray *answerarr;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, copy) NSString *answerstr;
@property (nonatomic, copy) NSString *qtitle;
@property (nonatomic, copy) NSString *qtype;
@property (nonatomic,strong) NSMutableArray *imgarray;
@property (nonatomic,copy) NSString *qsuccess;
@end


static NSString *realcellidentfid0 = @"realcellidentfid0";
static NSString *realcellidentfid1 = @"realcellidentfid1";
static NSString *realcellidentfid2 = @"realcellidentfid2";


@implementation realCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.table];
        self.imgarray = [NSMutableArray array];
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
        realparticularsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:realcellidentfid0];
        if (!cell) {
            cell = [[realparticularsCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realcellidentfid0];
        }
        [cell setdata:self.contentarr andtype:self.qtype andtitle:self.qtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        realparticularsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:realcellidentfid1];
        if (!cell) {
            cell = [[realparticularsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realcellidentfid1];
        }
        [cell setarray:self.answerarr andtype:self.qtype andimgarr:self.imgarray];
        [cell setanswer:self.answerstr];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        realparticularsCell2 *cell = [tableView dequeueReusableCellWithIdentifier:realcellidentfid2];
        if (!cell) {
            cell = [[realparticularsCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:realcellidentfid2];
        }
        cell.delegate = self;
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
    self.qtitle =smodel.qtitle;
    self.qtype = model.qtype;
    self.imgarray = model.answerimgarr;

    self.qsuccess = model.qsuccess;
    [self.table reloadData];
}

#pragma mark - 协议绑定

-(void)querentijiao:(UITableViewCell *)cell
{
    [self.delegate queren:self];
}

-(void)myTabVClickA:(UICollectionViewCell *)cell
{
    [self.delegate myTabVClickA:self];
}

-(void)myTabVClickB:(UICollectionViewCell *)cell
{
    [self.delegate myTabVClickB:self];
}

-(void)myTabVClickC:(UICollectionViewCell *)cell
{
    [self.delegate myTabVClickC:self];
}

-(void)myTabVClickD:(UICollectionViewCell *)cell
{
    [self.delegate myTabVClickD:self];
}

-(void)myimgbtnclick:(UITableViewCell *)cell
{
    [self.delegate imgchoose:self];
}

-(void)setarray:(NSString *)str
{
    self.answerstr = str;
}

-(void)textstr:(UITableViewCell *)cell andtextstr:(NSString *)str
{
    [self.delegate textstr:self andtextstr:str];
}

@end
