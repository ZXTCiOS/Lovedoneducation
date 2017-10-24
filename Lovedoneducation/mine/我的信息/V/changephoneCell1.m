//
//  changephoneCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changephoneCell1.h"
#import "JKCountDownButton.h"
@interface changephoneCell1()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) JKCountDownButton *sendBtn;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UIButton *nextBtn;
@end

@implementation changephoneCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.valuetext];
        [self.contentView addSubview:self.sendBtn];
        [self.contentView addSubview:self.nextBtn];
        [self.contentView addSubview:self.messageLabel];
        
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
        
    }
    [self setuplayout];
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
    [weakSelf.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(100);
        make.centerX.equalTo(weakSelf);
        make.height.mas_offset(44);
        make.top.equalTo(weakSelf.valuetext.mas_bottom).with.offset(120);
    }];
    [weakSelf.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).with.offset(20);
    }];
    
}
#pragma mark - getters

-(JKCountDownButton *)sendBtn
{
    if(!_sendBtn)
    {
        _sendBtn = [[JKCountDownButton alloc] init];
        [_sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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

-(UIButton *)nextBtn
{
    if(!_nextBtn)
    {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"下一步" forState:normal];
        _nextBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        [_nextBtn addTarget:self action:@selector(nextbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"#若该手机号停用请联系客服#";
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _messageLabel;
}

#pragma mark - 实现方法

-(void)fasongbtnclick
{
    [self.delegate myTabVClick:self];
}

-(void)nextbtnclick
{
    [self.delegate nextTabVClick:self];
}
@end
