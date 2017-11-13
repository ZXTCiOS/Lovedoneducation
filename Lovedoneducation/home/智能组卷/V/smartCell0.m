//
//  smartCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "smartCell0.h"

@interface smartCell0()
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@property (nonatomic,strong) UILabel *lab5;
@property (nonatomic,strong) UILabel *lab6;
@property (nonatomic,strong) UILabel *lab7;
@property (nonatomic,strong) UILabel *lab8;
@property (nonatomic,strong) UILabel *lab9;
@end

@implementation smartCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lab0];

        [self setuolayout];
    }
    return self;
}

-(void)setuolayout
{
    __weak typeof (self) weakSelf = self;

    weakSelf.lab0
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 15)
    .rightSpaceToView(weakSelf.contentView, 15)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    

    
    [self setupAutoHeightWithBottomView: weakSelf.lab0 bottomMargin:20];
    
}

#pragma mark - getters

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.textColor = [UIColor colorWithHexString:@"646464"];
        _lab0.font = [UIFont systemFontOfSize:15];
    }
    return _lab0;
}

#pragma mark - 实现方法

-(void)setdata:(NSMutableArray *)conarr
{
    __weak typeof (self) weakSelf = self;
    if (conarr.count==1) {
        NSString *contstr = @"";
        NSArray *dataarr = [conarr firstObject];
        contstr = [dataarr componentsJoinedByString:@" "];
        NSString *str = [self filterHTML:contstr];
        NSString *strs = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        self.lab0.text = strs;
        [self setupAutoHeightWithBottomView: weakSelf.lab0 bottomMargin:20];
    }
    if (conarr.count==2) {
        NSString *contstr = @"";
        NSArray *dataarr = [conarr firstObject];
        contstr = [self filterHTML:[dataarr objectAtIndex:0]];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSString *contstr1 =  [self filterHTML:[dataarr1 objectAtIndex:0]];;
        NSString *str = [NSString stringWithFormat:@"%@%@%@",contstr,@"\n\n",contstr1];
        self.lab0.text = str;
        [self setupAutoHeightWithBottomView: weakSelf.lab0 bottomMargin:20];
    }
    if (conarr.count==3) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
       
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2];
        self.lab0.text = str;
    }
    if (conarr.count==4) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3];
        self.lab0.text = str;
        
    }
    if (conarr.count==5) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
     
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4];
        self.lab0.text = str;
        
    }
    if (conarr.count==6) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
       
   
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str5 = [dataarr5 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4,@"\n\n",str5];
        self.lab0.text = str;

        
    }
    if (conarr.count==7) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
      
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str5 = [dataarr5 firstObject];
        NSString *str6 = [dataarr6 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4,@"\n\n",str5,@"\n\n",str6];
        self.lab0.text = str;

        
    }
    if (conarr.count==8) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
       
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str5 = [dataarr5 firstObject];
        NSString *str6 = [dataarr6 firstObject];
        NSString *str7 = [dataarr7 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4,@"\n\n",str5,@"\n\n",str6,@"\n\n",str7];
        self.lab0.text = str;

    }
    if (conarr.count==9) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
        NSArray *dataarr8 = [conarr objectAtIndex:8];
    
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str5 = [dataarr5 firstObject];
        NSString *str6 = [dataarr6 firstObject];
        NSString *str7 = [dataarr7 firstObject];
        NSString *str8 = [dataarr8 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4,@"\n\n",str5,@"\n\n",str6,@"\n\n",str7,@"\n\n",str8];
        self.lab0.text = str;
    }
    if (conarr.count==10) {
        NSArray *dataarr0 = [conarr objectAtIndex:0];
        NSArray *dataarr1 = [conarr objectAtIndex:1];
        NSArray *dataarr2 = [conarr objectAtIndex:2];
        NSArray *dataarr3 = [conarr objectAtIndex:3];
        NSArray *dataarr4 = [conarr objectAtIndex:4];
        NSArray *dataarr5 = [conarr objectAtIndex:5];
        NSArray *dataarr6 = [conarr objectAtIndex:6];
        NSArray *dataarr7 = [conarr objectAtIndex:7];
        NSArray *dataarr8 = [conarr objectAtIndex:8];
        NSArray *dataarr9 = [conarr objectAtIndex:9];
       
        NSString *str0 = [dataarr0 firstObject];
        NSString *str1 = [dataarr1 firstObject];
        NSString *str2 = [dataarr2 firstObject];
        NSString *str3 = [dataarr3 firstObject];
        NSString *str4 = [dataarr4 firstObject];
        NSString *str5 = [dataarr5 firstObject];
        NSString *str6 = [dataarr6 firstObject];
        NSString *str7 = [dataarr7 firstObject];
        NSString *str8 = [dataarr8 firstObject];
        NSString *str9 = [dataarr9 firstObject];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",str0,@"\n\n",str1,@"\n\n",str2,@"\n\n",str3,@"\n\n",str4,@"\n\n",str5,@"\n\n",str6,@"\n\n",str7,@"\n\n",str8,@"\n t\n",str9];
        self.lab0.text = str;
        
    }
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

@end
