//
//  mdetalCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/11.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mdetalCell0.h"

@interface mdetalCell0()
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation mdetalCell0

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
    .topSpaceToView(weakSelf.contentView, 25)
    .autoHeightRatio(0);
    [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:20];
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:16];
        _contentlab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _contentlab;
}

-(void)setdata:(NSMutableArray *)arr
{
    NSArray *dataarr = [NSArray new];
    NSMutableArray *arr1 = [NSMutableArray new];
    for (int i = 0; i<arr.count; i++) {
        dataarr = [arr objectAtIndex:i];
        NSString *str = [dataarr componentsJoinedByString:@" "];
        NSString *strs = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        [arr1 addObject:strs];
    }
    NSString *contentstr = [arr1 componentsJoinedByString:@" "];
    self.contentlab.text = contentstr;
}

@end
