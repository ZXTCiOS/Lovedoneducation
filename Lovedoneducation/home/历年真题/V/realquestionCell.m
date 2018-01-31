//
//  realquestionCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realquestionCell.h"
#import "realquextionModel.h"
@interface realquestionCell()
@property (nonatomic,strong) UILabel *messagelab;
@property (nonatomic,strong) UILabel *scorelab;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) realquextionModel *rmodel;
@end

@implementation realquestionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.messagelab];
        [self.contentView addSubview:self.scorelab];
        [self.contentView addSubview:self.typelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.messagelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(15);
      //  make.height.mas_offset(20);
    }];
    [weakSelf.scorelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.messagelab);
        make.top.equalTo(weakSelf.messagelab.mas_bottom).with.offset(10);
        make.width.mas_offset(100);
    }];
    [weakSelf.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scorelab.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.scorelab);
        make.width.mas_offset(250);
        
    }];
}

#pragma mark - getters

-(UILabel *)messagelab
{
    if(!_messagelab)
    {
        _messagelab = [[UILabel alloc] init];
        _messagelab.textColor = [UIColor colorWithHexString:@"323232"];
        _messagelab.font = [UIFont systemFontOfSize:15];
    }
    return _messagelab;
}

-(UILabel *)scorelab
{
    if(!_scorelab)
    {
        _scorelab = [[UILabel alloc] init];
        _scorelab.font = [UIFont systemFontOfSize:12];
        _scorelab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _scorelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:12];
        _typelab.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _typelab;
}

-(void)setdata:(realquextionModel *)model
{
    self.rmodel = model;
    self.messagelab.text = model.qcname;
    NSString *str = @"";
    str = [NSString stringWithFormat:@"%.2f",[model.qdegree floatValue]/10];
    self.scorelab.text = [NSString stringWithFormat:@"%@%@",@"难度 : ",str];
    self.typelab.text = model.qcintro;
    
//    ctime = 1508739001;
//    ismake = 2;
//    qcid = 5;
//    qcintro = 2132;
//    qcname = "2017\U9ad8\U8003\U6a21\U62df\U5377";
//    qcscore = 100;
//    qctype = 1;
//    qdegree = 100;
}




@end
