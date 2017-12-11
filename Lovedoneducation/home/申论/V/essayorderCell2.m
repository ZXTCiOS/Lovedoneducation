//
//  essayorderCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayorderCell2.h"

@interface essayorderCell2()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) UIImageView *rightimg;
@end

@implementation essayorderCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView  addSubview:self.rightimg];
        [self.contentView addSubview:self.pricelab];
        [self setuplauout];
    }
    return self;
}

-(void)setuplauout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(15);
        make.width.mas_offset(150*WIDTH_SCALE);
    }];
    [weakSelf.rightimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.width.mas_offset(18);
        make.height.mas_offset(18);
    }];
    [weakSelf.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.rightimg.mas_left).with.offset(-20);
        make.width.mas_offset(100*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"现金抵用券";
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.font = [UIFont systemFontOfSize:17];
    }
    return _leftlab;
}


-(UIImageView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIImageView alloc] init];
        _rightimg.image = [UIImage imageNamed:@"diyongquan_icon_selected_tijiaodingdan"];
    }
    return _rightimg;
}



-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.font = [UIFont systemFontOfSize:24];
        _pricelab.textColor = [UIColor colorWithHexString:@"08D2B2"];

        _pricelab.textAlignment = NSTextAlignmentRight;
    }
    return _pricelab;
}

-(void)setdata:(NSString *)pricestr
{
    self.pricelab.text = [NSString stringWithFormat:@"%@%@",@"¥",pricestr];
}



@end
