//
//  NeedViewController.m
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "NeedViewController.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface NeedViewController ()

@end
@implementation NeedViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self initview];
}
-(void)initview{
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 375/SCREEN_RATE, 210/SCREEN_RATE)];
    imageview.image =[UIImage imageNamed:@"banner"];
    [self.view addSubview:imageview];
    
    UIView * view1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64+210+31, 375, 88)]];
    view1.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:view1];
    //审批管理
    UIView * view2 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 43.5)]];
    view2.backgroundColor=[UIColor whiteColor];
    [view1 addSubview:view2];
    UITapGestureRecognizer *viewclick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF:)];
    [view2 addGestureRecognizer:viewclick];
    UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(22, 11, 22, 24)]];
    imageV2.image= [UIImage imageNamed:@"asp"];
    [view2 addSubview:imageV2];
    UIImageView * imageV21 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(39, 8, 8, 8)]];
    imageV2.image = [UIImage imageNamed:@"asp"];
    [view2 addSubview:imageV21];
    UILabel * lablel2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(60, 11, 64, 18)]];
    lablel2.text=@"审批管理";
    lablel2.adjustsFontSizeToFitWidth=YES;
    [view2 addSubview:lablel2];
    UIImageView * imageV22 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(352, 15, 8, 13)]];
    imageV22.image = [UIImage imageNamed:@"chevron"];
    [view2 addSubview:imageV22];

    UIView * lineview3= [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 43.5, 355, 1)]];
    //lineview3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    lineview3.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [view1 addSubview:lineview3];
    
    UIView * view4 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 44.5, 375, 43.5)]];
    view4.backgroundColor=[UIColor whiteColor];
    [view1 addSubview:view4];
    
    UITapGestureRecognizer *viewclick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF1:)];
    [view4 addGestureRecognizer:viewclick1];
    
    UIImageView * imageV4 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(21, 11, 24, 20)]];
    imageV4.image = [UIImage imageNamed:@"flight_dynamics"];
    [view4 addSubview:imageV4];
    //UIImageView * imageV41 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(39, 8, 8, 8)]];
    //imageV2.image = [UIImage imageNamed:@""];
   // [view2 addSubview:imageV41];
    UILabel * lablel4 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(60, 11, 64, 18)]];
    lablel4.adjustsFontSizeToFitWidth=YES;
    lablel4.text=@"航班动态";
    [view4 addSubview:lablel4];
    UIImageView * imageV42 = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(352, 15, 8, 13)]];
    imageV42.image = [UIImage imageNamed:@"chevron"];
    [view4 addSubview:imageV42];
}
-(void)showGF:(UITapGestureRecognizer*)viewclick{
    ApprovalVC * avc = [ApprovalVC new];
    avc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:avc animated:YES];
//[self presentViewController:avc animated:NO completion:nil];
}



-(void)showGF1:(UITapGestureRecognizer*)viewclick1{
    StatusLookupVC * avc = [StatusLookupVC new];
//[self.navigationController pushViewController:avc animated:YES];
   [self presentViewController:avc animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
