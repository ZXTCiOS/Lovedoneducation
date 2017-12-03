//
//  datareportCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell2.h"

@interface datareportCell2()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *numberlab;
@property (nonatomic,strong) UILabel *percentlab;
@end

@implementation datareportCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self.contentView addSubview:self.numberlab];
        [self.contentView addSubview:self.percentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(41);
        make.right.equalTo(weakSelf).with.offset(-kScreenW/2-20);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.left.equalTo(weakSelf).with.offset(kScreenW/2+20);
    }];
    [weakSelf.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftlab);
        make.right.equalTo(weakSelf.leftlab);
        make.top.equalTo(weakSelf.leftlab.mas_bottom).with.offset(20);
    }];
    [weakSelf.percentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numberlab);
        make.left.equalTo(weakSelf.rightlab);
        make.right.equalTo(weakSelf.rightlab);
    }];


}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"datiliang_image_shujubaogao"];
    }
    return _bgimg;
}

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"答题量";
        _leftlab.textAlignment = NSTextAlignmentCenter;
        _leftlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _leftlab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
        _leftlab.font = [UIFont systemFontOfSize:13];
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _rightlab.textAlignment = NSTextAlignmentCenter;
        _rightlab.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
        _rightlab.text = @"正确率";
        _rightlab.font = [UIFont systemFontOfSize:13];
    }
    return _rightlab;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textAlignment = NSTextAlignmentCenter;
        _numberlab.text = @"15道";
        _numberlab.font = [UIFont fontWithName:@"SanFranciscoDisplay" size:44];
        _numberlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _numberlab.font = [UIFont systemFontOfSize:42];
    }
    return _numberlab;
}

-(UILabel *)percentlab
{
    if(!_percentlab)
    {
        _percentlab = [[UILabel alloc] init];
        _percentlab.textAlignment = NSTextAlignmentCenter;
        _percentlab.text = @"40%";
        _percentlab.font = [UIFont fontWithName:@"SanFranciscoDisplay" size:44];
        _percentlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _percentlab.font = [UIFont systemFontOfSize:42];
    }
    return _percentlab;
}

@end
