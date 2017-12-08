//
//  essayorderCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/7.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essayorderCell1.h"

@interface essayorderCell1()
@property (nonatomic,strong) UILabel *lab;
@end

@implementation essayorderCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        [self.contentView addSubview:self.lab];
        [self setuplauout];
    }
    return self;
}

-(void)setuplauout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(30);
    }];
}

#pragma mark - getters


-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.textColor = [UIColor colorWithHexString:@"323232"];
        _lab.font = [UIFont systemFontOfSize:17];
        _lab.text = @"选择代金券";
    }
    return _lab;
}



@end
