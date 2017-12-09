//
//  collecttopicCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "collecttopicCell.h"
#import "collecttopicModel.h"

@interface collecttopicCell()
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) collecttopicModel *cmodel;
@end

@implementation collecttopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-20);
    }];
}

#pragma mark - getters


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];

    }
    return _contentlab;
}

#pragma mark - 数据方法

-(void)setdata:(collecttopicModel *)model
{
    self.cmodel = model;
    NSArray  *array = [model.uqid componentsSeparatedByString:@","];
    int num = (int)array.count-1;
    NSString *numstr = [NSString stringWithFormat:@"%d",num];
    NSString *name = model.name;
    NSString *str1 = [NSString stringWithFormat:@"%@%@%@",@"(",numstr,@")"];
    NSString *str = [NSString stringWithFormat:@"%@%@",name,str1];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"323232"]
                    range:NSMakeRange(0, name.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"909090"]
                    range:NSMakeRange(name.length, str1.length)];
    self.contentlab.attributedText = attrStr;
}

@end
