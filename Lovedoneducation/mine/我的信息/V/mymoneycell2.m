//
//  mymoneycell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2018/1/17.
//  Copyright © 2018年 wangjungang. All rights reserved.
//

#import "mymoneycell2.h"

@interface mymoneycell2()
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation mymoneycell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self layout];
    }
    return self;
}

-(void)layout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(20);
        make.centerX.equalTo(weakSelf);
        make.height.mas_offset(50);
    }];
}

#pragma mark - getters


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:12];
        _contentlab.numberOfLines = 0;
        _contentlab.text = @"说明 我的账户余额仅限购买爱唐教育所支持的虚拟产品  我的账户余额不过期，不支持提现 相关解释归爱唐所有";
    }
    return _contentlab;
}



@end
