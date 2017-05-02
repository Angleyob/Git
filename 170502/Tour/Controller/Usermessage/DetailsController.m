//
//  DetailsController.m
//  UserInterface
//
//  Created by apple on 2017/2/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailsController.h"
#import "MainViewController.h"
#import "DetailsCell.h"
#import "usercardNumVC.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface DetailsController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray * cardArr;
    
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    
    
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
    NSMutableArray * _arr;


}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * array;

@end

@implementation DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"个人信息";
     NSArray *  arry2 = @[@"身份证",@"护照",@"其它"];
    cardArr=[NSMutableArray arrayWithArray:arry2];
       UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"个人信息";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 440, deviceScreenWidth-80 , 60)];
    label1.text=@"如需修改相应的个人信息,请联系你的有关上级部门进行处理";
    label1.numberOfLines=0;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self.view addSubview:label1];
    
    
   

    [self initWith];//初始化tableView
}
-(void)initWith
{
    _dataArray = [NSMutableArray array];
    _dataArray =  [NSMutableArray arrayWithObjects:@"",@"手机号码",@"系邮箱",@"就职公司",@"就职部门",@"",@"证件号码",nil];
    NSMutableDictionary * d  =[NSMutableDictionary new];
    
    d=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"];
      NSLog(@"%@",d);
    _array = [NSMutableArray array];
    NSString * certType;
    
    if([d[@"empList"][0][@"certType"] isEqualToString:@"NI"]){
        certType=@"身份证";
    }else if([d[@"empList"][0][@"certType"] isEqualToString:@"ID"]){
        certType=@"护照";
    }else{
        certType=@"其它";
    }
    seatstring=certType;
    NSArray * a = @[d[@"userName"],d[@"empList"][0][@"mobile"],d[@"empList"][0][@"email"],d[@"company"][@"name"],d[@"empList"][0][@"costCenterName"],seatstring,d[@"empList"][0][@"certNo"]];
    _array = [NSMutableArray arrayWithArray:a];
    NSLog(@"%@",d[@"empList"][0][@"certNo"]);
    NSLog(@"%@",_array);
    [_tableView reloadData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, 365) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces=NO;
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
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
}
-(void)leftUIButton
{
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonItem.frame = CGRectMake(0, 0, 20, 20);
    buttonItem.backgroundColor=[UIColor redColor];
    [buttonItem setTitle:@"<"forState:UIControlStateNormal];
    [buttonItem addTarget:self action:@selector(buttonClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];
    self.navigationItem.leftBarButtonItem = customItem;
}
-(void)buttonClick
{
    NSLog(@"ds");
//    MainViewController*sVC = [[MainViewController alloc] init];
//    [self.navigationController pushViewController:sVC animated:YES];

}
#pragma mark TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    DetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.label.text = _dataArray[indexPath.row];
    cell.textField.text = _array[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == 0){
        UILabel * nameLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 18, 80, 18)]];
        nameLabel.text=@"姓名";
        nameLabel.font=[UIFont systemFontOfSize:14];
        [cell addSubview:nameLabel];
        cell.textField.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        cell.textField.userInteractionEnabled=NO;
        cell.textField.frame=[framsizeclass newSuitFrame:CGRectMake(120, 18,375-167, 18)];
        cell.textField.font=[UIFont systemFontOfSize:14];
    }
    else if (indexPath.row==5)
    {
        UILabel *gayLable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 15)];
        gayLable.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [cell addSubview:gayLable];
        UILabel * DocumentTypeLable=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 30, 100, 40)]];
        DocumentTypeLable.text=@"证件类型";
        DocumentTypeLable.font=[UIFont systemFontOfSize:14];
        [cell addSubview:DocumentTypeLable];
        cell.textField.text=seatstring;
        cell.textField.textColor=[UIColor blackColor];
         cell.textField.frame=[framsizeclass newSuitFrame:CGRectMake(120, 30,375-167, 40)];
          cell.textField.font=[UIFont systemFontOfSize:14];
        cell.textField.userInteractionEnabled=NO;

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = [framsizeclass newSuitFrame:CGRectMake(340, 30, 20, 30)];
        //button.backgroundColor = [UIColor redColor];
        [button setTitle:@">"forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick)forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }
    else if (indexPath.row==6)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(340/SCREEN_RATE, 10, 30, 30);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@">"forState:UIControlStateNormal];
        [cell addSubview:button];
        cell.textField.userInteractionEnabled=NO;
        cell.textField.textColor=[UIColor blackColor];
    }else{
        cell.textField.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        cell.textField.userInteractionEnabled=NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row：%ld",(long)indexPath.row);
    DetailsCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==5) {
        [self loadPickerData:cardArr];
        [self click];
    }else if (indexPath.row==6){
        usercardNumVC * xvc =[usercardNumVC new];
        xvc.num=cell.textField.text;
        xvc.numtype=seatstring;
        xvc.hidesBottomBarWhenPushed = YES;
        xvc.navigationController.navigationBar.hidden=YES;
        [self.navigationController  pushViewController:xvc animated:YES];
//        [self presentViewController:xvc animated:NO completion:nil];
    }else{
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
    {
        return 50;
    }
    else if(indexPath.row==5)
    {
        return 65;
    }
    return 50;
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
          
            [_tableView reloadData];
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

//// 主动选中第component列的第row行
//- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
//    
//}
-(void)loadPickerData:(NSMutableArray*)arr{
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

//    [pickerView selectRow:0 inComponent:0 animated:NO];
  
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    seatstring = _arr[row];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    effectView.hidden=YES;
    pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
     UIView * vv=[UIView new];
    vv =(UIView*)[self.view viewWithTag:133];
    vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
}
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
