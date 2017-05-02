//
//  ForgetpasswordViewController.m
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ForgetpasswordViewController.h"
#import "forgetpassWord.h"
@interface ForgetpasswordViewController ()
{
    NSMutableDictionary * dict ;
}
@property (nonatomic, strong) forgetpassWord*aView;  //实例化一个VView的对象
@end

@implementation ForgetpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dict =[NSMutableDictionary new];
   [self creatLogin];
}
-(void)creatLogin{
    //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    _aView=[[forgetpassWord alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight)];
    [_aView viewInit];
    [self.view addSubview:_aView];
    [_aView.backbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aView.loginbut addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
    
//    __block ForgetpasswordViewController *blockSelf = self;
    __block forgetpassWord * blockaView= _aView;
    blockaView.loginHandler=^(NSString *workNumber,NSString *cardnNmber,NSString*phoneNumber){
        VerifyCodeRequest * verify =[VerifyCodeRequest new];
        
        verify.EmpNo=workNumber;
        verify.Hykh=cardnNmber;
        verify.Mobile=phoneNumber;
        
        [dict setValue:workNumber forKey:@"UserName"];
        [dict setValue:phoneNumber forKey:@"Mobile"];
        [dict setValue:cardnNmber forKey:@"Hykh"];

        [Account VerifyCode:verify success:^(id data) {
           
            NSLog(@"****%@",data[@"message"]);
            
            if ([data[@"status"] isEqualToString:@"T"]) {
                [dict setValue:data[@"code"] forKey:@"Code"];

            }else{
                [dict setValue:@"code" forKey:@"Code"];

                [_aView changebackgraoud];
            }
        } failure:^(NSError *error) {
            
        }];
    };
}
-(void)onClick:(id)send{
    [UIView animateWithDuration:0.50f/*渐变动画的时间*/ animations:^{
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)onClick1:(id)send{

//    NSLog(@"%@",dict);
//    NSLog(@"%@",_aView.verifyNumber.text);
    
    if ([_aView.verifyNumber.text isEqualToString:dict[@"Code"]]) {
        ReplaceViewController * vv = [ReplaceViewController new];
        vv.dict=dict;
        vv.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //    vv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //    vv.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//        [self presentViewController:vv animated:YES completion:nil];
        [self.navigationController pushViewController:vv animated:YES];

    }else{
        _aView.tslabel0.text=@"您输入的验证码有误，请重试。";
        [_aView changebackgraoud];
    }
}


@end
