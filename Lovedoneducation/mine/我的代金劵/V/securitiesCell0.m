//
//  securitiesCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "securitiesCell0.h"
#import "securitesModel.h"
#import "RMDashLineView.h"

@interface securitiesCell0()
@property (nonatomic,strong) UILabel *leftpriceLabel;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *leftnameLabel;
@property (nonatomic,strong) RMDashLineView *lineimg;
@property (nonatomic,strong) securitesModel *smodel;

@end

@implementation securitiesCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftpriceLabel];
        [self.contentView addSubview:self.leftnameLabel];
        [self.contentView addSubview:self.lineimg];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.messageLabel];
        [self selectImg];
        [self setuplayout];
        
 
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(20);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    [weakSelf.leftnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftpriceLabel);
        make.top.equalTo(weakSelf.leftpriceLabel.mas_bottom).with.offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(16);
    }];
    [weakSelf.lineimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-15);
        make.width.mas_offset(1);
        make.right.equalTo(weakSelf.leftnameLabel.mas_right).with.offset(15);
    }];
    [weakSelf.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineimg);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.left.equalTo(weakSelf.lineimg.mas_right).with.offset(15);
        
    }];
    [weakSelf.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numberLabel);
        make.right.equalTo(weakSelf.numberLabel);
        make.top.equalTo(weakSelf.numberLabel.mas_bottom).with.offset(20);
    }];
}

#pragma mark - getters

-(UILabel *)leftpriceLabel
{
    if(!_leftpriceLabel)
    {
        _leftpriceLabel = [[UILabel alloc] init];
//        _leftpriceLabel.text = @"¥ 100";
        _leftpriceLabel.textColor = [UIColor colorWithHexString:@"08D2B2"];
        _leftpriceLabel.textAlignment = NSTextAlignmentRight;
        _leftpriceLabel.font = [UIFont systemFontOfSize:24];
    }
    return _leftpriceLabel;
}

-(UILabel *)leftnameLabel
{
    if(!_leftnameLabel)
    {
        _leftnameLabel = [[UILabel alloc] init];
        _leftnameLabel.textAlignment = NSTextAlignmentRight;
        _leftnameLabel.text = @"课程劵";
        _leftnameLabel.font = [UIFont systemFontOfSize:12];
        _leftnameLabel.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _leftnameLabel;
}

-(RMDashLineView *)lineimg
{
    if(!_lineimg)
    {
        _lineimg = [[RMDashLineView alloc] init];
//        _lineimg.backgroundColor = [UIColor redColor];
        
    }
    return _lineimg;
}

-(UILabel *)numberLabel
{
    if(!_numberLabel)
    {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:17];
        _numberLabel.textColor = [UIColor colorWithHexString:@"646464"];
    }
    return _numberLabel;
}

-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor colorWithHexString:@"909090"];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

-(void)setdata:(securitesModel *)model
{
    self.smodel = model;
    self.leftpriceLabel.text = [NSString stringWithFormat:@"%@%@",@"",model.ucprice];
    self.numberLabel.text = [NSString stringWithFormat:@"%@%@%@",@"共",model.number,@"张"];
    self.messageLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.ucprice,@"元及",model.ucprice,@"元以下课程任意券"];
}

- (UIImageView *)selectImg{
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc] init];
        [self.contentView addSubview:_selectImg];
        _selectImg.image = [UIImage imageNamed:@"diyongquan_icon_default_tijiaodingdan"];
        [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-12);
            make.size.equalTo(CGSizeMake(22, 22));
        }];
        _selectImg.hidden = YES;
    }
    return _selectImg;
}



@end
