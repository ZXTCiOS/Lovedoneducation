//
//  essaytableCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/5.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essaytableCell1.h"
#import "WJGtextView.h"
#import "IQUIView+IQKeyboardToolbar.h"
@interface essaytableCell1()<UITextViewDelegate>
@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIButton *imgbtn;
@property (nonatomic,strong) UIView *lineview;
@end

@implementation essaytableCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.lineview];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.img0];
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.imgbtn];
        
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    
    self.textView
    .sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(200)
    .topSpaceToView(self.contentView, 20);
    
    self.lineview
    .sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(250)
    .topSpaceToView(self.contentView, 20);
    
    self.imgbtn
    .sd_layout
    .leftSpaceToView(self.contentView, 30)
    .topSpaceToView(self.textView, 20)
    .widthIs(25)
    .heightIs(20);
    
    self.img0
    .sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 280)
    .widthIs(80*WIDTH_SCALE)
    .heightIs(80*WIDTH_SCALE);
    
    self.img1
    .sd_layout
    .leftSpaceToView(self.img0, 40)
    .topEqualToView(self.img0)
    .widthIs(80*WIDTH_SCALE)
    .heightIs(80*WIDTH_SCALE);
    
    self.img2
    .sd_layout
    .leftSpaceToView(self.img1, 40)
    .topEqualToView(self.img0)
    .widthIs(80*WIDTH_SCALE)
    .heightIs(80*WIDTH_SCALE);
    
    [self setupAutoHeightWithBottomView: self.img0 bottomMargin:20];
    
}

#pragma mark - getters


-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"点击开始答题";
        _textView.delegate = self;
        _textView.tag = 50001;
        _textView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
        [_textView addDoneOnKeyboardWithTarget:self action:@selector(startDone)];
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

-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _lineview;
}

-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _img1;
}

-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        _img2.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _img2;
}

-(void)setimgarr:(NSMutableArray *)array andtextstr:(NSString *)textstr
{
    if (array.count==3) {
        NSString *imgurl0 = [array firstObject];
        NSString *imgurl1 = [array objectAtIndex:1];
        NSString *imgurl2 = [array objectAtIndex:2];
        
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgurl0]];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgurl1]];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgurl2]];;
    }
    if (array.count==2) {
        NSString *imgurl0 = [array firstObject];
        NSString *imgurl1 = [array objectAtIndex:1];

        
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgurl0]];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgurl1]];

    }
    if (array.count==1) {
        NSString *imgurl0 = [array firstObject];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgurl0]];
    }
    if (array.count==0) {
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:@""]];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    }

    self.textView.text = textstr;
}

-(void)imgbtnclick
{
    [self.delegate myimgbtnclick:self];
}

-(void)startDone
{
    NSString *str = self.textView.text;
    [self.delegate textstr:self andtextstr:str];
    [self.textView resignFirstResponder];
}


@end
