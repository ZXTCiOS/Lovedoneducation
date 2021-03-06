//
//  essaycardVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "essaycardVC.h"
#import "essaycardCell.h"
#import "essayorderVC.h"

@interface essaycardVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UILabel *contentlab;
@property (nonatomic, strong) UILabel *typelab;
@end


static NSString *essaycardientfid0 = @"essaycardientfid0";
static NSString *essaycardientfid1 = @"essaycardientfid1";


@implementation essaycardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"答题卡";
    [self.view addSubview:self.headView];
    [self prepareLayout];
    self.leftLab.text = self.titlestr;
    if (@available(iOS 11.0, *)){
        self.headView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collection.frame = CGRectMake(30, NAVIGATION_HEIGHT+80, kScreenW-60, kScreenH-NAVIGATION_HEIGHT-80);
    }
    else
    {
        self.headView.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collection.frame = CGRectMake(30, 80, kScreenW-60, kScreenH-80);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getters

-(UIView *)headView
{
    if(!_headView)
    {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_headView addSubview:self.leftLab];
    }
    return _headView;
}

-(UILabel *)leftLab
{
    if(!_leftLab)
    {
        _leftLab = [[UILabel alloc] init];
        _leftLab.frame = CGRectMake(15, 10, kScreenW-30, 40);
        _leftLab.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        _leftLab.font = [UIFont systemFontOfSize:15];

    }
    return _leftLab;
}

- (void)prepareLayout {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(30, NAVIGATION_HEIGHT+60, kScreenW-60, kScreenH - NAVIGATION_HEIGHT-60) collectionViewLayout:self.layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.pagingEnabled = YES;
    self.collection.bounces = YES;
    self.layout.footerReferenceSize = CGSizeMake(kScreenW-60, 200);
    [self.collection registerClass:[essaycardCell class] forCellWithReuseIdentifier:essaycardientfid0];
    [self.view addSubview:self.collection];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:essaycardientfid1];
}

#pragma mark -UICollectionViewDataSource&&UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    essaycardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:essaycardientfid0 forIndexPath:indexPath];
    int intnum = (int)indexPath.item;
    int intnum2 = intnum+1;
    NSString *numstr = [NSString stringWithFormat:@"%d",intnum2];
    [cell setdata:self.dataSource[indexPath.item] andnumitem:numstr];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

///定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}

///定义每个UICollectionView 的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 0);//上下左右
}

///定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

///头部显示的内容(此处可放置UIScrollview)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionFooter withReuseIdentifier:essaycardientfid1 forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    self.submitBtn = [[UIButton alloc] init];
    [self.submitBtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    [self.submitBtn setTitle:@"交卷并查看结果" forState:normal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    self.submitBtn.frame = CGRectMake(headerView.frame.size.width/2-110, 30, 220, 44);
    [self.submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.submitBtn];
    
    
    self.contentlab = [[UILabel alloc] init];
    self.typelab = [[UILabel alloc] init];
    
    NSString * numser = self.numstr;
    NSString * pricestr = self.pricestr;
    NSString *str1 = @"共计";
    NSString *str2 = numser;
    NSString *str3 = @"道题目，总计";
    NSString *str4 = pricestr;
    NSString *str5 = @"";
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",str1,str2,str3,str4,str5];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(0, str1.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(str1.length, str2.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str1.length + str2.length, str3.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"FF9B19"]
                    range:NSMakeRange(str1.length + str2.length+str3.length, str4.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"646464"]
                    range:NSMakeRange(str1.length + str2.length+str3.length+str4.length, str5.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(0, str1.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(str1.length, str2.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(str1.length + str2.length, str3.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(str1.length + str2.length+str3.length, str4.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(str1.length + str2.length+str3.length+str4.length, str5.length)];
    self.contentlab.attributedText = attrStr;
    self.typelab.text = @"#请耐心等待，我们会在24小时之内给您答案#";
    self.typelab.font = [UIFont systemFontOfSize:12];
    self.typelab.textColor = [UIColor colorWithHexString:@"909090"];
    
    self.contentlab.frame = CGRectMake(0, 90, kScreenW-60, 40);
    self.typelab.frame = CGRectMake(0, 150, kScreenW-60, 20);
    
    self.contentlab.textAlignment = NSTextAlignmentCenter;
    self.typelab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:self.contentlab];
    [headerView addSubview:self.typelab];
    return headerView;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    NSLog(@"submit");
    essayorderVC *vc = [essayorderVC new];
    vc.numstr = self.numstr;
    vc.pricestr = self.pricestr;
    vc.timestr = [self getCurrentTimes];
    vc.para = self.para;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 获取当前时间

 @return 当前时间
 */
-(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}
@end
