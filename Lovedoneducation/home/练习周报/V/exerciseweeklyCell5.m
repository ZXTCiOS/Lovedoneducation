//
//  exerciseweeklyCell5.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "exerciseweeklyCell5.h"

@interface exerciseweeklyCell5()
@property (nonatomic,strong) NSMutableArray *namearray;
@property (nonatomic,strong) NSMutableArray *numarray;
@end

@implementation exerciseweeklyCell5

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.namearray = [NSMutableArray array];
        self.numarray = [NSMutableArray array];
        //[self setuplayout];
    }
    return self;
}

-(void)setuplayoutnamestr:(NSMutableArray *)name andnumstr:(NSMutableArray *)num
{
    __weak typeof (self) weakSelf = self;
    for (int i = 0; i<name.count; i++) {
        UILabel *leftlab = [[UILabel alloc] init];
        [self.contentView addSubview:leftlab];
        leftlab.sd_layout
        .topSpaceToView(weakSelf.contentView, i*50+30)
        .heightIs(30)
        .leftSpaceToView(weakSelf.contentView, 20)
        .widthIs(150);
        leftlab.textColor = [UIColor colorWithHexString:@"323232"];
        leftlab.font = [UIFont systemFontOfSize:15];
        leftlab.text = [name objectAtIndex:i];
        [self setupAutoHeightWithBottomView: leftlab bottomMargin:20];
        
        UILabel *numberlab = [[UILabel alloc] init];
        [self.contentView addSubview:numberlab];
        NSString *numstr = [NSString stringWithFormat:@"%@%@",[num objectAtIndex:i],@"题"];
        numberlab.text = numstr;
        numberlab.textAlignment = NSTextAlignmentRight;
        numberlab.font = [UIFont systemFontOfSize:18];
        numberlab.textColor = [UIColor colorWithHexString:@"08D2B2"];
        numberlab.sd_layout
        .topEqualToView(leftlab)
        .rightSpaceToView(weakSelf.contentView, 20)
        .heightIs(30)
        .widthIs(100);
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
            NSString *num = [dic objectForKey:@"num"];
            
            [self.namearray addObject:name];
            [self.numarray addObject:num];
        }
        [self setuplayoutnamestr:self.namearray andnumstr:self.numarray];
    }
}
@end
