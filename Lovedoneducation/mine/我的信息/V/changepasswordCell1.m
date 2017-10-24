//
//  changepasswordCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changepasswordCell1.h"

@implementation changepasswordCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.passwordText];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-20);
        make.width.mas_offset(100);
    }];
    [weakSelf.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftLabel.mas_right).with.offset(14);
        make.top.equalTo(weakSelf.leftLabel);
        make.bottom.equalTo(weakSelf.leftLabel);
        make.right.equalTo(weakSelf).with.offset(-14);
    }];
}

#pragma mark - getters


-(UILabel *)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [[UILabel alloc] init];
        
    }
    return _leftLabel;
}

-(UITextField *)passwordText
{
    if(!_passwordText)
    {
        _passwordText = [[UITextField alloc] init];
        _passwordText.secureTextEntry = YES;
    }
    return _passwordText;
}




@end
