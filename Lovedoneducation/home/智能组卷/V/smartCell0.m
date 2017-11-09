//
//  smartCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell0.h"

@interface smartCell0()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *titlelab;
@end

@implementation smartCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.titlelab];
        [self setuolayout];

    }
    return self;
}

-(void)setuolayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    
    weakSelf.titlelab
    .sd_layout
    .topSpaceToView(weakSelf.contentlab, 20)
    .leftEqualToView(weakSelf.contentlab)
    .rightEqualToView(weakSelf.contentlab)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView: weakSelf.titlelab bottomMargin:20];
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"646464"];
        _contentlab.font = [UIFont systemFontOfSize:16];

    }
    return _contentlab;
}


-(UILabel *)titlelab
{
    if(!_titlelab)
    {
        _titlelab = [[UILabel alloc] init];
        _titlelab.textColor = [UIColor colorWithHexString:@"646464"];
        _titlelab.font = [UIFont systemFontOfSize:16];
    }
    return _titlelab;
}

#pragma mark - 实现方法

-(void)setdata:(NSMutableArray *)conarr
{
    NSString *contstr = @"";
    NSArray *dataarr = [conarr objectAtIndex:0];
    contstr = [dataarr objectAtIndex:0];
    self.contentlab.text = contstr;
    NSArray *dataarr1 = [conarr objectAtIndex:1];
    self.titlelab.text = [dataarr1 objectAtIndex:0];
    

}

@end
