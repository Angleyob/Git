//
//  OrderViewController.m
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "O

rderViewController.h"
#import "FlightorderList.h"
#import "TrainorderList.h"
#import "HotelorderList.h"
@interface OrderViewController ()

@end
@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    self.navigationItem.hidesBackButton = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
     self.navigationItem.hidesBackButton = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
     self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    [self initview];
}
-(void)initview{
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view1 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 84, 375-20, 160)]];
    view1.backgroundColor=[UIColor whiteColor];
    
    UIImageView * flightimgview =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375-20, 60)]];
     flightimgview.image=[UIImage imageNamed:@"bg_airplane"];
     [view1 addSubview:flightimgview];
    
    UILabel * flabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 16, 40, 22)]];
    flabel.text=@"机票";
    flabel.textColor=[UIColor whiteColor];
//    flabel.font=[UIFont systemFontOfSize:14];
    flabel.textAlignment=NSTextAlignmentCenter;
    flabel.adjustsFontSizeToFitWidth =YES;
    [flightimgview addSubview:flabel];

    
    
    UIButton * but1  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but1.tag=101;
    [but1 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but1];
    
    UIImageView * b1= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b1.image=[UIImage imageNamed:@"list_all"];
    [but1 addSubview:b1];
    
    UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(-5, 32, 50/SCREEN_RATE+10, 15/SCREEN_RATE)];
    l1.text=@"全部订单";
    l1.font=[UIFont systemFontOfSize:14];
    l1.textAlignment=NSTextAlignmentCenter;
    l1.adjustsFontSizeToFitWidth =YES;
    [but1 addSubview:l1];
    
    
    UIButton * but2  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*2+50/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but2.tag=102;
    [but2 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    [view1 addSubview:but2];
    UIImageView * b2= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b2.image=[UIImage imageNamed:@"list_change"];
    [but2 addSubview:b2];
    
    UILabel * l2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l2.text=@"改签单";
    l2.font=[UIFont systemFontOfSize:14];
    l2.textAlignment=NSTextAlignmentCenter;
    l2.adjustsFontSizeToFitWidth =YES;
    [but2 addSubview:l2];

    UIButton * but3  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*3+100/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but3.tag=103;
    [but3 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    [view1 addSubview:but3];
    UIImageView * b3= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b3.image=[UIImage imageNamed:@"list_cancel"];
    [but3 addSubview:b3];
    
    UILabel * l3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l3.text=@"退票单";
    l3.textAlignment=NSTextAlignmentCenter;
    l3.font=[UIFont systemFontOfSize:14];
    l3.adjustsFontSizeToFitWidth =YES;
    [but3 addSubview:l3];

    UIButton * but4  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*4+150/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but4.tag=104;
    [but4 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView * b4= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b4.image=[UIImage imageNamed:@"list_wait_pay"];
    [but4 addSubview:b4];
    UILabel * l4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l4.text=@"待支付";
    l4.font=[UIFont systemFontOfSize:14];
    l4.textAlignment=NSTextAlignmentCenter;
    l4.adjustsFontSizeToFitWidth =YES;
    [but4 addSubview:l4];
    [view1 addSubview:but4];

    [self.view addSubview:view1];
    
    
    UIView * view2 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 160+20+15+64, 375-20, 160)]];
    view2.backgroundColor=[UIColor whiteColor];
    UIImageView * trainimgview =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375-20, 60)]];
    trainimgview.image=[UIImage imageNamed:@"bg_railway"];
    [view2 addSubview:trainimgview];
    
    
    UILabel * tlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 16, 60, 22)]];
    tlabel.text=@"火车票";
    tlabel.textColor=[UIColor whiteColor];
    //    flabel.font=[UIFont systemFontOfSize:14];
    tlabel.textAlignment=NSTextAlignmentCenter;
    tlabel.adjustsFontSizeToFitWidth =YES;
    [trainimgview addSubview:tlabel];
    
    UIButton * but21  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but21.tag=201;
     [but21 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    //  but1.backgroundColor=[UIColor redColor];
    [view2 addSubview:but21];
    
    UIImageView * b21= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b21.image=[UIImage imageNamed:@"list_all"];
    [but21 addSubview:b21];
    
    UILabel * l21 = [[UILabel alloc]initWithFrame:CGRectMake(-5, 32, 50/SCREEN_RATE+10, 15/SCREEN_RATE)];
    l21.text=@"全部订单";
    l21.font=[UIFont systemFontOfSize:14];
    l21.textAlignment=NSTextAlignmentCenter;
    l21.adjustsFontSizeToFitWidth =YES;
    [but21 addSubview:l21];
    
    
    UIButton * but22  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*2+50/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but22.tag=202;
    [but22 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:but22];
    UIImageView * b22= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b22.image=[UIImage imageNamed:@"list_change"];
    [but22 addSubview:b22];
    
    UILabel * l22 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l22.text=@"改签单";
    l22.font=[UIFont systemFontOfSize:14];
    l22.textAlignment=NSTextAlignmentCenter;
    l22.adjustsFontSizeToFitWidth =YES;
    [but22 addSubview:l22];
    
    UIButton * but23  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*3+100/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but23.tag=203;
     [but23 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:but23];
    UIImageView * b23= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b23.image=[UIImage imageNamed:@"list_cancel"];
    [but23 addSubview:b23];
    
    UILabel * l23 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l23.text=@"退票单";
    l23.textAlignment=NSTextAlignmentCenter;
    l23.font=[UIFont systemFontOfSize:14];
    l23.adjustsFontSizeToFitWidth =YES;
    [but23 addSubview:l23];
    
    UIButton * but24  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*4-20)/5*4+150/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but24.tag=204;
    [but24 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView * b24= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b24.image=[UIImage imageNamed:@"list_wait_pay"];
    [but24 addSubview:b24];
    UILabel * l24 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l24.text=@"待支付";
    l24.font=[UIFont systemFontOfSize:14];
    l24.textAlignment=NSTextAlignmentCenter;
    l24.adjustsFontSizeToFitWidth =YES;
    [but24 addSubview:l24];
    [view2 addSubview:but24];
    [self.view addSubview:view2];
    
    
    UIView * view3 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 2*160+20+30+64, 375-20, 160)]];
    view3.backgroundColor=[UIColor whiteColor];
    UIImageView * hotelimgview =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0,375-20, 60)]];
    hotelimgview.image=[UIImage imageNamed:@"bg_hotel"];

    UILabel * hlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 16, 40, 22)]];
    hlabel.text=@"酒店";
    hlabel.textColor=[UIColor whiteColor];
    //    flabel.font=[UIFont systemFontOfSize:14];
    hlabel.textAlignment=NSTextAlignmentCenter;
    hlabel.adjustsFontSizeToFitWidth =YES;
    [hotelimgview addSubview:hlabel];

    UIButton * but31  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*3-20)/4, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but31.tag=301;
    [but31 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    //  but1.backgroundColor=[UIColor redColor];
    [view3 addSubview:but31];
    
    UIImageView * b31= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b31.image=[UIImage imageNamed:@"list_all"];
    [but31 addSubview:b31];
    
    UILabel * l31 = [[UILabel alloc]initWithFrame:CGRectMake(-5, 32, 50/SCREEN_RATE+10, 15/SCREEN_RATE)];
    l31.text=@"全部订单";
    l31.font=[UIFont systemFontOfSize:14];
    l31.textAlignment=NSTextAlignmentCenter;
    l31.adjustsFontSizeToFitWidth =YES;
    [but31 addSubview:l31];
    
    UIButton * but32  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*3-20)/4*2+50/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but32.tag=302;
    [but32 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    [view3 addSubview:but32];
    UIImageView * b32= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b32.image=[UIImage imageNamed:@"list_wait_check"];
    [but32 addSubview:b32];
    
    UILabel * l32 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l32.text=@"待审批";
    l32.font=[UIFont systemFontOfSize:14];
    l32.textAlignment=NSTextAlignmentCenter;
    l32.adjustsFontSizeToFitWidth =YES;
    [but32 addSubview:l32];
    
    UIButton * but33  = [[UIButton alloc]initWithFrame:CGRectMake((deviceScreenWidth-(50/SCREEN_RATE)*3-20)/4*3+100/SCREEN_RATE, 83, 50/SCREEN_RATE, 50/SCREEN_RATE)];
    but33.tag=303;
    [but33 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    [view3 addSubview:but33];
    UIImageView * b33= [[UIImageView alloc]initWithFrame:CGRectMake(10/SCREEN_RATE, 0, 30/SCREEN_RATE, 30/SCREEN_RATE)];
    b33.image=[UIImage imageNamed:@"list_wait_pay"];
    [but33 addSubview:b33];
    UILabel * l33 = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 50/SCREEN_RATE, 15/SCREEN_RATE)];
    l33.text=@"待支付";
    l33.textAlignment=NSTextAlignmentCenter;
    l33.font=[UIFont systemFontOfSize:14];
    l33.adjustsFontSizeToFitWidth =YES;
    [but33 addSubview:l33];
    [view3 addSubview:hotelimgview];
    [self.view addSubview:view3];
}
-(void)buttonclick:(UIButton*)send{
    switch (send.tag) {
        case 101:{
            FlightorderList * fol = [FlightorderList new];
            fol.num=send.tag;
            fol.hidesBottomBarWhenPushed = YES;
[self.navigationController  pushViewController:fol animated:YES];
            //            [self presentViewController:fol animated:NO completion:nil];
            break;
        }
        case 102:{
            FlightorderList * fol = [FlightorderList new];
            fol.num=send.tag;
            fol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:fol animated:YES];
//            [self presentViewController:fol animated:NO completion:nil];
            break;
        }
        case 103:{
            FlightorderList * fol = [FlightorderList new];
            fol.num=send.tag;
            fol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:fol animated:YES];
//            [self presentViewController:fol animated:NO completion:nil];
            break;
        }
        case 104:{
            FlightorderList * fol = [FlightorderList new];
            fol.num=send.tag;
            fol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:fol animated:YES];
//            [self presentViewController:fol animated:NO completion:nil];
            break;
        }
        case 201:{
            TrainorderList * tol = [TrainorderList new];
            tol.num=send.tag;
            tol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:tol animated:YES];
//            [self presentViewController:tol animated:NO completion:nil];
            break;
        }
        case 202:{
            TrainorderList * tol = [TrainorderList new];
            tol.num=send.tag;
            tol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:tol animated:YES];

//            [self presentViewController:tol animated:NO completion:nil];
            break;
        }
        case 203:{
            TrainorderList * tol = [TrainorderList new];
            tol.num=send.tag;
            tol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:tol animated:YES];
//            [self presentViewController:tol animated:NO completion:nil];
            break;
        }
        case 204:{
            TrainorderList * tol = [TrainorderList new];
            tol.num=send.tag;
            tol.hidesBottomBarWhenPushed = YES;

            [self.navigationController  pushViewController:tol animated:YES];

//            [self presentViewController:tol animated:NO completion:nil];
            break;
        }
        case 301:{
            HotelorderList * hol = [HotelorderList new];
            hol.num=send.tag;
            hol.hidesBottomBarWhenPushed = YES;

            [self.navigationController  pushViewController:hol animated:YES];

//            [self presentViewController:hol animated:NO completion:nil];
            break;
        }
        case 302:{
            HotelorderList * hol = [HotelorderList new];
            hol.num=send.tag;
            hol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:hol animated:YES];
//            [self presentViewController:hol animated:NO completion:nil];
            break;
        }
        case 303:{
            HotelorderList * hol = [HotelorderList new];
            hol.num=send.tag;
            hol.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:hol animated:YES];
//            [self presentViewController:hol animated:NO completion:nil];
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
