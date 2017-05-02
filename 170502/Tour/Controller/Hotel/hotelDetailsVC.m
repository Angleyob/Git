//
//  hotelDetailsVC.m
//  Tour
//
//  Created by Euet on 17/3/27.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelDetailsVC.h"

@interface hotelDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel* tglabel1;
}
@end

@implementation hotelDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView * view= [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 64*SCREEN_RATE1)]];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(375/2-(375/4), 20, 375/2, 30)]];
    label.text=@"酒店详情";
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    
    _textmess=[[UITextView alloc]initWithFrame:CGRectMake(20, 65, deviceScreenWidth-40, deviceScreenHeight-100)];
    _textmess.textColor=[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    
    NSString * str =[NSString stringWithFormat:@"酒店详情:\r\n\n   %@",_mesageStr];
  
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,5)];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(str.length-_mesageStr.length,_mesageStr.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1] range:NSMakeRange(0,5)];
    _textmess.editable=NO;

    _textmess.attributedText=attributedStr;

    // _textmess.text=str;
    
    [self.view addSubview:_textmess];
}
-(void)back:(UIButton*)but{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
