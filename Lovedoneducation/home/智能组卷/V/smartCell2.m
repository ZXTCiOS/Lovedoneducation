//
//  smartCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell2.h"

@interface smartCell2()
@property (nonatomic,strong) UIButton *setBtn;
@end

@implementation smartCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.setBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.setBtn
    .sd_layout
    .topSpaceToView(weakSelf.contentView, 20)
    .heightIs(44)
    .widthIs(160)
    .centerXEqualToView(weakSelf.contentView);
    [self setupAutoHeightWithBottomView: weakSelf.setBtn bottomMargin:20];
}

#pragma mark - getters

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];
        [_setBtn setTitle:@"交卷并查看结果" forState:normal];
//        _setBtn.frame = CGRectMake(kScreenW/2-80, 20, 160, 44);
        [_setBtn addTarget:self action:@selector(setbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_setBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
        _setBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _setBtn;
}

-(void)setbtnclick
{
    
}

@end
