//
//  feedbackCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "feedbackCell.h"

@implementation feedbackCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.feedtext];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.feedtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf).with.offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-20);
    }];
}

#pragma mark - getters

-(WJGtextView *)feedtext
{
    if(!_feedtext)
    {
        _feedtext = [[WJGtextView alloc] init];
        _feedtext.customPlaceholder = @"点此开始输入";
        _feedtext.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _feedtext;
}

@end
