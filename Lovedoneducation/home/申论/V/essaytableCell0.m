//
//  essaytableCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essaytableCell0.h"

@interface essaytableCell0()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *titlelab;

@end

@implementation essaytableCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.titlelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
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
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.contentlab, 25)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView: weakSelf.titlelab bottomMargin:20];
    
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

-(UILabel *)titlelab
{
    if(!_titlelab)
    {
        _titlelab = [[UILabel alloc] init];
        _titlelab.textColor = [UIColor colorWithHexString:@"646464"];
        _titlelab.font = [UIFont systemFontOfSize:18];
        
    }
    return _titlelab;
}

-(void)setdata:(NSMutableArray *)conarr andtitle:(NSString *)title
{
    NSArray *dataarr = [NSArray new];
    NSMutableArray *arr1 = [NSMutableArray new];
    for (int i = 0; i<conarr.count; i++) {
        dataarr = [conarr objectAtIndex:i];
        NSString *str = [dataarr componentsJoinedByString:@" "];
        NSString *strs = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        [arr1 addObject:strs];
    }
    NSString *contentstr = [arr1 componentsJoinedByString:@" "];
    self.contentlab.text = contentstr;
    self.titlelab.text = title;
    NSString *str1 = @" ( 主观题 ) ";
    NSString *str2 = title;
    NSString *str = [NSString stringWithFormat:@"%@%@",str1,str2];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(0, str1.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"323232"]
                    range:NSMakeRange(str1.length, str2.length)];
    self.titlelab.attributedText = attrStr;
}

@end
