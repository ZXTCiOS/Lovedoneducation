//
//  collecttopicparticularsVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "collecttopicparticularsVC.h"
#import "collecttopicparticularsCell.h"
#import "smartgroupModel.h"
#import "realanalysisCell.h"

@interface collecttopicparticularsVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *head;
@property (nonatomic, strong) UILabel *headnameLab;
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *collecttopicparticularsidentfid = @"collecttopicparticularsidentfid";

@implementation collecttopicparticularsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏详情";
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.head];

    self.headnameLab.text = self.namestr;
    [self prepareLayout];
    if (@available(iOS 11.0, *)){
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH-NAVIGATION_HEIGHT-60);
    }
    else
    {
        self.head.frame = CGRectMake(0, NAVIGATION_HEIGHT, kScreenW, 60);
        self.collectionV.frame = CGRectMake(0, 60, kScreenW, kScreenH-60);
    }
    self.indexPathNow = [NSIndexPath indexPathForItem:0 inSection:0];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *url = [NSString stringWithFormat:GET_userQuestionDetail,uid,token,self.uqid];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *arr = [obj objectForKey:@"data"];
            for (int i = 0; i<arr.count; i++) {
                NSDictionary *dic1 = [arr objectAtIndex:i];
                NSDictionary *dic = [dic1 objectForKey:@"questions"];
                smartgroupModel *model = [[smartgroupModel alloc] init];
                model.qid = [dic objectForKey:@"qid"];
                model.accuracy = [dic objectForKey:@"accuracy"];
                model.come = [dic objectForKey:@"come"];
                model.kaodian = [dic objectForKey:@"kaodian"];
                model.playnum = [dic objectForKey:@"playnum"];
                model.qanswer = [NSMutableArray array];
                model.qanswer = [dic objectForKey:@"qanswer"];
                model.qcid = [dic objectForKey:@"qcid"];
                model.qcontent = [NSMutableArray array];
                model.qcontent = [dic objectForKey:@"qcontent"];
                model.qctypeid = [dic objectForKey:@"qctypeid"];
                model.qdegree = [dic objectForKey:@"qdegree"];
                model.qdes = [NSMutableArray array];
                model.qdes = [dic objectForKey:@"qdes"];
                model.qerror = [dic objectForKey:@"qerror"];
                if (![[dic objectForKey:@"qsuccess"] isEqualToString:@"zxtc"]) {
                    model.qsuccess = [dic objectForKey:@"qsuccess"];
                }
                else
                {
                    model.qsuccess = @"";
                }
                model.qtid = [dic objectForKey:@"qtid"];
                model.qtgroup = [dic objectForKey:@"qtgroup"];
                model.qtitle = [dic objectForKey:@"qtitle"];
                model.qtype = [dic objectForKey:@"qtype"];
                model.qtpath = [dic objectForKey:@"qtpath"];
                model.successnum = [dic objectForKey:@"successnum"];
                model.time = [dic objectForKey:@"time"];
                [self.dataSource addObject:model];
            }
            [self.collectionV reloadData];
        }
    } failure:^(NSError *error) {
        
    }];;
}

-(UIView *)head
{
    if(!_head)
    {
        _head = [[UIView alloc] init];
        [_head addSubview:self.headnameLab];
        _head.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
    }
    return _head;
}

-(UILabel *)headnameLab
{
    if(!_headnameLab)
    {
        _headnameLab = [[UILabel alloc] init];
        _headnameLab.frame = CGRectMake(20, 20, 200, 20);
        _headnameLab.font = [UIFont systemFontOfSize:15];
        _headnameLab.textColor = [UIColor colorWithHexString:@"FEFEFE"];
    }
    return _headnameLab;
}

- (void)prepareLayout {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout .scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout .itemSize = CGSizeMake(kScreenW, kScreenH - NAVIGATION_HEIGHT-60);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT+60, kScreenW, kScreenH - NAVIGATION_HEIGHT-60) collectionViewLayout:self.layout];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    self.collectionV.bounces = YES;
    [self.collectionV registerClass:[realanalysisCell class] forCellWithReuseIdentifier:collecttopicparticularsidentfid];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    realanalysisCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collecttopicparticularsidentfid forIndexPath:indexPath];
    [cell setdata:self.dataSource[indexPath.item] andanswer0:@"" andanswer1:@""];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
