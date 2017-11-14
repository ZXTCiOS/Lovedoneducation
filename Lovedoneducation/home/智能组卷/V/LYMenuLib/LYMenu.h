//
//  LYMenuView.h
//  Droplets
//
//  Created by 米明 on 15/12/28.
//  Copyright © 2015年 米明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYMenu;
typedef void(^LYMenuBlock)(NSInteger buttonIndex);

typedef enum menuType{
    LYMenuTypeRight=0,//Default
    LYMenuTypeLeft,
}LYMenuType;

@interface LYMenu : UIView

@property (nonatomic,strong) NSArray * titles;

@property (nonatomic,strong) NSArray * images;

@property (nonatomic) LYMenuType menuType;

@property (nonatomic,copy) LYMenuBlock menuBlock;

+ (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images menuType:(LYMenuType)type buttonAction:(LYMenuBlock)menuBlock;

- (instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images menuType:(LYMenuType)type buttonAction:(LYMenuBlock)menuBlock;

- (void)show;


@end
