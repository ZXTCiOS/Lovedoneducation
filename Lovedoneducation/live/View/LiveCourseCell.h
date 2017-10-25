//
//  LiveCourseCell.h
//  Lovedoneducation
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveCourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *introL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UIView *teacher1;
@property (weak, nonatomic) IBOutlet UIImageView *teacher1Img;
@property (weak, nonatomic) IBOutlet UILabel *teacher1Name;

@property (weak, nonatomic) IBOutlet UIView *teacher2;
@property (weak, nonatomic) IBOutlet UIImageView *teacher2Img;
@property (weak, nonatomic) IBOutlet UILabel *teacher2Name;
@property (weak, nonatomic) IBOutlet UIView *teacher3;
@property (weak, nonatomic) IBOutlet UIImageView *teacher3Img;
@property (weak, nonatomic) IBOutlet UILabel *teacher3Name;





@end
