//
//  mineCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell1.h"

@interface mineCell1()

@end

@implementation mineCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLab];
        [self.contentView addSubview:self.typeLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        //make.centerY.mas_offset(weakSelf);
        make.width.mas_offset(220*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(18);
    }];
    [weakSelf.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftLab.mas_top).with.offset(2);
        make.right.equalTo(weakSelf).with.offset(-30);
        make.width.mas_offset(300*WIDTH_SCALE);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - getters

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
//        _leftLab.text = @"考试类型";
        _leftLab.font = [UIFont systemFontOfSize:17];
        _leftLab.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _leftLab;
}

-(UILabel *)typeLab
{
    if(!_typeLab)
    {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textAlignment = NSTextAlignmentRight;
        _typeLab.font = [UIFont systemFontOfSize:15];
//        _typeLab.text = @"国家公务员考试";
        _typeLab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _typeLab;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
