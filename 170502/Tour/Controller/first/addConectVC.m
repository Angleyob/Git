//
//  addConectVC.m
//  Tour
//
//  Created by Euet on 17/2/22.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "addConectVC.h"

@interface addConectVC ()<UITextFieldDelegate>
{
    UITextField * name;
    
    UITextField * phoneNum;

}
@end

@implementation addConectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * tabview= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    tabview.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:tabview];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 120 , 30)];
    if (_messdict.count==0) {
        label.text=@"选择联系人";
    }else{
        label.text=@"编辑联系人";
    }
    label.textColor=[UIColor whiteColor];
    [tabview addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    backbut.tag=666;
    [tabview addSubview:backbut];

    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
   
    UIView * view = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 94, 375, 88)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 32, 18)]];
    label1.text=@"姓名";
    label1.adjustsFontSizeToFitWidth=YES;
    [view addSubview:label1];
    
    name =[[UITextField alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(126, 11, 120, 18)]];
    if (_messdict.count!=0) {
        name.text=_messdict[@"contactName"];
    }
    name.textColor=[UIColor blackColor];
    name.font= [UIFont systemFontOfSize:14];
    name.tintColor = [UIColor blackColor];
    name.placeholder=@"请输入姓名";
    //设置删除文字按钮
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
    //_PassWord.leftView = Lview1;
    ////设置左边视图显示模式
    name.tag =2;
    //keyboardType 键盘样式
    name.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    name.returnKeyType = UIReturnKeyNext;
    //设置代理
    name.delegate = self;
    [view addSubview:name];
    
    UIView * lineview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 43, 355, 1)]];
    lineview.backgroundColor=[UIColor whiteColor];
    [view addSubview:lineview];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 55, 64, 18)]];
    label2.text=@"手机号码";
    label2.adjustsFontSizeToFitWidth=YES;
    [view addSubview:label2];
    

    phoneNum =[[UITextField alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(126, 55, 120, 18)]];
    if (_messdict.count!=0) {
        phoneNum.text=_messdict[@"mobile"];
    }
    phoneNum.textColor=[UIColor blackColor];
    phoneNum.font= [UIFont systemFontOfSize:14];
    phoneNum.tintColor = [UIColor blackColor];
    phoneNum.placeholder=@"请输入手机号码";
    //设置删除文字按钮
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
    //_PassWord.leftView = Lview1;
    ////设置左边视图显示模式
    phoneNum.tag =2;
    //keyboardType 键盘样式
    phoneNum.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    phoneNum.returnKeyType = UIReturnKeyNext;
    //设置代理
    phoneNum.delegate = self;
    [view addSubview:phoneNum];

    UIButton * button  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 213, 335, 44)]];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [self.view addSubview:button];
}
-(void)onclick:(UIButton*)send{
//    NSString * str  =[phoneNum.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ([phoneNumclass isMobileNumber:phoneNum.text]==NO) {
        [UIAlertView showAlertWithTitle:@"请输入正确的手机号码！"];
    }else{
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        ContactModifyRequest * cmo = [ContactModifyRequest new];
        cmo.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        cmo.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        if (_messdict.count!=0) {
            cmo.ContactId=_messdict[@"contactId"];
        }else{
            cmo.ContactId=@"";
        }
        cmo.ContactName=name.text;
        cmo.EmpId=@"";
        cmo.EnglishName=@"";
        cmo.IDCardNo=@"";
        cmo.Mobile=phoneNum.text;
        if (_messdict.count==0) {
            cmo.ModifyType=@"I";
        }else{
            cmo.ModifyType=@"U";
        }
        cmo.Passport=@"";
        cmo.Relation=@"";
        [Account ContactModify:cmo success:^(id data) {
            [SVProgressHUD dismiss];
                   NSLog(@"%@",data);
            if([data[@"status"] isEqualToString:@"T"]){
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
                [self dismissViewControllerAnimated:NO completion:nil];
            }else{
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
      }
    }
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
