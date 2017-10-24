//
//  securitiesCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "securitiesCell0.h"

@interface securitiesCell0()
@property (nonatomic,strong) UILabel *leftnameLabel;
@property (nonatomic,strong) UIImageView *lineimg;
@end

@implementation securitiesCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftpriceLabel];
        [self.contentView addSubview:self.leftnameLabel];
        [self.contentView addSubview:self.lineimg];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}



@end
