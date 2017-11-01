//
//  exerciseweeklyCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell3.h"

@interface exerciseweeklyCell3()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *lab0;
@end

@implementation exerciseweeklyCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.lab0];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(70);
    }];
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.bgview).with.offset(30);
    }];
    
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _bgview;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.text = @"正确率";
        _lab0.font = [UIFont systemFontOfSize:17];
        _lab0.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _lab0;
}



@end
