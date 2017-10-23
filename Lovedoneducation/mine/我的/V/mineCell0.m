//
//  mineCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mineCell0.h"

@interface mineCell0()
@property (nonatomic,strong) UILabel *testlab;

@end

@implementation mineCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [self.contentView addSubview:self.testlab];
        [self.contentView addSubview:self.nameLab];
        [self setuplayout];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.testlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        //make.centerY.mas_offset(weakSelf);
        make.width.mas_offset(220*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(17);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.testlab);
        make.right.equalTo(weakSelf).with.offset(-30);
        make.width.mas_offset(300*WIDTH_SCALE);
       // make.centerY.mas_offset(weakSelf);
    }];
}

#pragma mark - getters

-(UILabel *)testlab
{
    if(!_testlab)
    {
        _testlab = [[UILabel alloc] init];
        _testlab.text = @"账号信息";
        _testlab.font = [UIFont systemFontOfSize:16];
        _testlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _testlab;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentRight;
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _nameLab;
}



@end
