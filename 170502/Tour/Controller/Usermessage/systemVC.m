//
//  systemVC.m
//  Tour
//
//  Created by Euet on 17/3/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "systemVC.h"
#import "describeVc.h"

@interface systemVC ()
{
    NSString  * _str;
}
@end

@implementation systemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    label.text=@"系统设置";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    
    float i =[[SDImageCache sharedImageCache] getSize];
    if (i >0) {
        _str = [NSString stringWithFormat:@"%.02fM",i/1024/1024];
        [_clearbut setTitle:_str forState:UIControlStateNormal];
    }else{
        [_clearbut setTitle:@"0.0M" forState:UIControlStateNormal];
    }
    [_clearbut addTarget:self action:@selector(clearbutclick:) forControlEvents:UIControlEventTouchUpInside];
        
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sw1"] isEqualToString:@"1"]) {
        [_switch1 setOn:YES];
    }else{
        [_switch1 setOn:NO];
    }

    [_switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
   
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sw2"] isEqualToString:@"1"]) {
        [_switch2 setOn:YES];
    }else{
        [_switch2 setOn:NO];
        
    }
    
    [_switch2 addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tab99 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab99:)];
    [_didview addGestureRecognizer:tab99];
}

-(void)showGFtab99:(UITapGestureRecognizer *)tab99{
    describeVc *desc = [describeVc new];
  [self presentViewController:desc animated:NO completion:nil];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sw1"] isEqualToString:@"0"]) {
        [switchButton setOn:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sw1"];
    }else{
      [switchButton setOn:NO];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"sw1"];

    }
    //BOOL isButtonOn = [switchButton isOn];
    
   // if (isButtonOn) {
        
    //}else {
        
   // }
}
-(void)switchAction1:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"sw2"] isEqualToString:@"0"]) {
        [switchButton setOn:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sw2"];
    }else{
        [switchButton setOn:NO];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"sw2"];
        
    }
  
}
-(void)clearbutclick:(UIButton*)send{
    
   [[SDImageCache sharedImageCache] clearDisk];
   
    float i =[[SDImageCache sharedImageCache] getSize];
    
    if (i >0) {
        _str = [NSString stringWithFormat:@"%.02fM",i/1024/1024];
        [_clearbut setTitle:_str forState:UIControlStateNormal];
    }else{
        [_clearbut setTitle:@"0.0M" forState:UIControlStateNormal];
    }

    
}
-(void)back:(UIButton*)send{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
