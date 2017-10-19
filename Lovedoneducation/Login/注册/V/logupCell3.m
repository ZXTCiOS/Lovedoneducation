//
//  logupCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupCell3.h"

@interface logupCell3()
@property (nonatomic,strong) UILabel *textlab;
@end

@implementation logupCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.textlab];
        [self.contentView addSubview:self.passwordtext];
        [self layout];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.textlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(10);
       // make.height.mas_offset(30);
    }];
    [weakSelf.passwordtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textlab.mas_bottom).with.offset(6);
        make.left.equalTo(weakSelf.textlab);
        make.right.equalTo(weakSelf.textlab);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.text = @"为了您的账号安全，请输入6位及以上密码，爱唐承诺不会泄露您的手机号码且不会收取任何费用";
        _textlab.font = [UIFont systemFontOfSize:12];
        _textlab.numberOfLines = 0;
        _textlab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _textlab;
}

-(UITextField *)passwordtext
{
    if(!_passwordtext)
    {
        _passwordtext = [[UITextField alloc] init];
        _passwordtext.placeholder = @"请确认密码";
    }
    return _passwordtext;
}




@end
