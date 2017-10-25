//
//  aboutCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutCell2.h"

@interface aboutCell2()

@end

@implementation aboutCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.wechatImg];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.width.mas_offset(200);
        make.top.equalTo(weakSelf).with.offset(20);
    }];
    [weakSelf.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf.leftLabel);
        make.width.mas_offset(kScreenW/2);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).with.offset(-20);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(14);
        
    }];
    [weakSelf.wechatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.contentlab.mas_top).with.offset(-20);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
}

#pragma mark - getters


-(UILabel *)leftLabel
{
    if(!_leftLabel)
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:18];
        _leftLabel.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _leftLabel;
}

-(UILabel *)addressLabel
{
    if(!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentRight;
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

-(UIImageView *)wechatImg
{
    if(!_wechatImg)
    {
        _wechatImg = [[UIImageView alloc] init];
    }
    return _wechatImg;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.font = [UIFont systemFontOfSize:15];
        _contentlab.textColor = [UIColor colorWithHexString:@"909090"];
        _contentlab.textAlignment = NSTextAlignmentCenter;
        _contentlab.text = @"#扫一扫关注公众号#";
    }
    return _contentlab;
}






@end
