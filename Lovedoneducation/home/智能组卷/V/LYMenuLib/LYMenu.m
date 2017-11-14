//
//  LYMenuView.m
//  Droplets
//
//  Created by 米明 on 15/12/28.
//  Copyright © 2015年 米明. All rights reserved.
//

#import "LYMenu.h"

#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define BTN_Width 130
#define BTN_HEIGHT 40
#define NAVBAR_Height 64
//自定义
#define LYCustemColor(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

@interface LYMenu ()

/** 所有按钮 */
@property (nonatomic, strong) NSMutableArray         * buttons;

@property (nonatomic, strong) UIWindow               * backWindow;

@property (nonatomic, strong) UIView                 * backView;

@property (nonatomic, strong) UIView                 * bottomView;

@property (nonatomic, strong) UITapGestureRecognizer * tapPress;

@end

@implementation LYMenu

+(instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images menuType:(LYMenuType)type buttonAction:(LYMenuBlock)menuBlock{
    return [[self alloc]initWithTitles:titles images:images menuType:type buttonAction:menuBlock];
}

-(instancetype)initWithTitles:(NSArray *)titles images:(NSArray *)images menuType:(LYMenuType)type buttonAction:(LYMenuBlock)menuBlock{
    self = [super init];
    if (self) {
        self.titles = titles;
        self.images = images;
        self.menuBlock = menuBlock;
        self.menuType  = type;
        
        //titles 不能为nil 否则 抛出异常
        NSAssert(titles.count>0, @"titles can not be nil");
    }
    return self;
}
-(void)setMenuBlock:(LYMenuBlock)menuBlock{
    _menuBlock = nil;
    _menuBlock = [menuBlock copy];
}
- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}
-(void)show{
    [self setUp];
    
    self.backWindow.hidden = NO;
    
    [self.backWindow addSubview:self];
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_backView setAlpha:1];
        
    } completion:^(BOOL finished) {
        [_backView setUserInteractionEnabled:YES];
    }];
}
-(void)setUp{
    
    // 透明的view
    UIView *bView = [[UIView alloc] init];
    [bView setUserInteractionEnabled:NO];
    [bView setFrame:(CGRect){0, 0, SCREENSIZE}];
    [bView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:bView];
    _backView = bView;
    
    //tap
    [bView addGestureRecognizer:self.tapPress];
    
    //放置这些按钮的View
    UIView *btmView =[[UIView alloc]initWithFrame:CGRectMake(SCREENSIZE.width-BTN_Width-10, NAVBAR_Height+10, BTN_Width, self.titles.count*BTN_HEIGHT+4)];
    [bView addSubview:btmView];
    btmView.backgroundColor = LYCustemColor(0,157,232,1);
    _bottomView = btmView;
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    //三角形
    CGRect frame = CGRectMake(10, -5, 10, 10);
    if (_menuType == LYMenuTypeRight) {
        frame = CGRectMake(btmView.frame.size.width-20, -5, 10, 10);
    }
    
    UIView * imageV=[LYMenu creatViewWithFram:frame backgroundImageName:nil];
    //imageV.backgroundColor=LYCustemColor(0,157,232,1);
    imageV.userInteractionEnabled=NO;
    [btmView addSubview:imageV];
    imageV.backgroundColor = [UIColor whiteColor];
    imageV.layer.anchorPoint=CGPointMake(0.5, 0.5);
    imageV.transform=CGAffineTransformMakeRotation(M_PI_4);
    
    //buttons
    for (int i=0; i<self.titles.count; i++) {
        
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        if (self.images.count) {
           [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor colorWithHexString:@"646464"] forState:UIControlStateNormal];
        btn.frame=CGRectMake(0, 2+i*BTN_HEIGHT, btmView.frame.size.width, BTN_HEIGHT);
       // btn.backgroundColor=LYCustemColor(0,157,232,1);
        btn.titleLabel.textAlignment=NSTextAlignmentLeft;
        btn.tag=i;
        btn.alpha=0;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [btmView addSubview:btn];
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
        
        //划线
        if (i<self.titles.count-1) {
            UIView * v=[LYMenu creatViewWithFram:CGRectMake(12, BTN_HEIGHT-1, BTN_Width-24, 0.5) backgroundImageName:nil];
            v.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
            [btn addSubview:v];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  i*0.1* NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                    btn.center = CGPointMake(btmView.frame.size.width/2, btn.center.y);
                    btn.alpha  = 1;
                } completion:^(BOOL finished) {
                    
                }];
                
            });
        });
    }
    self.menuType = _menuType;
    [self setFrame:(CGRect){0, 0, SCREENSIZE}];
}

-(void)setMenuType:(LYMenuType)menuType{
    _menuType = menuType;
    CGPoint center = _bottomView.center;
    if (menuType==LYMenuTypeLeft) {
        center.x = 10 + _bottomView.bounds.size.width/2.0;
        _bottomView.center = center;
    }else{
        center.x = SCREENSIZE.width -10 - _bottomView.bounds.size.width/2.0;
        _bottomView.center = center;
    }
}
- (void)actionBtn:(UIButton *)btn{
    if (_menuBlock) {
        _menuBlock(btn.tag);
        [self dismiss];
    }
}
-(UITapGestureRecognizer *)tapPress{
    if (!_tapPress) {
        _tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    }
    return _tapPress;
}
-(void)dismiss{
    NSLog(@"dismiss");
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_backView setAlpha:0];
        [_backView setUserInteractionEnabled:NO];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];
}

// MARK: - +

+(UIView *)creatViewWithFram:(CGRect)frame backgroundImageName:(NSString *)name{
    UIView * view=[[UIView alloc]initWithFrame:frame];
    if (name.length) {
        view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:name]];
    }
    return  view ;
}

@end
