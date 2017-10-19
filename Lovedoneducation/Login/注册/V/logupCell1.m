//
//  logupCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "logupCell1.h"

@implementation logupCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.infotext];
        [self setuplayout];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.infotext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_offset(40*HEIGHT_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
    }];
}
#pragma mark - getters

-(UITextField *)infotext
{
    if(!_infotext)
    {
        _infotext = [[UITextField alloc] init];
        
    }
    return _infotext;
}



@end
