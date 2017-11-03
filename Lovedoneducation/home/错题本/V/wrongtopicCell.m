//
//  wrongtopicCell.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/2.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wrongtopicCell.h"

@implementation wrongtopicCell

- (void)updateCellWithModel:(wrongtopicModel *)model
{
    //如果是一级cell
    if (model.second_index == 0 && model.third_index == 0) {
        self.textLabel.text = [NSString stringWithFormat:@"%ld.%ld.%ld",model.first_index,model.second_index,model.third_index];
        return;
    }
    
    //如果是二级cell
    if (model.third_index == 0) {
        self.textLabel.text = [NSString stringWithFormat:@"     %ld.%ld.%ld",model.first_index,model.second_index,model.third_index];
        return;
    }
    
    //如果是三级cell
    self.textLabel.text = [NSString stringWithFormat:@"         %ld.%ld.%ld",model.first_index,model.second_index,model.third_index];
}

@end
