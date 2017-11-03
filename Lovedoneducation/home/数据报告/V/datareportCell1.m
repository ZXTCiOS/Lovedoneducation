//
//  datareportCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell1.h"

@interface datareportCell1()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *maxlab;
@property (nonatomic,strong) UILabel *proportionlab;
@end

@implementation datareportCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.maxlab];
        [self.contentView addSubview:self.proportionlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(26);
        make.right.equalTo(weakSelf).with.offset(-kScreenW/2-20);
        
    }];
    [weakSelf.maxlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftlab.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf.leftlab);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf).with.offset(20);
        make.left.equalTo(weakSelf).with.offset(kScreenW/2+20);
    }];
    [weakSelf.proportionlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.maxlab);
        make.left.equalTo(weakSelf.rightlab);
        make.right.equalTo(weakSelf.rightlab);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"99.2";
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _leftlab.font = [UIFont systemFontOfSize:20];
        _leftlab.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:20];
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.textColor = [UIColor orangeColor];
        _rightlab.text = @"123/13457";
        _rightlab.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:20];
//        _rightlab.font = [UIFont systemFontOfSize:20];
    }
    return _rightlab;
}

-(UILabel *)maxlab
{
    if(!_maxlab)
    {
        _maxlab = [[UILabel alloc] init];
        _maxlab.text = @"全站最高分";
        _maxlab.textAlignment = NSTextAlignmentCenter;
        _maxlab.textColor = [UIColor colorWithHexString:@"323232"];
        _maxlab.font = [UIFont systemFontOfSize:13];
    }
    return _maxlab;
}

-(UILabel *)proportionlab
{
    if(!_proportionlab)
    {
        _proportionlab = [[UILabel alloc] init];
        _proportionlab.text = @"我的排名";
        _proportionlab.textAlignment = NSTextAlignmentCenter;
        _proportionlab.font = [UIFont systemFontOfSize:13];
        _proportionlab.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _proportionlab;
}






@end
