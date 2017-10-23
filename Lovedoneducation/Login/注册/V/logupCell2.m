//
//  logupCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupCell2.h"

@implementation logupCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.yanzhengtext];
        [self.contentView addSubview:self.fasongbtn];
        [self layout];
        
        
        [_fasongbtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;
            
            [sender startCountDownWithSecond:10];
            
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                _fasongbtn.backgroundColor = [UIColor colorWithHexString:@"C7C7CD"];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                _fasongbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
                return @"点击重新获取";
                
            }];
            
        }];
        
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
    [weakSelf.yanzhengtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-150);
        make.height.mas_offset(40*HEIGHT_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
    }];
    [weakSelf.fasongbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.yanzhengtext.mas_right).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_offset(30*HEIGHT_SCALE);
        make.top.equalTo(weakSelf.yanzhengtext).with.offset(10);;
    }];
}

#pragma mark - getters

-(UITextField *)yanzhengtext
{
    if(!_yanzhengtext)
    {
        _yanzhengtext = [[UITextField alloc] init];
        
    }
    return _yanzhengtext;
}

-(JKCountDownButton *)fasongbtn
{
    if(!_fasongbtn)
    {
        _fasongbtn = [[JKCountDownButton alloc] init];
        [_fasongbtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _fasongbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _fasongbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_fasongbtn addTarget:self action:@selector(fasongbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fasongbtn;
}

-(void)fasongbtnclick
{
    [self.delegate myTabVClick:self];
}
@end
