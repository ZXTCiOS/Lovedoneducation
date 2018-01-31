//
//  mymoneycell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import "mymoneycell0.h"

@interface mymoneycell0()

@property (nonatomic,strong) UILabel *namelab;
@end

@implementation mymoneycell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.moneylab];
        [self.contentView addSubview:self.namelab];
        [self layout];
    }
    return self;
}

-(void)layout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.moneylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(30);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.moneylab);
        make.top.equalTo(weakSelf.moneylab.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
}

#pragma mark - getters


-(UILabel *)moneylab
{
    if(!_moneylab)
    {
        _moneylab = [[UILabel alloc] init];
        _moneylab.textAlignment = NSTextAlignmentCenter;
        _moneylab.font = [UIFont systemFontOfSize:22];
        _moneylab.text = @"12.00";
    }
    return _moneylab;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:12];
        _namelab.text = @"余额";
    }
    return _namelab;
}




@end
