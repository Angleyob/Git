//
//  addMenViewController.m
//  Tour
//
//  Created by Euet on 16/12/21.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "addMenViewController.h"

@interface addMenViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
 
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
//    NSMutableArray * countryArr;
    NSMutableArray * cardArr;

    NSMutableArray * _arr;
}
@property (weak, nonatomic) IBOutlet UIButton *deleateBut;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UITextField *countryText;
@property (weak, nonatomic) IBOutlet UIButton *countryBut;
@property (weak, nonatomic) IBOutlet UILabel *carstyleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cardBut;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *cardnumberText;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;

@end

@implementation addMenViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
 -(void)viewWillLayoutSubviews{
     self.view.backgroundColor=[UIColor whiteColor];
 }
- (void)viewDidLoad {
    [super viewDidLoad];
    

//    NSArray *  arry1 = @[@"中国",@"中国台湾",@"中国香港",@"美国",@"日本",@"意大利"];
//    countryArr=[NSMutableArray arrayWithArray:arry1];
    
    NSArray *  arry2 = @[@"身份证",@"护照",@"其它"];
    cardArr=[NSMutableArray arrayWithArray:arry2];
    
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    [self.view addSubview:effectView];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenHeight/3+60)];
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

    
    self.view.backgroundColor =[UIColor yellowColor];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    if(_messageDict.count==0){
        switch (_type) {
            case 1:
                label.text=@"新增乘机人";
                break;
            case 2:
                label.text=@"新增乘车人";
                break;
            case 3:
                label.text=@"新增入住人";
                break;
            case 4:
                label.text=@"新增旅客";
                break;
            default:
                break;
        }
    }else{
        switch (_type) {
            case 1:
                label.text=@"编辑乘机人";
                break;
            case 2:
                label.text=@"编辑乘车人";
                break;
            case 3:
                label.text=@"编辑入住人";
                break;
            case 4:
                label.text=@"编辑旅客";
                break;
            default:
                break;
        }

    }
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
    self.view.backgroundColor=  [UIColor grayColor];
    [self initviewUI];
    [self loaddata];
}
-(void)loaddata{
    _countryArr=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    NationQuery * nation = [NationQuery new];
    nation.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    nation.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic NationQueryRequest:nation success:^(id data) {
          [SVProgressHUD dismiss];
        
        if ([data[@"status"] isEqualToString:@"T"]) {
            
            for (NSMutableDictionary *dict in data[@"data"]) {
                NSMutableDictionary * dict1  = [NSMutableDictionary dictionaryWithDictionary:dict];
                NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIGKLMNOPQRSTUVWXYZ"];
                NSString *trimmedString = [dict1[@"name"] stringByTrimmingCharactersInSet:set];
                dict1[@"name"] =trimmedString;
                [_countryArr addObject:dict1];
            }
            
            if (_messageDict.count!=0) {
                        for (NSMutableDictionary * dict in _countryArr) {
                            if ([_messageDict[@"national"] isEqualToString:dict[@"id"]]) {
                                  _countryText.text=dict[@"name"];
                                break;
                            }else{
                            _countryText.text=@"";
                            }
                        }
            }
           
//            countryArr=[NSMutableArray arrayWithArray:data[@"data"]];
            
//            NSLog(@"%@",data);
        }else{
          
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)initviewUI{
    if(_messageDict.count==0){
        _nameText.placeholder=@"请输入姓名";
    }else{
        _nameText.text=_messageDict[@"empName"];
    }
    _nameText.keyboardType = UIKeyboardTypeDefault;
    _nameText.tintColor = [UIColor blackColor];
    _nameText.borderStyle=UITextBorderStyleNone;

    if(_messageDict.count==0){
        _numberText.placeholder=@"请输入手机号码";
    }else{
        _numberText.text=_messageDict[@"mobile"];
    }

    _numberText.keyboardType = UIKeyboardTypeNumberPad;
    _numberText.tintColor = [UIColor blackColor];
    _numberText.borderStyle=UITextBorderStyleNone;

    if(_messageDict.count==0){
        _countryText.text=@"";
    }else{
        
//        NSLog(@"%@",_messageDict[@"national"]);
        
//        for (NSMutableDictionary * dict in countryArr) {
//            if ([_messageDict[@"national"] isEqualToString:dict[@"name"]]) {
//                  _countryText.text=dict[@"name"];
//                break;
//            }else{
////              _countryText.text=@"";  
//            }
//        }

        _countryText.text=_messageDict[@"national"];
      
    }
     _countryText.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    _countryText.userInteractionEnabled=NO;
    _countryText.borderStyle=UITextBorderStyleNone;
    
    [_countryBut setBackgroundImage:[UIImage imageNamed:@"chevron"] forState:UIControlStateNormal];
    [_countryBut addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
     _countryBut.tag=778;
     [_cardBut addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    _cardBut.tag=777;

    if(_messageDict.count==0){
        _card.text=@"身份证";
    }else{
        if([_messageDict[@"certType"] isEqualToString:@"NI"]){
             _card.text=@"身份证";
        }else if ([_messageDict[@"certType"] isEqualToString:@"ID"]){
            _card.text=@"护照";
        }else{
            _card.text=@"其它";
        }
    }

    _card.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    
    UITapGestureRecognizer *tapadd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showadd:)];
    [_card addGestureRecognizer:tapadd];
    _card.userInteractionEnabled=YES;

    if(_messageDict.count==0){
        _cardnumberText.placeholder =@"请输入证件号码";
    }else{
        _cardnumberText.text=_messageDict[@"certNo"];
    }
    
    _cardnumberText.keyboardType = UIKeyboardTypeNumberPad;
    _cardnumberText.tintColor = [UIColor blackColor];
    _cardnumberText.borderStyle=UITextBorderStyleNone;

       _buttonSend.backgroundColor= [UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [_buttonSend setTitle:@"确定" forState:UIControlStateNormal];
    [_buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonSend addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleateBut.backgroundColor= [UIColor redColor];
    [_deleateBut setTitle:@"删除" forState:UIControlStateNormal];
    [_deleateBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleateBut addTarget:self action:@selector(deleclick:) forControlEvents:UIControlEventTouchUpInside];
    
    if(_messageDict.count==0){
        _deleateBut.hidden=YES;
    }else{
        _deleateBut.hidden=NO;
    }
}
-(void)deleclick:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BookEmpModifyRequest * bem = [BookEmpModifyRequest new];
    bem.Address=@"";
    bem.Birthday=@"";
    bem.Duty=@"";
    bem.Email=@"";
    bem.EmpId=@"";
    bem.EmpNo=_messageDict[@"empNo"];
    bem.EmpRank=@"";
    bem.EmpStatus=@"";
    bem.EngName=@"";
    bem.IfBookOut=@"";
    bem.IsBooker=@"";
    bem.IsChecker=@"";
    bem.Level=@"";
    bem.Passport=@"";
    bem.PlaceOfBirth=@"";
    bem.PlaceOfIssue=@"";
    bem.PostCode=@"";
    bem.Role=@"";
    bem.Sex=@"";
    bem.Telphone=@"";
    bem.Validity=@"";
    if ([_card.text isEqualToString:@"身份证"]) {
        bem.CardType=@"NI";
    }else if ([_card.text isEqualToString:@"护照"]){
        bem.CardType=@"ID";
    }else{
        bem.CardType=@"";
    }
    bem.CardId=_cardnumberText.text;
    bem.Mobile=_numberText.text;
    bem.Nation=_countryText.text;
    bem.EmpName=_nameText.text;
    bem.ModifyType=@"D";
    bem.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    bem.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    bem.DeptNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"departMent"];
    [Account BookEmpModify:bem success:^(id data) {
        //    NSLog(@"%@",data[@"message"]);
        [SVProgressHUD dismiss];
        if([data[@"message"] isEqualToString:@"删除成功"]){
            [self dismissViewControllerAnimated:NO completion:nil];
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)okclick:(UIButton*)send{
    if ([phoneNumclass isMobileNumber:_numberText.text]==NO) {
        [UIAlertView showAlertWithTitle1:@"请填写正确的手机号" duration:1.2];
    }else{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BookEmpModifyRequest * bem = [BookEmpModifyRequest new];
     bem.Address=@"";
     bem.Birthday=@"";
     bem.Duty=@"";
     bem.Email=@"";
     bem.EmpId=@"";
    if(_messageDict.count==0){
        bem.EmpNo=@"";
    }else{
        bem.EmpNo=_messageDict[@"empNo"];
    }
     bem.EmpRank=@"";
     bem.EmpStatus=@"";
     bem.EngName=@"";
     bem.IfBookOut=@"";
     bem.IsBooker=@"";
     bem.IsChecker=@"";
     bem.Level=@"";
     bem.Passport=@"";
     bem.PlaceOfBirth=@"";
     bem.PlaceOfIssue=@"";
     bem.PostCode=@"";
     bem.Role=@"";
     bem.Sex=@"";
     bem.Telphone=@"";
     bem.Validity=@"";
    if ([_card.text isEqualToString:@"身份证"]) {
        bem.CardType=@"NI";
    }else if ([_card.text isEqualToString:@"护照"]){
        bem.CardType=@"ID";
    }else{
        bem.CardType=@"";
    }
    bem.CardId=_cardnumberText.text;
    bem.Mobile=_numberText.text;
        
        for (NSMutableDictionary * dict in _countryArr) {
            if ([_countryText.text isEqualToString:dict[@"name"]]) {
                bem.Nation=dict[@"id"];
                break;
            }
        }
//    bem.Nation=_countryText.text;
    bem.EmpName=_nameText.text;
    if(_messageDict.count==0){
        bem.ModifyType=@"I";
    }else{
        bem.ModifyType=@"U";
    }
    bem.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    bem.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    bem.DeptNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"departMent"];
    [Account BookEmpModify:bem success:^(id data) {
   // NSLog(@"%@",data[@"message"]);
         [SVProgressHUD dismiss];
        if([data[@"status"] isEqualToString:@"T"]){
            [self dismissViewControllerAnimated:NO completion:nil];
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    }
//[self.navigationController popViewControllerAnimated:YES];
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
            
            if ([_arr[0] isKindOfClass:[NSDictionary class]]) {
                _countryText.text=seatstring;
            }else{
                _card.text=seatstring;
            }
//            BOOL isbool = [_arr containsObject:@"中国"];
//            if(isbool==1){
//                _countryText.text=seatstring;
//            }else{
//                _card.text=seatstring;
//            }
            pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
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
    
    if ([_arr[row] isKindOfClass:[NSDictionary class]]) {
        if(_arr[row][@"name"]!=nil){
            return _arr[row][@"name"];
        }else{
             return nil;
        }
    }else{
        return _arr[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    if ([_arr[rowOne] isKindOfClass:[NSDictionary class]]) {
        seatstring = _arr[row][@"name"];
    }else{
        seatstring = _arr[row];
    }
}
-(void)showadd:(UITapGestureRecognizer *)tapadd{
    [self loadPickerData:cardArr];
    [self click];
}

-(void)changeType:(UIButton*)but{
    if(but.tag==778){
        [self loadPickerData:_countryArr];
        [self click];
    }else{
        [self loadPickerData:cardArr];
        [self click];
    }
    
}
-(void)back:(UIButton*)send{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
