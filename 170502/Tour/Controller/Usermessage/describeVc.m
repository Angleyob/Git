//
//  describeVc.m
//  Tour
//
//  Created by Euet on 17/4/25.
//  Copyright © 2017年 lhy. All rights reserved.
//
#define insureMess1 @"    中青易游旅游电子商务有限公司隶属于中国青旅旗下全资子公司。集团将全面整合各种优势资源，借助领先、便捷的智能技术，整合高科技产业与传统旅行业，为旅行者提供个性化的产品和优质的服务，将通过网站及移动客户端的全平台覆盖，随时随地为旅行者提供机票预订、酒店预订、旅游度假、商旅管理及旅游资讯等全方位的旅行服务，打造易游旅游综合性服务交易平台。";
#import "describeVc.h"

@interface describeVc ()
{
    UIView *view1;
    UIScrollView *scrollView;
    
    UIView * _infoconnetview;
    UILabel* tglabel1;
    
    //保险信息查询
    NSString *messageInsur;
}
@end

@implementation describeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"企业介绍";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backbut.tag=666;
    [view addSubview:backbut];
    

    
    scrollView = [[UIScrollView alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE1, 375, (deviceScreenHeight-64)*SCREEN_RATE1)]];
    
    view1 = [[UIView alloc]init];
    [scrollView addSubview:view1];
    
    tglabel1 = [[UILabel alloc]init];
    //    tglabel1.font=[UIFont systemFontOfSize:13];
    tglabel1.textColor=[UIColor blackColor];
    //自动折行设置
    tglabel1.lineBreakMode = UILineBreakModeWordWrap;
    tglabel1.numberOfLines = 0;
    messageInsur =insureMess1;
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
    
    tglabel1.attributedText=att;
    CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
    
    NSLog(@"%f",labelsize.height);
    
    view1.frame = CGRectMake(20, 20, deviceScreenWidth-40, labelsize.height);
    scrollView.contentSize = CGSizeMake(0,labelsize.height);
    
    [view1 addSubview:tglabel1];
    
    [tglabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(10));
        make.width.mas_equalTo(@(deviceScreenWidth-40));
        make.centerX.equalTo(view1);
    }];
    
    
    
//    UITapGestureRecognizer *tab88 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab88:)];
//    [scrollView addGestureRecognizer:tab88];
    [self.view addSubview:scrollView];
}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(CGSize)attributeString:(NSAttributedString *)attString boundingRectWithSize:(CGSize)size {
    if (!attString) {
        return CGSizeZero;
    }
    return [attString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
