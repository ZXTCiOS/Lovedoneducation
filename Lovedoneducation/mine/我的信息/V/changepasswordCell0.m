//
//  changepasswordCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changepasswordCell0.h"
#import "JKCountDownButton.h"
@interface changepasswordCell0()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) JKCountDownButton *sendBtn;
@end

@implementation changepasswordCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.valuetext];
        [self.contentView addSubview:self.sendBtn];
        
        [_sendBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;
            
            [sender startCountDownWithSecond:60];
            
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                _sendBtn.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                _sendBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
                return @"点击重新获取";
                
            }];
            
        }];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(40);
        make.width.mas_offset(120);
        
    }];
    [weakSelf.valuetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftLabel.mas_right).with.offset(14);
        make.top.equalTo(weakSelf.leftLabel).with.offset(-5);
        make.width.mas_offset(130*WIDTH_SCALE);
        make.height.mas_offset(34);
    }];
    [weakSelf.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.valuetext.mas_right).with.offset(15);
        make.top.equalTo(weakSelf.valuetext);
        make.height.mas_offset(34);
        make.right.equalTo(weakSelf).with.offset(-14);
    }];
}
#pragma mark - getters


-(JKCountDownButton *)sendBtn
{
    if(!_sendBtn)
    {
        _sendBtn = [[JKCountDownButton alloc] init];
        [_sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_sendBtn addTarget:self action:@selector(fasongbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}


-(UILabel *)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"请输入验证码";
        _leftLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _leftLabel.font = [UIFont systemFontOfSize:18];
    }
    return _leftLabel;
}

-(UITextField *)valuetext
{
    if(!_valuetext)
    {
        _valuetext = [[UITextField alloc] init];
        _valuetext.keyboardType = UIKeyboardTypeNumberPad;
        _valuetext.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _valuetext;
}

-(void)fasongbtnclick
{
    [self.delegate myTabVClick:self];
}
@end
