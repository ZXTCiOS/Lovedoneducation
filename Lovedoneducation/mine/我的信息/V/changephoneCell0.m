//
//  changephoneCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneCell0.h"

@interface changephoneCell0()
@property (nonatomic,strong) UILabel *messageLabel;
@end

@implementation changephoneCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(68);
    }];
    [weakSelf.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.messageLabel);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.messageLabel.mas_bottom).with.offset(30);
    }];
}

#pragma mark - getters

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _messageLabel.text = @"请输入下方手机号收到的验证码进行验证：";
    }
    return _messageLabel;
}

-(UILabel *)phoneLabel
{
    if(!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"323232"];
        _phoneLabel.text = @"18855688888";
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.font = [UIFont fontWithName:@"SanFranciscoDisplay" size:30];
        _phoneLabel.font = [UIFont systemFontOfSize:30];
    }
    return _phoneLabel;
}




@end
