//
//  aboutCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutCell0.h"

@interface aboutCell0()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UILabel *namelab;
@end

@implementation aboutCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlab];
        [self.contentView addSubview:self.namelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(200);
        
    }];
    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(140);
    }];
}

#pragma mark - getters


-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.font = [UIFont systemFontOfSize:16];
        _leftlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _leftlab.text = @"微信公众号";
    }
    return _leftlab;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textAlignment = NSTextAlignmentRight;
        _namelab.font = [UIFont systemFontOfSize:14];
        _namelab.textColor = [UIColor colorWithHexString:@"FFFEFE"];
        _namelab.text = @"爱唐张兵";
    }
    return _namelab;
}

@end
