//
//  changeCell0.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "changeCell0.h"
#import "changeModel0.h"

@interface changeCell0()
@property (nonatomic,strong) changeModel0 *cemodel;
@end

@implementation changeCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    }
    return self;
}

-(void)setdata:(changeModel0 *)model
{
    self.cemodel = model;
    self.textLabel.text = model.testname;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
