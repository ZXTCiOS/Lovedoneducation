//
//  realpartfinishCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/29.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realpartfinishCell.h"

@interface realpartfinishCell()
@property (nonatomic,strong) UIButton *setBtn;
@end

@implementation realpartfinishCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.setBtn];
        [self setclick];
    }
    return self;
}

-(void)setclick
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
        make.top.equalTo(weakSelf).with.offset(10);
        make.bottom.equalTo(weakSelf).with.offset(-10);
    }];
}

#pragma mark - getters

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];
        [_setBtn addTarget:self action:@selector(setbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_setBtn setTitle:@"1" forState:normal];
        _setBtn.layer.masksToBounds = YES;
        _setBtn.layer.cornerRadius = 20;
        _setBtn.layer.borderWidth = 1;
        [_setBtn setTitleColor:[UIColor colorWithHexString:@"323232"] forState:normal];
        _setBtn.layer.borderColor = [UIColor colorWithHexString:@"E5E5E5"].CGColor;
    }
    return _setBtn;
}

#pragma mark - 实现方法

-(void)setbtnclick
{
    [self.delegate finish:self];
}

-(void)setdata:(NSString *)itemstr answer0:(NSString *)answer0 andanswer1:(NSString *)answer1 andsetbtnstr:(NSString *)btnstr
{
    [self.setBtn setTitle:itemstr forState:normal];
    
    
    if ([btnstr isEqualToString:@"233"])
    {
        //选中
        self.setBtn.backgroundColor = [UIColor colorWithHexString:@"FFC485"];
    }
    
    else
    {
        if (answer0.length==0) {
            [self.setBtn setTitleColor:[UIColor colorWithHexString:@"323232"] forState:normal];
            self.setBtn.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        }
        else if ([answer0 isEqualToString:answer1])
        {
            self.setBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
            [self.setBtn setTitleColor:[UIColor colorWithHexString:@"FEFEFE"] forState:normal];
        }
        else
        {
            self.setBtn.backgroundColor = [UIColor colorWithHexString:@"FF5151"];
            [self.setBtn setTitleColor:[UIColor colorWithHexString:@"FEFEFE"] forState:normal];
        }
    }
}

@end
