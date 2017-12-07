//
//  realparticularsCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsCell2.h"

@interface realparticularsCell2()
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation realparticularsCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.submitBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.submitBtn
    .sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .heightIs(44)
    .widthIs(160)
    .centerXEqualToView(weakSelf.contentView);
    [self setupAutoHeightWithBottomView: weakSelf.submitBtn bottomMargin:20];
}


#pragma mark - getters

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"交卷并查看结果" forState:normal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _submitBtn;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    [self.delegate querentijiao:self];
}


@end
