//
//  DbViewController.m
//  Tour
//
//  Created by Euet on 17/3/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "DbViewController.h"
#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"

@interface DbViewController ()<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray * cardArr1;
    
    NSMutableArray * pankArr;
    NSUserDefaults * data;
    
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    
    
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    NSString * seatstring1;
    NSString * seatstring2;

    
    NSMutableArray * _arr;
    
}
@end

@implementation DbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr=[NSMutableArray new];
    NSArray *  arry2 = @[@"身份证",@"护照",@"其它"];
    cardArr1=[NSMutableArray arrayWithArray:arry2];
    NSArray *  arry3 = @[@"招商银行",@"中国建设银行",@"中国工商银行",@"中国银行",@"交通银行",@"中信银行",@"广发银行",@"中国民生银行",@"兴业银行",@"上海浦东发展银行",@"中国光大银行",@"中国农业银行",@"平安银行",@"深圳发展银行",@"北京银行",@"上海银行",@"华夏银行",@"中国邮政储蓄银行",@"宁波银行"];
    pankArr=[NSMutableArray arrayWithArray:arry3];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
//    _scrollView.userInteractionEnabled=YES;
    [self.view addSubview:effectView];
    
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    
    [pickerView setShowsSelectionIndicator:YES];
   
    effectView.hidden=YES;
    
    UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(0,deviceScreenHeight, self.view.frame.size.width, 40)];
    vv.userInteractionEnabled=YES;
    vv.tag=133;
    vv.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:vv];
    butclear=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butclear.tag=211;
    [butclear addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butclear setTitle:@"取消" forState:UIControlStateNormal];
    [vv addSubview:butclear];
    [butclear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vv).offset(10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    butchange=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butchange.tag=212;
    [butchange addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butchange setTitle:@"确定" forState:UIControlStateNormal];
    [vv addSubview:butchange];
    [butchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vv).offset(-10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    [self.view addSubview:pickerView];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"担保信息";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    //    backbut.tag=666;
    [view addSubview:backbut];

//    _textfield1.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"type"];
     _textfield1.text=@"信用卡担保";
    _textfield1.textColor=[UIColor blackColor];
    _textfield1.font= [UIFont systemFontOfSize:14];
    _textfield1.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _textfield1.clearButtonMode = UITextFieldViewModeWhileEditing;
       //keyboardType 键盘样式
    _textfield1.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _textfield1.returnKeyType = UIReturnKeyNext;
    //设置代理
    _textfield1.delegate = self;
    
    _textfild2.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"banknum"];
    _textfild2.textColor=[UIColor blackColor];
    _textfild2.font= [UIFont systemFontOfSize:14];
    _textfild2.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _textfild2.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _textfild2.keyboardType = UIKeyboardTypeNumberPad;
    //设置return键样式
    _textfild2.returnKeyType = UIReturnKeyNext;
    //设置代理
    _textfild2.delegate = self;
    
    _textfile3.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"yznum"];
    _textfile3.textColor=[UIColor blackColor];
    _textfile3.font= [UIFont systemFontOfSize:14];
    _textfile3.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _textfile3.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _textfile3.keyboardType = UIKeyboardTypeNumberPad;
    //设置return键样式
    _textfile3.returnKeyType = UIReturnKeyNext;
    //设置代理
    _textfile3.delegate = self;
    
    _cardtextf.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"cardnum"];
    _cardtextf.textColor=[UIColor blackColor];
    _cardtextf.font= [UIFont systemFontOfSize:14];
    _cardtextf.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _cardtextf.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _cardtextf.keyboardType = UIKeyboardTypeNumberPad;
    //设置return键样式
    _cardtextf.returnKeyType = UIReturnKeyNext;
    //设置代理
    _cardtextf.delegate = self;
   
    _phonenumtextf.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"phonenum"];
    _phonenumtextf.textColor=[UIColor blackColor];
    _phonenumtextf.font= [UIFont systemFontOfSize:14];
    _phonenumtextf.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _phonenumtextf.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _phonenumtextf.keyboardType = UIKeyboardTypeNumberPad;
    //设置return键样式
    _phonenumtextf.returnKeyType = UIReturnKeyNext;
    //设置代理
    _phonenumtextf.delegate = self;

    _okbut.backgroundColor = [UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [_okbut setTitle:@"提交" forState:UIControlStateNormal];
    [_okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside ];
    [_but1 addTarget:self action:@selector(changedate:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapview1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFview1:)];
    [_view1 addGestureRecognizer:tapview1];
    
    UITapGestureRecognizer *tapview2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFview2:)];
    [_view2 addGestureRecognizer:tapview2];
    
      _butlabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"date"];
    _labelbank.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"bank"];
    _cardlabel.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"DBdata"][@"cardtype"];
        _labelbank.font=[UIFont systemFontOfSize:14];
        _cardlabel.font=[UIFont systemFontOfSize:14];
}

-(void)showGFview2:(UITapGestureRecognizer *)tapview2{
   
    [self loadPickerData:cardArr1];
    
    [self click];
}

-(void)showGFview1:(UITapGestureRecognizer *)tapview1{
   
    [self loadPickerData:pankArr];
  
    [self click];
}

#pragma mark 设置滚动选择框
-(void)picker:(UIButton*)send{
    UIView * vv=[UIView new];
    switch (send.tag) {
        case 211:
            self.tabBarController.tabBar.hidden=YES;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            break;
        case 212:
            //确定
            self.tabBarController.tabBar.hidden=YES;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            if (![_arr[0] isEqualToString:@"身份证"]) {
                _labelbank.text=seatstring;
            }else{
                _cardlabel.text=seatstring;
            }
            break;
        default:
            break;
    }
}
-(void)click{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.hidden=YES;
        effectView.hidden=NO;
        // 设置view弹出来的位置
        pickerView.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3, self.view.frame.size.width, self.view.frame.size.height/3);
        UIView * vv =(UIView*)[self.view viewWithTag:133];
        vv.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3-40, self.view.frame.size.width, 40);
    }];
}
-(void)loadPickerData:(NSMutableArray*)arr{
    [_arr removeAllObjects];
    _arr=[NSMutableArray arrayWithArray:arr];
    [pickerView reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    seatstring = _arr[row];
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
//    label.backgroundColor = [UIColor clearColor];
//    label.text=_arr[row];
//    label.textColor=[UIColor blackColor];
//    label.textAlignment=NSTextAlignmentCenter;
//    return label;
//}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:NO completion:nil ];
}
-(void)okbut:(UIButton*)send{
    
    if (![_textfield1.text isEqualToString:@""]&&![_labelbank.text  isEqualToString:@""]&&![_textfild2.text  isEqualToString:@""]&&![_textfile3.text  isEqualToString:@""]&&![_butlabel.text  isEqualToString:@""]&&![_cardtextf.text  isEqualToString:@""]&&![_cardlabel.text  isEqualToString:@""]&&![_phonenumtextf.text  isEqualToString:@""]){
        NSMutableDictionary * dict = [NSMutableDictionary new];
        
        [dict setValue:_textfield1.text forKey:@"type"];
        [dict setValue:_labelbank.text forKey:@"bank"];
        [dict setValue:_textfild2.text forKey:@"banknum"];
        [dict setValue:_textfile3.text forKey:@"yznum"];
        [dict setValue: _butlabel.text forKey:@"date"];
        [dict setValue:_cardtextf.text forKey:@"cardnum"];
        [dict setValue:_cardlabel.text forKey:@"cardtype"];
        [dict setValue:_phonenumtextf.text forKey:@"phonenum"];

        data=[NSUserDefaults standardUserDefaults];
        [data setObject:dict forKey:@"DBdata"];
        [self dismissViewControllerAnimated:NO completion:nil ];
    }else{
        [UIAlertView showAlertWithTitle1:@"请填写完整的资料" duration:1.5];
    }
 
}
-(void)changedate:(UIButton*)send{
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
        [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
        NSString *str1 =paramas[@"month"];
        NSString *str2=paramas[@"day"];
        if([paramas[@"month"] intValue]<10){
            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
        }
        if([paramas[@"day"] intValue]<10){
            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
        }
        _butlabel.text= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
    }];
    [self presentViewController:ctl animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
