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
        make.height.equalTo(weakSelf).with.offset(28);
        
    }];
    
}
#pragma mark - getters

-(UILabel *)leftpriceLabel
{
    if(!_leftpriceLabel)
    {
        _leftpriceLabel = [[UILabel alloc] init];
        
    }
    return _leftpriceLabel;
}

-(UILabel *)leftnameLabel
{
    if(!_leftnameLabel)
    {
        _leftnameLabel = [[UILabel alloc] init];
        
    }
    return _leftnameLabel;
}

-(UIImageView *)lineimg
{
    if(!_lineimg)
    {
        _lineimg = [[UIImageView alloc] init];
        
    }
    return _lineimg;
}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [[UILabel alloc] init];
        
    }
    return _numberLabel;
}

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        
    }
    return _messageLabel;
}









@end
