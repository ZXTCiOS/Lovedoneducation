//
//  logupCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupCell0.h"

@interface logupCell0()
@property (nonatomic,strong) UILabel *testlab;
@end

@implementation logupCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [self.contentView addSubview:self.testlab];
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
//        make.centerY.mas_offset(weakSelf);
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf).with.offset(17);
    }];
}

#pragma mark - getters

-(UILabel *)testlab
{
    if(!_testlab)
    {
        _testlab = [[UILabel alloc] init];
        _testlab.text = @"欢迎进入爱唐公考APP";
        _testlab.font = [UIFont systemFontOfSize:16];
        _testlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _testlab;
}


@end
