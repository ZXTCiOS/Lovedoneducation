//
//  mineCell2.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell2.h"

@interface mineCell2()
@property (nonatomic,strong) UILabel *leftLab;
@end

@implementation mineCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftLab];
        [self.contentView addSubview:self.mainSwitch];
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
    [weakSelf.mainSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf.leftLab).with.offset(-2);
        make.width.mas_offset(50);
        make.height.mas_offset(25);
    }];
}
#pragma mark - getters


-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = [UIFont systemFontOfSize:17];
        _leftLab.textColor = [UIColor colorWithHexString:@"323232"];
        _leftLab.text = @"直播课程提醒";
    }
    return _leftLab;
}

-(UISwitch *)mainSwitch
{
    if(!_mainSwitch)
    {
        _mainSwitch = [[UISwitch alloc] init];
        
    }
    return _mainSwitch;
}




@end
