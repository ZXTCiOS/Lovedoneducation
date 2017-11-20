//
//  realparticularsCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsCell2.h"

@interface realparticularsCell2()
@property (nonatomic,strong) UITextView *textView;
@end

@implementation realparticularsCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.textView];
    }
    return self;
}

#pragma mark - getters


@end
