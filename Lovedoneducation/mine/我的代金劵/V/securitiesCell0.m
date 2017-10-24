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
        [self setuplayout];
    }
    return self;
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(20);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    [weakSelf.leftnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftpriceLabel);
        make.top.equalTo(weakSelf.leftpriceLabel.mas_bottom).with.offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(16);
    }];
    [weakSelf.lineimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-15);
        make.width.mas_offset(1);
        make.right.equalTo(weakSelf.leftnameLabel.mas_right).with.offset(15);
    }];
    [weakSelf.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineimg);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.left.equalTo(weakSelf.lineimg.mas_right).with.offset(15);
        
    }];
    [weakSelf.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numberLabel);
        make.right.equalTo(weakSelf.numberLabel);
        make.top.equalTo(weakSelf.numberLabel.mas_bottom).with.offset(20);
    }];
}
#pragma mark - getters

-(UILabel *)leftpriceLabel
{
    if(!_leftpriceLabel)
    {
        _leftpriceLabel = [[UILabel alloc] init];
        _leftpriceLabel.text = @"¥ 100";
        _leftpriceLabel.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _leftpriceLabel.textAlignment = NSTextAlignmentRight;
        _leftpriceLabel.font = [UIFont systemFontOfSize:24];
    }
    return _leftpriceLabel;
}

-(UILabel *)leftnameLabel
{
    if(!_leftnameLabel)
    {
        _leftnameLabel = [[UILabel alloc] init];
        _leftnameLabel.textAlignment = NSTextAlignmentRight;
        _leftnameLabel.text = @"课程劵";
        _leftnameLabel.font = [UIFont systemFontOfSize:12];
        _leftnameLabel.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _leftnameLabel;
}

-(UIImageView *)lineimg
{
    if(!_lineimg)
    {
        _lineimg = [[UIImageView alloc] init];
        _lineimg.backgroundColor = [UIColor redColor];
    }
    return _lineimg;
}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"共3张";
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:17];
        _numberLabel.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _numberLabel;
}

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"300元及300元以下课程任意券";
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

@end
