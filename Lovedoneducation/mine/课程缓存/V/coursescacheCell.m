//
//  coursescacheCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "coursescacheCell.h"
@interface coursescacheCell()
@property (nonatomic,strong) UILabel *headingslab;
@property (nonatomic,strong) UILabel *messagelab;
@property (nonatomic,strong) UIImageView *timeimg;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *personlab;
@property (nonatomic,strong) UIImageView *infoimg;
@property (nonatomic,strong) UIButton *livebtn;
@end

@implementation coursescacheCell

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
        [self setuplayout];
    }
    return self;
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.headingslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14);
        make.right.equalTo(weakSelf).with.offset(14);
        make.top.equalTo(weakSelf).with.offset(20);
       // make.height.mas_offset(20);
    }];
    [weakSelf.messagelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headingslab);
        make.right.equalTo(weakSelf.headingslab);
        make.top.equalTo(weakSelf.headingslab.mas_bottom).with.offset(10);
    }];
    [weakSelf.timeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.messagelab);
        make.top.equalTo(weakSelf.messagelab.mas_bottom).with.offset(10);
    }];
    [weakSelf.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeimg).with.offset(20);
        make.top.equalTo(weakSelf.timeimg);
        make.right.equalTo(weakSelf.headingslab);
    }];
    [weakSelf.infoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(50);
        make.height.mas_offset(50);
        make.left.equalTo(weakSelf).with.offset(14);
        make.bottom.equalTo(weakSelf).with.offset(-21);
    }];

    [weakSelf.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(85);
        make.top.equalTo(weakSelf.infoimg);
        make.width.mas_offset(120);
    }];

    [weakSelf.personlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.namelab);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(10);
    }];
    [weakSelf.livebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(73);
        make.right.equalTo(weakSelf).with.offset(-57);
        make.height.mas_offset(29);
        make.width.mas_offset(29);
    }];
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
        [_infoimg sd_setImageWithURL:[NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=17202515,2068320275&fm=214&gp=0.jpg"]];
    }
    return _infoimg;
}

-(UIButton *)livebtn
{
    if(!_livebtn)
    {
        _livebtn = [[UIButton alloc] init];
        [_livebtn setImage:[UIImage imageNamed:@"bofang_icon_kechenghuancun"] forState:normal];
    }
    return _livebtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {
        NSString *subViewName =NSStringFromClass([subView class]);
        if ([subViewName isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            subView.backgroundColor = [UIColor lightGrayColor];
            ((UIView *)[subView.subviews firstObject]).backgroundColor = [UIColor colorWithHexString:@"FF9B19"];
            
        }
    }
}

@end
