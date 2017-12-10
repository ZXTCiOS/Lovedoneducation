//
//  essaycardCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essaycardCell.h"

@interface essaycardCell()
@property (nonatomic,strong) UIButton *setBtn;
@end

@implementation essaycardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.setBtn];
        [self setuplaout];
    }
    return self;
}

-(void)setuplaout
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
        _setBtn.layer.borderColor = [UIColor colorWithHexString:@"323232"].CGColor;
    }
    return _setBtn;
}

#pragma mark - 实现方法

-(void)setbtnclick
{
    NSLog(@"选择题卡");
}

-(void)setdata:(NSString *)str andnumitem:(NSString *)itemstr
{
    if (str.length==0) {
        
    }else
    {
        self.setBtn.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        self.setBtn.layer.borderColor = [UIColor colorWithHexString:@"E5E5E5"].CGColor;
        [self.setBtn setTitleColor:[UIColor colorWithHexString:@"323232"] forState:normal];
    }
    [self.setBtn setTitle:itemstr forState:normal];
}


@end
