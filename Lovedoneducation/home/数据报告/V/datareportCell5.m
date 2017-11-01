//
//  datareportCell5.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "datareportCell5.h"

@interface datareportCell5()
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation datareportCell5

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(30);
    }];
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

#pragma mark - getters

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        
    }
    return _timelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        
    }
    return _contentlab;
}




@end
