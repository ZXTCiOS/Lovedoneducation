//
//  exerciseweeklyCell3.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell3.h"
#import "ZYProGressView.h"
@interface exerciseweeklyCell3()
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) UILabel *lab0;
@property (nonatomic,strong) NSMutableArray *namearray;
@property (nonatomic,strong) NSMutableArray *baifenbiarray;
@end

@implementation exerciseweeklyCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.namearray = [NSMutableArray array];
        self.baifenbiarray = [NSMutableArray array];
        [self.contentView addSubview:self.bgview];
        [self.contentView addSubview:self.lab0];
        [self setuplayout];
        
        //  [self getview];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(70);
    }];
    [weakSelf.lab0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.bgview).with.offset(30);
    }];
}

#pragma mark - getters

-(UIView *)bgview
{
    if(!_bgview)
    {
        _bgview = [[UIView alloc] init];
        _bgview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _bgview;
}

-(UILabel *)lab0
{
    if(!_lab0)
    {
        _lab0 = [[UILabel alloc] init];
        _lab0.text = @"正确率";
        _lab0.font = [UIFont systemFontOfSize:17];
        _lab0.textColor = [UIColor colorWithHexString:@"323232"];
    }
    return _lab0;
}

-(void)getviewnamearr:(NSMutableArray *)namearr andbaifenbi:(NSMutableArray *)baifenbi
{
    for (int i = 0; i<namearr.count; i++) {
        UILabel *leftnamelab = [[UILabel alloc] init];
        [self.contentView addSubview:leftnamelab];
        leftnamelab.sd_layout
        .topSpaceToView(self.lab0, i*50+30)
        .heightIs(30)
        .leftSpaceToView(self.contentView, 20)
        .widthIs(100);
        leftnamelab.text = [namearr objectAtIndex:i];
        leftnamelab.font = [UIFont systemFontOfSize:15];
        leftnamelab.textColor = [UIColor colorWithHexString:@"323232"];
        
        
        UILabel *rightlab = [[UILabel alloc] init];
        NSString *str = [NSString stringWithFormat:@"%@%@",[baifenbi objectAtIndex:i],@"%"];
        rightlab.text = str;
        rightlab.textAlignment = NSTextAlignmentRight;
        rightlab.textColor = [UIColor colorWithHexString:@"FF9B10"];
        rightlab.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:rightlab];
        rightlab.sd_layout.topEqualToView(leftnamelab).rightSpaceToView(self.contentView, 20).widthIs(50).heightIs(20);
        
        ZYProGressView*  progress = [[ZYProGressView alloc]initWithFrame:CGRectMake(50, 100, 200, 2)];
        float f1 = [[baifenbi objectAtIndex:i] floatValue];
        float f2 = f1/100;
        NSString *prostr = [NSString stringWithFormat:@"%f",f2];
        progress.progressValue = prostr;
        [self.contentView addSubview:progress];
        progress.bottomColor = [UIColor whiteColor];
        progress.progressColor = [UIColor colorWithHexString:@"FF9B10"];
        progress.time = 2;
        progress.sd_layout
        .leftSpaceToView(leftnamelab, 20)
        .rightSpaceToView(rightlab, 20)
        .topSpaceToView(self.lab0, i*50+44)
        .heightIs(20);
        
        [self setupAutoHeightWithBottomView:leftnamelab bottomMargin:20];
        
    }
}

-(void)setdata:(NSDictionary *)dic
{
    NSArray *arr = [dic objectForKey:@"questionlist"];
    if (arr.count==0) {
        
    }
    else
    {
        for (int i = 0; i<arr.count; i++) {
            NSDictionary *dic = [arr objectAtIndex:i];
            NSString *name = [dic objectForKey:@"name"];
            NSString *baifenbi = [dic objectForKey:@"baifenbi"];
            [self.namearray addObject:name];
            [self.baifenbiarray addObject:baifenbi];
        }
        [self getviewnamearr:self.namearray andbaifenbi:self.baifenbiarray];
    }
}

@end
