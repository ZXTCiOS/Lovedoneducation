//
//  LiveEvalutateCell.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTKStarView.h"

@interface LiveEvalutateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *pingjiaL;
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (nonatomic, strong) WTKStarView *starV;


@end
