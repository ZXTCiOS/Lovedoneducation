//
//  mdetalCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mdetalCell1.h"

@interface mdetalCell1()
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation mdetalCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 36)
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:25];
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:16];
        _contentlab.textColor = [UIColor colorWithHexString:@"646464"];
        _contentlab.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _contentlab;
}

-(void)setdata:(NSString *)str
{
    self.contentlab.text = str;
}

@end
