//
//  changephoneCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneCell2.h"

@implementation changephoneCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.phoneText];
        [self setuplayout];
    }
    return self;
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}
#pragma mark - getters

-(UITextField *)phoneText
{
    if(!_phoneText)
    {
        _phoneText = [[UITextField alloc] init];
        _phoneText.placeholder = @"请输入手机号";
    }
    return _phoneText;
}



@end
