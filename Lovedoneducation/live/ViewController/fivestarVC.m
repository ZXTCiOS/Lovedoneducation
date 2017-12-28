//
//  fivestarVC.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/12/27.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "fivestarVC.h"
#import "WTKStarView.h"
#import "WJGtextView.h"

@interface fivestarVC ()
{
    __block NSString *vaule;
}
@property (nonatomic,strong) WTKStarView *startView;
@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) UIButton *submitbtn;
@end

@implementation fivestarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加评论";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [self.view addSubview:self.startView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitbtn];
    [self loaddata];
    
    //__block NSString *vaule = @"";
    
    _startView.starBlock = ^(NSString *star){
        NSLog(@"%@",star);
        vaule = star;
       
    };
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    self.textView.frame = CGRectMake(30, 230, kScreenW-60, 150);
    self.submitbtn.frame = CGRectMake(kScreenW/2-60, 400, 120, 40);
}

#pragma mark - getters

-(WTKStarView *)startView
{
    if(!_startView)
    {
        _startView = [[WTKStarView alloc]initWithFrame:CGRectMake(40, 150, kScreenW-80, 60) starSize:CGSizeZero withStyle:WTKStarTypeInteger];
        _startView.star = 5;
        _startView.isTouch = YES;
    }
    return _startView;
}

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"点击添加评论";
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        _submitbtn.backgroundColor = [UIColor colorWithHexString:@"08D2B2"];
        [_submitbtn setTitle:@"提交评论" forState:normal];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_submitbtn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:normal];
    }
    return _submitbtn;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
//   // POST_COMMENT

    NSLog(@"vaule------%@",vaule);
    int vauleint = [vaule intValue];
    int cscoreint = vauleint*20;
    NSString *cscore = @"";
    cscore = [NSString stringWithFormat:@"%d",cscoreint];
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    NSString *ccontent = @"";
    if (_textView.text.length==0) {
        ccontent = @"";
    }
    else
    {
        ccontent = self.textView.text;
    }
    NSDictionary *para = @{@"uid":uid,@"token":token,@"cscore":cscore,@"ccontent":ccontent,@"tid":self.tid,@"cdid":self.cdid};
    [DNNetworking postWithURLString:POST_COMMENT parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            [MBProgressHUD showSuccess:@"评论成功" toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
    }];
}

@end
