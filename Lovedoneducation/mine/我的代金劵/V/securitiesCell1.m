//
//  securitiesCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "securitiesCell1.h"

@interface securitiesCell1()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *numberlab;
@property (nonatomic,strong) UILabel *messagelab;
@end

@implementation securitiesCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimg];
        [self.contentView addSubview:self.numberlab];
        [self.contentView addSubview:self.messagelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    [weakSelf.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.right.equalTo(weakSelf).with.offset(-14);
        make.top.equalTo(weakSelf).with.offset(45);
        make.height.mas_offset(45);
    }];
    [weakSelf.messagelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numberlab);
        make.right.equalTo(weakSelf.numberlab);
        make.top.equalTo(weakSelf.numberlab.mas_bottom).with.offset(20);
        make.height.mas_offset(20);
    }];
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"background_image_daijinquan"];
    }
    return _bgimg;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.font = [UIFont systemFontOfSize:36];
        _numberlab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _numberlab.textAlignment = NSTextAlignmentCenter;
    }
    return _numberlab;
}

-(UILabel *)messagelab
{
    if(!_messagelab)
    {
        _messagelab = [[UILabel alloc] init];
        _messagelab.font = [UIFont systemFontOfSize:14];
        _messagelab.textAlignment = NSTextAlignmentCenter;
        _messagelab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        
    }
    return _messagelab;
}


-(void)setdata:(NSDictionary *)dic
{
    if ([strisNull isNullToString:[dic objectForKey:@"price"]]) {
        self.numberlab.text = @"0";
    }
    else
    {
        self.numberlab.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"price"],@"爱唐币"];
    }
    self.messagelab.text = [NSString stringWithFormat:@"%@%@%@",@"您已累计签到",[dic objectForKey:@"days"],@"天，请继续努力"];
}



@end
