//
//  datareportCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell3.h"

@interface datareportCell3()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *lefttextlab;
@property (nonatomic,strong) UILabel *righttextlab;
@end

@implementation datareportCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.lefttextlab];
        [self.contentView addSubview:self.righttextlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.lefttextlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-kScreenW/2-20);
        make.top.equalTo(weakSelf).with.offset(20);
    }];
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lefttextlab);
        make.right.equalTo(weakSelf.lefttextlab);
        make.top.equalTo(weakSelf.lefttextlab.mas_bottom).with.offset(10);
    }];
    [weakSelf.righttextlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(kScreenW/2+20);
        make.top.equalTo(weakSelf.lefttextlab);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.righttextlab);
        make.right.equalTo(weakSelf.righttextlab);
        make.top.equalTo(weakSelf.righttextlab.mas_bottom).with.offset(10);
    }];
}

#pragma mark - getters


-(UILabel *)lefttextlab
{
    if(!_lefttextlab)
    {
        _lefttextlab = [[UILabel alloc] init];
        _lefttextlab.textAlignment = NSTextAlignmentCenter;
        _lefttextlab.font = [UIFont systemFontOfSize:20];
        _lefttextlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _lefttextlab.text = @"475633";
    }
    return _lefttextlab;
}

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.text = @"全站最高答题量";
        _leftlab.font = [UIFont systemFontOfSize:13];
    }
    return _leftlab;
}

-(UILabel *)righttextlab
{
    if(!_righttextlab)
    {
        _righttextlab = [[UILabel alloc] init];
        _righttextlab.textAlignment = NSTextAlignmentCenter;
        _righttextlab.text = @"188288/1212131";
        _righttextlab.font = [UIFont systemFontOfSize:20];
        _righttextlab.textColor = [UIColor colorWithHexString:@"FF9B19"];
    }
    return _righttextlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.font = [UIFont systemFontOfSize:13];
        _rightlab.textColor = [UIColor colorWithHexString:@"323232"];
        _rightlab.text = @"我的排名";
    }
    return _rightlab;
}

@end
