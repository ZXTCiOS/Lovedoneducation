//
//  essayorderCell4.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayorderCell4.h"

@interface essayorderCell4()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@end

@implementation essayorderCell4

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self setuplauout];
    }
    return self;
}

-(void)setuplauout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(120*WIDTH_SCALE);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(120*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.font = [UIFont systemFontOfSize:17];
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.text = @"支付方式";
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentRight;
        _rightlab.font = [UIFont systemFontOfSize:15];
        _rightlab.text = @"在线支付";
        _rightlab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _rightlab;
}



@end
