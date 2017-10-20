//
//  changeCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeCell1.h"
#import "changeModel1.h"
@interface changeCell1()
@property (nonatomic,strong) changeModel1 *cmodel;
@end

@implementation changeCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setdata:(changeModel1 *)model
{
    self.cmodel = model;
    self.textLabel.text = model.testname;
}

@end
