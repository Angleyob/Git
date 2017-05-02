//
//  StatusLookupVC.m
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "StatusLookupVC.h"
#import "AttentionFlightDid.h"

@interface StatusLookupVC ()

{
    AttentionFlightDid * afd;
    NumLookupVC * numdzvc;
    UIButton * bu1 ;
    UIButton * bu2 ;
    UIButton * bu3 ;
}
@property(nonatomic,strong)UIView * butWith;

@property(nonatomic,strong)UIView * v1;


@property(nonatomic,strong)UIScrollView * scrollView;

@end

@implementation StatusLookupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
//    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"航班动态";
    label.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"left"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    
    //创建视图按钮
    [self creatBut];
    //创建按钮指示器
    [self creatbutWith];
    //创建滑动视图
    [self creatSco];
    
}
#pragma mark -创建按钮
-(void)creatSco{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+(45/SCREEN_RATE1), self.view.frame.size.width, self.view.frame.size.height-64-(45/SCREEN_RATE1))];
    _scrollView.contentSize= CGSizeMake(3*self.view.frame.size.width, 0);
    //边界不滑动
    _scrollView.bounces = NO;
    //分页
    _scrollView.pagingEnabled = YES;
    //    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator=NO;
   
   numdzvc = [NumLookupVC new];
    numdzvc.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-(45/SCREEN_RATE1));
//    dzv.view.backgroundColor = [UIColor whiteColor];

    [_scrollView addSubview:numdzvc.view];
    
    LookupSiteVC * tpv = [LookupSiteVC new];
    tpv.view.frame=CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64-(45/SCREEN_RATE1));
//    tpv.view.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:tpv.view];
  
    afd = [AttentionFlightDid new];
    afd.view.frame=CGRectMake(2*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64-(45/SCREEN_RATE1));
    afd.view.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:afd.view];
    
    //添加视图控制器的层级结构
    [self addChildViewController:numdzvc];
    [self addChildViewController:tpv];
    [self addChildViewController:afd];
    [self.view addSubview:_scrollView];

    //添加KVO
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (object ==_scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        //获取contentOffset
        NSValue * pointValue = change[@"new"];
        CGFloat point;
        [pointValue getValue:&point];
        _butWith.frame=[framsizeclass newSuitFrame:CGRectMake(125*(point/deviceScreenWidth), 43 , 125, 3)];
    }
}
#pragma mark -标签视图
-(void)creatbutWith{
    
    _butWith = [[UIView alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 43 , 125, 3)]];
    _butWith.backgroundColor =  [UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1];
    [_v1 addSubview:_butWith];
}
#pragma mark -视图按钮
-(void)creatBut{
    
    _v1=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE1,375, 45)]];
    _v1.backgroundColor = [UIColor whiteColor];

     bu1 =[UIButton new];
    bu1.frame=[framsizeclass newSuitFrame:CGRectMake(0, 0, 125, 43)];
    [bu1 setTitle:@"航班号查询" forState:UIControlStateNormal  ];
    bu1.titleLabel.font=[UIFont systemFontOfSize:14];
    bu1.titleLabel.textAlignment=NSTextAlignmentCenter;
    [bu1 setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1] forState:UIControlStateNormal];
    bu1.tag=611;
    [bu1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    bu2 =[UIButton new];
    bu2.frame=[framsizeclass newSuitFrame:CGRectMake(125, 0, 125, 43)];
    [bu2 setTitle:@"起降地查询" forState:UIControlStateNormal];
    bu2.titleLabel.font=[UIFont systemFontOfSize:14];
    bu2.titleLabel.textAlignment=NSTextAlignmentCenter;
    [bu2 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
    bu2.tag=612;
    [bu2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    bu3 =[UIButton new];
    bu3.frame=[framsizeclass newSuitFrame:CGRectMake(125*2, 0, 125, 43)];
    [bu3 setTitle:@"已关注航班" forState:UIControlStateNormal  ];
    [bu3 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
    bu3.tag=613;
    bu3.titleLabel.font=[UIFont systemFontOfSize:14];
    bu3.titleLabel.textAlignment=NSTextAlignmentCenter;
    [bu3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_v1 addSubview:bu1];
    [_v1 addSubview:bu2];
    [_v1 addSubview:bu3];
    [self.view addSubview:_v1];
}
-(void)btnClicked:(UIButton *)bu{
    switch (bu.tag) {
        case 611:{
            _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(bu.tag-611), 0);
            _butWith.frame=[framsizeclass newSuitFrame:CGRectMake(125*(bu.tag-611), 43 , 125, 3)];
            [bu1 setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1] forState:UIControlStateNormal];
            [bu2 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
            [bu3 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
             break;
             }
        case 612:
            _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(bu.tag-611), 0);
            _butWith.frame=[framsizeclass newSuitFrame:CGRectMake(125*(bu.tag-611), 43 , 125, 3)];
            [bu2 setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1] forState:UIControlStateNormal];
            [bu1 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
            [bu3 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        case 613:{
            _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(bu.tag-611), 0);
            _butWith.frame=[framsizeclass newSuitFrame:CGRectMake(125*(bu.tag-611), 43 , 125, 3)];
            [bu3 setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1] forState:UIControlStateNormal];
            [bu2 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
            [bu1 setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
            [numdzvc.flightNO resignFirstResponder];
            //加载已关注数据
            [afd loadata];
            break;
        }
        default:
            break;
    }
}
-(void)back:(UIButton* )send{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
