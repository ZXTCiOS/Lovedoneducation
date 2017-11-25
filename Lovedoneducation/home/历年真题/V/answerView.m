//
//  answerView.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "answerView.h"



@implementation answerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
        [self addSubview:self.changeBtn];
        [self superlauout];
    }
    return self;
}

-(void)superlauout
{
//    __weak typeof (self) weakSelf = self;
//    [weakSelf.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf);
//        make.right.equalTo(weakSelf);
//        make.top.equalTo(weakSelf);
//        make.height.mas_offset(220);
//    }];
//    [weakSelf.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(20);
//        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(5);
//        make.width.mas_offset(25);
//        make.height.mas_offset(20);
//    }];
    self.textView.frame = CGRectMake(0, 0, kScreenW, 250);
    self.changeBtn.frame = CGRectMake(20, self.frame.size.height-40, 25, 20);
}

#pragma mark - getters

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        
    }
    return _textView;
}

-(UIButton *)changeBtn
{
    if(!_changeBtn)
    {
        _changeBtn = [[UIButton alloc] init];
        
    }
    return _changeBtn;
}



@end
