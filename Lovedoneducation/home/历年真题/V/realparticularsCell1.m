//
//  realparticularsCell1.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/11/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "realparticularsCell1.h"
#import "WJGtextView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import <Photos/Photos.h>
#import "HX_AssetManager.h"
#import "HX_AddPhotoView.h"

#define VERSION [[UIDevice currentDevice].systemVersion doubleValue]

@interface realparticularsCell1()<HX_AddPhotoViewDelegate>
@property (nonatomic,copy) NSString *typestr;

@property (nonatomic,strong) UILabel *labA;
@property (nonatomic,strong) UILabel *labB;
@property (nonatomic,strong) UILabel *labC;
@property (nonatomic,strong) UILabel *labD;

@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) HX_AddPhotoView *addPhotoView;
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
        
        [self setuptype1];
        [self setuptype2];
    }
    return self;
}

-(void)setarray:(NSMutableArray *)array andtype:(NSString *)type
{
    if ([type isEqualToString:@"3"]) {
        self.typestr = @"3";
        
        [self.labA setHidden:YES];
        [self.labB setHidden:YES];
        [self.labC setHidden:YES];
        [self.labD setHidden:YES];
        
        [self.contentView addSubview:self.textView];
        [self.textView setHidden:NO];
        [self.addPhotoView setHidden:NO];
        self.textView
        .sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .heightIs(200)
        .topSpaceToView(self.contentView, 20);
        
        self.addPhotoView
        .sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .heightIs(80)
        .topSpaceToView(self.textView, 15);
        
         [self setupAutoHeightWithBottomView: self.addPhotoView bottomMargin:20];
    }
    else
    {
        [self.textView setHidden:YES];
        [self.addPhotoView setHidden:YES];
        [self.labA setHidden:NO];
        [self.labB setHidden:NO];
        [self.labC setHidden:NO];
        [self.labD setHidden:NO];
        
        NSArray *arr0 = [array objectAtIndex:0];
        NSArray *arr1 = [array objectAtIndex:1];
        NSArray *arr2 = [array objectAtIndex:2];
        NSArray *arr3 = [array objectAtIndex:3];
        
        NSString *answera = [arr0 componentsJoinedByString:@" "];
        NSString *answerb = [arr1 componentsJoinedByString:@" "];
        NSString *answerc = [arr2 componentsJoinedByString:@" "];
        NSString *answerd = [arr3 componentsJoinedByString:@" "];
        
        self.labA.text = [answera stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        self.labB.text = [answerb stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
        self.labC.text = [answerc stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
        self.labD.text = [answerd stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];;
        
        [self setupAutoHeightWithBottomView: self.labD bottomMargin:20];
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

-(void)setuptype2
{
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //
    //    // 只选择照片
    self.addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:3 WithSelectType:SelectPhoto];
    
    // 每行最大个数  不设置默认为4
    self.addPhotoView.lineNum = 6;
    
    // collectionView 距离顶部的距离  底部与顶部一样  不设置,默认为0
    self.addPhotoView.margin_Top = 5;
    
    // 距离左边的距离  右边与左边一样  不设置,默认为0
    self.addPhotoView.margin_Left = 10;
    //
    // 每个item间隔的距离  如果最小不能小于5   不设置,默认为5
    self.addPhotoView.lineSpacing = 5;
    
    // 录制视频时最大多少秒   默认为60;
    self.addPhotoView.videoMaximumDuration = 60.f;
    
    // 自定义相册的名称 - 不设置默认为自定义相册
    self.addPhotoView.customName = @"郑莹";
    self.addPhotoView.delegate = self;
    self.addPhotoView.backgroundColor = [UIColor whiteColor];
//    self.addPhotoView.frame = CGRectMake(0, 300, width, 0);
    [self.contentView addSubview:self.addPhotoView];
    
    /**  当前选择的个数  */
    self.addPhotoView.selectNum = 3;
    
    [self.addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {
        NSLog(@"photo - %@",photos);
        
        // 选择视频的沙盒文件路径  -  已压缩
        NSString *videoFileName = videoFileNames.firstObject;
        NSLog(@"videoFileNames - %@",videoFileName);
        
        [photos enumerateObjectsUsingBlock:^(id asset, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // ios8.0 以下返回的是ALAsset对象 以上是PHAsset对象
            if (VERSION < 8.0f) {
               // ALAsset *oneAsset = (ALAsset *)asset;
                // 缩略图
                //            UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                
                // 原图
                //            CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
                
                // url
                //            NSURL *url = [[asset defaultRepresentation] url];
            }else {
                PHAsset *twoAsset = (PHAsset *)asset;
                
                CGFloat scale = [UIScreen mainScreen].scale;
                
                // 根据输入的大小来控制返回的图片质量
                CGSize size = CGSizeMake(300 * scale, 300 * scale);
                [[HX_AssetManager sharedManager] accessToImageAccordingToTheAsset:twoAsset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
                    
                    // image为高清图时
                    if (![info objectForKey:PHImageResultIsDegradedKey]) {
                        // 高清图
                        //image;
                    }
                }];
            }
            
        }];
    }];
}

-(void)setuptype3
{
    
}

#pragma mark - 实现点击方法

-(void)labelClickA
{
    
}

-(void)labelClickB
{
    
}

-(void)labelClickC
{
    
}

-(void)labelClickD
{
    
}

@end
