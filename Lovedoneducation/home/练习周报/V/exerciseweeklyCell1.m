//
//  exerciseweeklyCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell1.h"

@interface exerciseweeklyCell1()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@property (nonatomic,strong) UILabel *fenlab;
@end

@implementation exerciseweeklyCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.fenlab];
        [self.contentView addSubview:self.rightlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(15);
        make.width.mas_offset(100);
    }];
    [weakSelf.fenlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.width.mas_offset(30);
        make.centerY.equalTo(weakSelf);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.fenlab.mas_left).with.offset(-10);
        make.width.mas_offset(60);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.font = [UIFont systemFontOfSize:15];
        _leftlab.text = @"上周提高";
    }
    return _leftlab;
}

-(UILabel *)fenlab
{
    if(!_fenlab)
    {
        _fenlab = [[UILabel alloc] init];
        _fenlab.textAlignment = NSTextAlignmentRight;
        _fenlab.text = @"分";
        _fenlab.font = [UIFont systemFontOfSize:15];
        _fenlab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _fenlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentRight;
        //_rightlab.text = @"60";
        _rightlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _rightlab.font = [UIFont systemFontOfSize:30];
    }
    return _rightlab;
}

-(void)setdata:(NSDictionary *)dic
{
    NSString *up = [NSString stringWithFormat:@"%@",[dic objectForKey:@"up"]];
    self.rightlab.text = up;
}

@end
