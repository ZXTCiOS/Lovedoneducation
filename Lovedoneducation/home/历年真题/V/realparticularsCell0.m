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
    
    NSString *intstr = [self  datacontentarr:conarr];
    
    //选择题
    if ([type isEqualToString:@"1"]) {
        if ([intstr isEqualToString:@"1"]) {
            NSArray *arr = [conarr firstObject];
            NSString *strs = [arr componentsJoinedByString:@" "];
            [arr1 addObject:strs];
            NSArray *urlarr = [conarr objectAtIndex:1];
            if (urlarr.count==1) {
                NSString *url = [urlarr firstObject];
                [self.realImg sd_setImageWithURL:[NSURL URLWithString:url]];
                [self.contentView addSubview:self.realImg];
                NSArray *arrayhei = [url componentsSeparatedByString:@"&height="]; //从字符A中分隔成2个元素的数组
                NSString *result = [arrayhei objectAtIndex:1];


                [weakSelf.realImg setHidden:NO];
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
                
            }
            if ([intstr isEqualToString:@"2"]) {
                
            }
            if ([intstr isEqualToString:@"3"]) {
                
            }
        }
        else
        {
            for (int i = 0; i<conarr.count; i++)
            {
                dataarr = [conarr objectAtIndex:i];
                if (conarr.count==1) {
                    NSString *str = [dataarr componentsJoinedByString:@" "];
                    NSString *strs = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                    [arr1 addObject:strs];
                }
                else
                {

                    NSString *str = [dataarr componentsJoinedByString:@" "];
                    NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n\n"];
                    NSString *strs = [strss stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                    [arr1 addObject:strs];
                }
            }
            [_realImg setHidden:YES];
            [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:20];
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
            NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n\n"];
            NSString *strs = [strss stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            [arr1 addObject:strs];
        }
        [_realImg setHidden:YES];
        [self setupAutoHeightWithBottomView: weakSelf.contentlab bottomMargin:20];
    }
    //简答题
    if ([type isEqualToString:@"3"]) {
        for (int i = 0; i<conarr.count; i++)
        {
            dataarr = [conarr objectAtIndex:i];
            NSString *str = [dataarr componentsJoinedByString:@" "];
            NSString *strss = [NSString stringWithFormat:@"%@%@",str,@"\n\n"];
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

-(NSString* )datacontentarr:(NSArray *)arr
{
    NSString *str = @"";

    for (int i = 0; i<arr.count; i++) {
        
        NSArray *objdic = [arr objectAtIndex:i];
        
        for (int j = 0; j<objdic.count; j++) {
            NSString *string = [objdic objectAtIndex:j];
            if([string rangeOfString:@"http://"].location !=NSNotFound)
            {
                NSString *returnstr = [NSString stringWithFormat:@"%d",j];
                str = returnstr;
            }
            else
            {
                str = @"0";
            }
        }
        
    }
    return str;
}

@end
