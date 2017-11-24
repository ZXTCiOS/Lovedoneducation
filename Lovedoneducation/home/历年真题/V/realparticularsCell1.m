//
//  realparticularsCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsCell1.h"
#import "WJGtextView.h"

#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

@interface realparticularsCell1()

@property (nonatomic,copy) NSString *typestr;

@property (nonatomic,strong) UILabel *labA;
@property (nonatomic,strong) UILabel *labB;
@property (nonatomic,strong) UILabel *labC;
@property (nonatomic,strong) UILabel *labD;
@property (nonatomic,strong) UIImageView *imgA;
@property (nonatomic,strong) UIImageView *imgB;
@property (nonatomic,strong) UIImageView *imgC;
@property (nonatomic,strong) UIImageView *imgD;
@property (nonatomic,strong) WJGtextView *textView;

@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIButton *imgbtn;

@end

@implementation realparticularsCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.typestr = @"0";

        [self.contentView addSubview:self.labA];
        [self.contentView addSubview:self.labB];
        [self.contentView addSubview:self.labC];
        [self.contentView addSubview:self.labD];
        
        [self.contentView addSubview:self.imgA];
        [self.contentView addSubview:self.imgB];
        [self.contentView addSubview:self.imgC];
        [self.contentView addSubview:self.imgD];
        
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.imgbtn];
        [self.contentView addSubview:self.img0];
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        
    }
    return self;
}

//-(void)setarray:(NSMutableArray *)array andtype:(NSString *)type
-(void)setarray:(NSMutableArray *)array andtype:(NSString *)type andimgarr:(NSMutableArray *)imgarr
{
    if ([type isEqualToString:@"3"]) {
        self.typestr = @"3";
        
        [self.labA setHidden:YES];
        [self.labB setHidden:YES];
        [self.labC setHidden:YES];
        [self.labD setHidden:YES];
        
        [self.textView setHidden:NO];
        [self.imgbtn setHidden:NO];
        [self.img0 setHidden:NO];
        [self.img1 setHidden:NO];
        [self.img2 setHidden:NO];
        
        self.textView
        .sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .heightIs(200)
        .topSpaceToView(self.contentView, 20);

        if (imgarr.count==0) {
            self.imgbtn
            .sd_layout
            .leftSpaceToView(self.contentView, 20)
            .topSpaceToView(self.contentView, 250)
            .widthIs(100)
            .heightIs(100);
            [self.img0 setHidden:YES];
            [self.img1 setHidden:YES];
            [self.img2 setHidden:YES];
        }
        if (imgarr.count==1) {
            [self.img0 setHidden:NO];
            [self.img1 setHidden:YES];
            [self.img2 setHidden:YES];
            
            self.img0.image = [imgarr firstObject];
            
            self.img0
            .sd_layout
            .leftSpaceToView(self.contentView, 20)
            .topSpaceToView(self.contentView, 250)
            .widthIs(100)
            .heightIs(100);
            
            self.imgbtn
            .sd_layout
            .leftSpaceToView(self.img0, 140)
            .topSpaceToView(self.contentView, 250)
            .widthIs(100)
            .heightIs(100);
            
        }
        if (imgarr.count==2) {
            [self.img0 setHidden:NO];
            [self.img1 setHidden:NO];
            [self.img2 setHidden:YES];
        }
        if (imgarr.count==3) {
            [self.img0 setHidden:NO];
            [self.img1 setHidden:NO];
            [self.img2 setHidden:NO];
            [self.imgbtn setHidden:YES];
            
            
        }
        

        
         [self setupAutoHeightWithBottomView: self.imgbtn bottomMargin:20];
    }
    else
    {
        if (array.count==4) {
            [self.textView setHidden:YES];
            [self.imgbtn setHidden:YES];
            [self.img0 setHidden:YES];
            [self.img1 setHidden:YES];
            [self.img2 setHidden:YES];
            [self.labA setHidden:NO];
            [self.labB setHidden:NO];
            [self.labC setHidden:NO];
            [self.labD setHidden:NO];

            NSArray *arr0 = [array objectAtIndex:0];
            NSArray *arr1 = [array objectAtIndex:1];
            NSArray *arr2 = [array objectAtIndex:2];
            NSArray *arr3 = [array objectAtIndex:3];
            
            NSString *intstrA = [self datacontentarr:arr0];

            if ([intstrA isEqualToString:@"1"]) {
                NSString *answera = [arr0 firstObject];
                NSString *answerb = [arr1 firstObject];
                NSString *answerc = [arr2 firstObject];
                NSString *answerd = [arr3 firstObject];
                
                [self.imgA setHidden:NO];
                [self.imgB setHidden:NO];
                [self.imgC setHidden:NO];
                [self.imgD setHidden:NO];
                
                self.labA.text = [answera stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                self.labB.text = [answerb stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
                self.labC.text = [answerc stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
                self.labD.text = [answerd stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;

           
                NSString *imgurlA = [arr0 objectAtIndex:1];
                NSString *imgurlB = [arr1 objectAtIndex:1];
                NSString *imgurlC = [arr2 objectAtIndex:1];
                NSString *imgurlD = [arr3 objectAtIndex:1];
                
                [self.imgA sd_setImageWithURL:[NSURL URLWithString:imgurlA]];
                [self.imgB sd_setImageWithURL:[NSURL URLWithString:imgurlB]];
                [self.imgC sd_setImageWithURL:[NSURL URLWithString:imgurlC]];
                [self.imgD sd_setImageWithURL:[NSURL URLWithString:imgurlD]];
                
                
                __weak typeof (self) weakSelf = self;
        
                weakSelf.labA
                .sd_layout
                .leftSpaceToView(weakSelf.contentView, 20)
                .rightSpaceToView(weakSelf.contentView, 20)
                .topSpaceToView(weakSelf.contentView, 20)
                .heightIs(20);
                
                weakSelf.imgA
                .sd_layout
                .leftEqualToView(weakSelf.labA)
                .widthIs(80)
                .topSpaceToView(weakSelf.labA, 20)
                .heightIs(50);
                
                
                weakSelf.labB
                .sd_layout
                .leftEqualToView(weakSelf.labA)
                .rightEqualToView(weakSelf.labA)
                .topSpaceToView(weakSelf.imgA, 20+50)
                .heightIs(20);

                weakSelf.imgB
                .sd_layout
                .leftEqualToView(weakSelf.labB)
                .widthIs(80)
                .topSpaceToView(weakSelf.labB, 20)
                .heightIs(50);
                
                weakSelf.labC
                .sd_layout
                .leftEqualToView(weakSelf.labB)
                .rightEqualToView(weakSelf.labB)
                .topSpaceToView(weakSelf.imgB, 20+50+110)
                .heightIs(20);

                weakSelf.imgC
                .sd_layout
                .leftEqualToView(weakSelf.labA)
                .widthIs(80)
                .topSpaceToView(weakSelf.labC, 20)
                .heightIs(50);

                
                weakSelf.labD
                .sd_layout
                .leftEqualToView(weakSelf.labA)
                .rightEqualToView(weakSelf.labA)
                .topSpaceToView(weakSelf.imgC, 20+50+110+110)
                .autoHeightRatio(0);

                weakSelf.imgD
                .sd_layout
                .leftEqualToView(weakSelf.labA)
                .widthIs(80)
                .topSpaceToView(weakSelf.labD, 50)
                .heightIs(50);

                [self setupAutoHeightWithBottomView:weakSelf.labD bottomMargin:20];
                
            }
            else
            {
                NSString *answera = [arr0 componentsJoinedByString:@" "];
                NSString *answerb = [arr1 componentsJoinedByString:@" "];
                NSString *answerc = [arr2 componentsJoinedByString:@" "];
                NSString *answerd = [arr3 componentsJoinedByString:@" "];
                
                [self.imgA setHidden:YES];
                [self.imgB setHidden:YES];
                [self.imgC setHidden:YES];
                [self.imgD setHidden:YES];
                
                self.labA.text = [answera stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
                self.labB.text = [answerb stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
                self.labC.text = [answerc stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
                self.labD.text = [answerd stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
                [self setuptype1];
                //[self setupAutoHeightWithBottomView: self.labD bottomMargin:20];
            }
 

        }
    }
}

#pragma mark - getters

-(UILabel *)labA
{
    if(!_labA)
    {
        _labA = [[UILabel alloc] init];
        _labA.textColor = [UIColor colorWithHexString:@"646464"];
        _labA.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickA)];
        [_labA addGestureRecognizer:labelTapGestureRecognizer];
        _labA.userInteractionEnabled = YES;
    }
    return _labA;
}

-(UILabel *)labB
{
    if(!_labB)
    {
        _labB = [[UILabel alloc] init];
        _labB.textColor = [UIColor colorWithHexString:@"646464"];
        _labB.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickB)];
        [_labB addGestureRecognizer:labelTapGestureRecognizer];
        _labB.userInteractionEnabled = YES;
    }
    return _labB;
}

-(UILabel *)labC
{
    if(!_labC)
    {
        _labC = [[UILabel alloc] init];
        _labC.textColor = [UIColor colorWithHexString:@"646464"];
        _labC.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickC)];
        [_labC addGestureRecognizer:labelTapGestureRecognizer];
        _labC.userInteractionEnabled = YES;
    }
    return _labC;
}

-(UILabel *)labD
{
    if(!_labD)
    {
        _labD = [[UILabel alloc] init];
        _labD.textColor = [UIColor colorWithHexString:@"646464"];
        _labD.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClickD)];
        [_labD addGestureRecognizer:labelTapGestureRecognizer];
        _labD.userInteractionEnabled = YES;
    }
    return _labD;
}

-(UIImageView *)imgA
{
    if(!_imgA)
    {
        _imgA = [[UIImageView alloc] init];
        
    }
    return _imgA;
}

-(UIImageView *)imgB
{
    if(!_imgB)
    {
        _imgB = [[UIImageView alloc] init];
        
    }
    return _imgB;
}

-(UIImageView *)imgC
{
    if(!_imgC)
    {
        _imgC = [[UIImageView alloc] init];
        
    }
    return _imgC;
}

-(UIImageView *)imgD
{
    if(!_imgD)
    {
        _imgD = [[UIImageView alloc] init];
        
    }
    return _imgD;
}


-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"点击开始答题";
        _textView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _textView;
}


-(UIButton *)imgbtn
{
    if(!_imgbtn)
    {
        _imgbtn = [[UIButton alloc] init];
        [_imgbtn setImage:[UIImage imageNamed:@"paizhao_icon_zhuguanti"] forState:normal];
        [_imgbtn addTarget:self action:@selector(imgbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgbtn;
}

-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        
    }
    return _img1;
}

-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        
    }
    return _img2;
}

-(void)setuptype1
{
    __weak typeof (self) weakSelf = self;
    weakSelf.labA
    .sd_layout
    .leftSpaceToView(weakSelf.contentView, 20)
    .rightSpaceToView(weakSelf.contentView, 20)
    .topSpaceToView(weakSelf.contentView, 20)
    .autoHeightRatio(0);
    
    weakSelf.labB
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labA, 20)
    .autoHeightRatio(0);
    
    weakSelf.labC
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labB, 20)
    .autoHeightRatio(0);
    
    weakSelf.labD
    .sd_layout
    .leftEqualToView(weakSelf.labA)
    .rightEqualToView(weakSelf.labA)
    .topSpaceToView(weakSelf.labC, 20)
    .autoHeightRatio(0);

    [self setupAutoHeightWithBottomView: weakSelf.labD bottomMargin:20];
}


-(NSString* )datacontentarr:(NSArray *)arr
{
    NSString *str = @"";
    
    for (int i = 0; i<arr.count; i++) {
       
        NSString *string = [arr objectAtIndex:i];
        if([string rangeOfString:@"http://"].location !=NSNotFound)
        {
            str = @"1";
        }
        else
        {
            str = @"0";
        }
        
        
    }
    return str;
}

#pragma mark - 实现点击方法

-(void)labelClickA
{
    self.labA.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickA:self];
}

-(void)labelClickB
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickB:self];
}

-(void)labelClickC
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"FF9B19"];
    self.labD.textColor = [UIColor colorWithHexString:@"646464"];
    [self.delegate myTabVClickC:self];
}

-(void)labelClickD
{
    self.labA.textColor = [UIColor colorWithHexString:@"646464"];
    self.labB.textColor = [UIColor colorWithHexString:@"646464"];
    self.labC.textColor = [UIColor colorWithHexString:@"646464"];
    self.labD.textColor = [UIColor colorWithHexString:@"FF9B19"];
    [self.delegate myTabVClickD:self];
}

-(void)imgbtnclick
{
    [self.delegate myimgbtnclick:self];
}




@end
