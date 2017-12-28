//
//  messagedetalVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messagedetalVC.h"
#import "messagedetalModel.h"
#import "messagedetalCell.h"
#import "headView.h"

@interface messagedetalVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) headView *head;
@property (nonatomic, strong) UICollectionView *collectionV;
/**
 *  当前的位置
 */
@property (nonatomic, strong) NSIndexPath *indexPathNow;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

static NSString *messagedetalidentfid = @"messagedetalidentfid";

@implementation messagedetalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    [self prepareLayout];
    [self.view addSubview:self.head];
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
    NSString *url = [NSString stringWithFormat:GET_messageDetail,uid,token,self.questionid,self.type];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {

                NSArray *data = [obj objectForKey:@"data"];
                for (int i = 0; i<data.count; i++) {
                    NSObject *demoobj = [data objectAtIndex:i];
                    if ([demoobj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dic = [data objectAtIndex:i];
                        messagedetalModel *model = [messagedetalModel new];
                        model.qid = [dic objectForKey:@"qid"];
                        model.content = [dic objectForKey:@"content"];
                        model.questionintro = [NSMutableArray array];
                        model.questionintro = [dic objectForKey:@"questionintro"];
                        model.des = [dic objectForKey:@"des"];
                        [self.dataSource addObject:model];
                    }
                    else
                    {
                        
                    }
                }
                [self.collectionV reloadData];
                self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",@"1",@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
            
           
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint pInView = [self.view convertPoint:self.collectionV.center toView:self.collectionV];
    self.indexPathNow = [self.collectionV indexPathForItemAtPoint:pInView];
    int inter = (int)self.indexPathNow.item;
    int newint = inter+1;
    NSString *newstr = [NSString stringWithFormat:@"%ld",(long)newint];
    self.head.numberlab.text = [NSString stringWithFormat:@"%@%@%@",newstr,@"/",[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count]];
}

-(headView *)head
{
    if(!_head)
    {
        _head = [[headView alloc] init];
        [_head.timelab setHidden:YES];
        [_head.rightbtn setHidden:YES];
    }
    return _head;
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
    [self.collectionV registerClass:[messagedetalCell class] forCellWithReuseIdentifier:messagedetalidentfid];
    [self.view addSubview:self.collectionV];
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    messagedetalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:messagedetalidentfid forIndexPath:indexPath];
    [cell setdata:self.dataSource[indexPath.item]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
