//
//  myinfomessageCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfomessageCell.h"

@interface myinfomessageCell()
@property (nonatomic,strong) UILabel *headingslab;
@property (nonatomic,strong) UILabel *messagelab;
@property (nonatomic,strong) UIImageView *timeimg;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *personlab;
@property (nonatomic,strong) UIImageView *infoimg;
@property (nonatomic,strong) UIButton *livebtn;
@end

@implementation myinfomessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.headingslab];
        [self.contentView addSubview:self.messagelab];
        [self.contentView addSubview:self.timeimg];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.personlab];
        [self.contentView addSubview:self.infoimg];
        [self.contentView addSubview:self.livebtn];
    }
    return self;
}

#pragma mark - getters


-(UILabel *)headingslab
{
    if(!_headingslab)
    {
        _headingslab = [[UILabel alloc] init];
        _headingslab.text = @"如何突破笔试难关";
        _headingslab.textColor = [UIColor colorWithHexString:@"323232"];
        _headingslab.font = [UIFont systemFontOfSize:18];
        
    }
    return _headingslab;
}

-(UILabel *)messagelab
{
    if(!_messagelab)
    {
        _messagelab = [[UILabel alloc] init];
        _messagelab.text = @"课程摘要：两个月突破笔试难关";
        _messagelab.font = [UIFont systemFontOfSize:14];
        _messagelab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _messagelab;
}


-(UIImageView *)timeimg
{
    if(!_timeimg)
    {
        _timeimg = [[UIImageView alloc] init];
        _timeimg.image = [UIImage imageNamed:@"time_icon_kechenghuancun"];
    }
    return _timeimg;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.text = @"2017.08.14";
        _timelab.font = [UIFont systemFontOfSize:12];
        _timelab.textColor = [UIColor colorWithHexString:@"909090"];
    }
    return _timelab;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"林可为";
        _namelab.font = [UIFont systemFontOfSize:14];
        _namelab.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _namelab;
}

-(UILabel *)personlab
{
    if(!_personlab)
    {
        _personlab = [[UILabel alloc] init];
        _personlab.text = @"#笔试科目知名讲师#";
        _personlab.font = [UIFont systemFontOfSize:12];
        _personlab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _personlab;
}

-(UIImageView *)infoimg
{
    if(!_infoimg)
    {
        _infoimg = [[UIImageView alloc] init];
        
    }
    return _infoimg;
}

-(UIButton *)livebtn
{
    if(!_livebtn)
    {
        _livebtn = [[UIButton alloc] init];
        
    }
    return _livebtn;
}








@end
