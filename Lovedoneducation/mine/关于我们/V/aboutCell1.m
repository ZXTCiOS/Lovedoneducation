//
//  aboutCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutCell1.h"

@interface aboutCell1()

@end

@implementation aboutCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.messageLabel];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(200);
        
    }];
    [weakSelf.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(kScreenW/2);
    }];
}

#pragma mark - getters


-(UILabel *)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = [UIColor colorWithHexString:@"323232"];
        _leftLabel.font = [UIFont systemFontOfSize:18];
    }
    return _leftLabel;
}

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textAlignment = NSTextAlignmentRight;
    }
    return _messageLabel;
}

@end
