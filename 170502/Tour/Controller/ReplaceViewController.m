//
//  ReplaceViewController.m
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ReplaceViewController.h"
#import "ReplacePassword.h"
@interface ReplaceViewController ()
@property (nonatomic, strong) ReplacePassword*aView;  //实例化一个VView的对象
@end

@implementation ReplaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLogin];
}
-(void)creatLogin{
    //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    _aView=[[ReplacePassword alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight)];
    [_aView viewInit];
    [_aView.backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_aView.loginbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_aView];
    //    };
}
-(void)back:(UIButton *)send{
    [self.navigationController popViewControllerAnimated:YES];
// [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)onClick:(UIButton *)send{
    
    if(![_aView.newpassWord0.text isEqualToString:@""]){
        if([_aView.newpassWord0.text isEqualToString:_aView.newpassWord.text]){
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        __block ReplaceViewController *blockSelf = self;
        __block ReplacePassword * blockaView= _aView;
        //    blockaView.loginHandler=^(NSString *newpassWord0,NSString *newpassWord){
        ResetPasswordRequest* reset = [ResetPasswordRequest new];
        reset.Code=_dict[@"Code"];
        reset.Hykh=_dict[@"Hykh"];
        reset.Mobile=_dict[@"Mobile"];
        reset.UserName=_dict[@"UserName"];
        reset.NewPassword=blockaView.newpassWord0.text;
        [Account ResetPassword:reset success:^(id data) {
            [SVProgressHUD dismiss];
            if ([data[@"status"] isEqualToString:@"T"]) {
                [blockSelf loginVC];
            }else{
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
        }else{
            [UIAlertView showAlertWithTitle:@"您两次输入的新密码不一致，请重新输入"];
        }
    }
}
-(void)loginVC{
    LoginViewController * lvc = [LoginViewController new];
    [self.navigationController pushViewController:lvc animated:NO];
//      [self presentViewController:lvc animated:NO completion:nil];
}
@end
