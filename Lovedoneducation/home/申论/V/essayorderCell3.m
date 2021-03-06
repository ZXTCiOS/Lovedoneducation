//
//  essayorderCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayorderCell3.h"

@interface essayorderCell3()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *rightlab;
@end

@implementation essayorderCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.rightlab];
        [self setuplauout];
    }
    return self;
}


-(void)setuplauout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(120*WIDTH_SCALE);
    }];
    [weakSelf.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(200*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"需支付";
        _leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftlab.font = [UIFont systemFontOfSize:17];
    }
    return _leftlab;
}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textAlignment = NSTextAlignmentRight;
        _rightlab.font = [UIFont systemFontOfSize:30];
        _rightlab.textColor = [UIColor colorWithHexString:@"FF9B19"];

    }
    return _rightlab;
}

-(void)setdata:(NSString *)pricestr
{
    NSString *str1 = pricestr;
    NSString *str2 = @"爱唐币";
    NSString *str = [NSString stringWithFormat:@"%@%@",str1,str2];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(0, str1.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str1.length, str2.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(0, str1.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(str1.length, str2.length)];
    self.rightlab.attributedText = attrStr;
    //self.rightlab.text = [NSString stringWithFormat:@"%@%@",pricestr,@"爱唐币"];
}



@end
