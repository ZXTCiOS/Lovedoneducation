//
//  exerciseweeklyCell5.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell5.h"

@interface exerciseweeklyCell5()

@end

@implementation exerciseweeklyCell5

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    for (int i = 0; i<6; i++) {
        UILabel *leftlab = [[UILabel alloc] init];
        [self.contentView addSubview:leftlab];
        leftlab.sd_layout
        .topSpaceToView(weakSelf.contentView, i*50+30)
        .heightIs(30)
        .leftSpaceToView(weakSelf.contentView, 20)
        .widthIs(150);
        leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        leftlab.font = [UIFont systemFontOfSize:15];
        leftlab.text = @"言语理解与表达";
        [self setupAutoHeightWithBottomView: leftlab bottomMargin:20];
        
        UILabel *numberlab = [[UILabel alloc] init];
        [self.contentView addSubview:numberlab];
        numberlab.text = @"3.6题";
        numberlab.textAlignment = NSTextAlignmentRight;
        numberlab.font = [UIFont systemFontOfSize:18];
        numberlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        numberlab.sd_layout
        .topEqualToView(leftlab)
        .rightSpaceToView(weakSelf.contentView, 20)
        .heightIs(30)
        .widthIs(100);
    }
    
}
@end
