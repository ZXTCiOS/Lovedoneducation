//
//  realparticularsCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsCell0.h"
#import "NSString+Extension_NSString.h"


@interface realparticularsCell0()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIImageView *realImg;
@property (nonatomic,strong) UILabel *contentlab2;
@end

@implementation realparticularsCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
 
        [_realImg setHidden:YES];
        [self setlayout];
    }
    return self;
}

-(void)setlayout
{
    __weak typeof (self) weakSelf = self;
    weakSelf.contentlab.isAttributedContent = YES;
    weakSelf.contentlab
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
}

#pragma mark - getters

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"646464"];
        _contentlab.font = [UIFont systemFontOfSize:15];
    }
    return _contentlab;
}

-(UIImageView *)realImg
{
    if(!_realImg)
    {
        _realImg = [[UIImageView alloc] init];

    }
    return _realImg;
}

#pragma mark - 实现方法

-(void)setdata:(NSMutableArray *)conarr andtype:(NSString *)type andtitle:(NSString *)title
{
    __weak typeof (self) weakSelf = self;
    NSArray *dataarr = [NSArray new];
    NSMutableArray *arr1 = [NSMutableArray new];
    NSString *contentstr = @"";
    //选择题
    if ([type isEqualToString:@"1"]) {
        NSString *titlestr = [NSString stringWithFormat:@"%@%@",title,@"\n\n"];
        if ([title isEqualToString:@"zxtc"]) {
            
        }
        else
        {
            [arr1 addObject:titlestr];
        }
        for (int i = 0; i<conarr.count; i++)
        {
            dataarr = [conarr objectAtIndex:i];
            NSString *str = [dataarr componentsJoinedByString:@" "];
            if([str rangeOfString:@"http://"].location !=NSNotFound)
            {
                NSString *url = str;
                [self.realImg sd_setImageWithURL:[NSURL URLWithString:url]];
                [self.contentView addSubview:self.realImg];
                NSArray *arrayhei = [url componentsSeparatedByString:@"&height="]; //从字符A中分隔成2个元素的数组
                NSString *result = [arrayhei objectAtIndex:1];
                [weakSelf.realImg setHidden:NO];
                [weakSelf.realImg sd_setImageWithURL:[NSURL URLWithString:url]];
                weakSelf.realImg
                .sd_layout
                .leftEqualToView(weakSelf.contentlab)
                .rightSpaceToView(weakSelf.contentView, 20)
                .topSpaceToView(weakSelf.contentlab, 20)
                .heightIs([result intValue]);
                [self setupAutoHeightWithBottomView: weakSelf.realImg bottomMargin:20];
            }
            else
            {
                NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n"];
                NSString *strs = [strss stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                [arr1 addObject:strs];
                [_realImg setHidden:YES];
                [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:0.1f];
            }
            
        }

    }
    //材料题
    if ([type isEqualToString:@"2"]) {
        
        NSString *titlestr = [NSString stringWithFormat:@"%@%@",title,@"\n\n"];
        [arr1 addObject:titlestr];
        for (int i = 0; i<conarr.count; i++)
        {
            dataarr = [conarr objectAtIndex:i];
            NSString *str = [dataarr componentsJoinedByString:@" "];
            NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n"];
            NSString *strs = [strss stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            [arr1 addObject:strs];
        }
        [_realImg setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:20];
    }
    //简答题
    if ([type isEqualToString:@"3"]) {
        NSString *titlestr = [NSString stringWithFormat:@"%@%@",title,@"\n\n"];
        if ([title isEqualToString:@"zxtc"]) {
            
        }
        else
        {
            [arr1 addObject:titlestr];
        }

        for (int i = 0; i<conarr.count; i++)
        {
            dataarr = [conarr objectAtIndex:i];
            NSString *str = [dataarr componentsJoinedByString:@" "];
            NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n"];
            NSString *strs = [strss stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            [arr1 addObject:strs];
        }
        [_realImg setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:20];
    }
    contentstr = [arr1 componentsJoinedByString:@" "];
    self.contentlab.text = contentstr;
    [UILabel changeLineSpaceForLabel:self.contentlab WithSpace:5];
}

@end
