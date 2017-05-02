//
//  contactVC.m
//  Tour
//
//  Created by Euet on 17/1/3.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "contactVC.h"
#import "contactmenCell.h"
#import "addConectVC.h"
#import "addConectVC.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
@interface contactVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CNContactPickerDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    //系统联系人
    NSString * contactName;
    NSString * phoneNumber;
    BOOL back;
}
/** 搜索栏*/
@property (nonatomic,strong) UISearchBar *searchBar;
/** 搜索栏下的透明层*/
@property (nonatomic,strong) UIView *searchBarBgView;
@property (nonatomic,strong) NSMutableArray * result;


@end
@implementation contactVC

-(NSMutableArray *)result{
    if (!_result) {
        self.result = [NSMutableArray array];
    }
    return _result;
}

-(void)initSearchBar{
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            cancel.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            cancel.titleLabel.font=[UIFont systemFontOfSize:14];
            cancel.titleLabel.textAlignment=NSTextAlignmentCenter;
            cancel.clipsToBounds=YES;
            //圆角
            cancel.layer.cornerRadius = 10.0;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"我的");
}
/**
 *  搜框中输入关键字的事件响应
 *  @param searchBar  UISearchBar
 *  @param searchText 输入的关键字
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
    self.result = nil;
    for (int i = 0; i < _dataArray.count; i++) {
        ;
        NSString *string =_dataArray[i][@"contactName"] ;
        if (string.length >= searchText.length) {
            
            if([string rangeOfString:searchText].location !=NSNotFound)//_roaldSearchText
            {
                [self.result addObject:_dataArray[i]];
                //                NSLog(@"yes");
            }
            else
            {
                // NSLog(@"no");
            }
        }
    }
    //NSLog(@"%@",self.result);
    
    [_tableView reloadData];
}
/**
 *  取消的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消吗");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
/**
 *  键盘上搜索事件的响应
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (back==YES) {
        [self back1];
    }
    [self loaddata];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
-(void)loaddata{
    _dataArray=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    ContactQueryRequest * con  = [ContactQueryRequest new];
    con.Count=100;
    con.Start=0;
    self.view.userInteractionEnabled=NO;
    con.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    con.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Account ContactQuery:con success:^(id data) {
         [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;

        NSLog(@"%@",data);
        NSArray * arr =data[@"contactList"];
        NSMutableArray * arry = [NSMutableArray arrayWithArray:arr];
        NSMutableArray * arry1=[NSMutableArray new];
        for(int i=0;i<arry.count;i++){
            NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:arry[i]];
            [mutDic2 setValue:@"1" forKey:@"num"];
            [arry1 addObject:mutDic2];
        }
        for (NSMutableDictionary * dict in arry1)
        {
            [ _dataArray addObject:dict];
        }
        NSLog(@"%@",_dataArray);
        [_tableView reloadData];
       
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;

          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 120 , 30)];
    if([_metype isEqualToString:@"hid"]){
        label.text=@"常用联系人";
    }else{
        label.text=@"选择联系人";
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
   
    UIButton * okbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 60, 20)];
    okbut.titleLabel.font=[UIFont systemFontOfSize:15];
    [okbut setTitle:@"通讯录" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okbut];
    
    if([_metype isEqualToString:@"hid"]){
        okbut.hidden=YES;
    }

    UIView * seachview= [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, 90)];
    seachview.backgroundColor=[UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [seachview addSubview:_searchBar];
    
    UIButton * addbut = [UIButton new];
    
    UILabel * addlabel = [UILabel new];
    addlabel.text=@"新增联系人";
    addlabel.font=[UIFont systemFontOfSize:14];
    addlabel.adjustsFontSizeToFitWidth=YES;
    addlabel.textAlignment=NSTextAlignmentCenter;
    addlabel.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [addbut addSubview:addlabel];
    [addlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addbut).offset(145/SCREEN_RATE);
        // make.right.equalTo(addbut).offset(0);
        make.top.equalTo(addbut).offset(10);
        make.height.offset(20);
        make.width.offset(75);
    }];
    UIImageView * addimage = [UIImageView new];
    addimage.image=[UIImage imageNamed:@"add"];
    [addbut addSubview:addimage];
    [addimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addbut).offset(126/SCREEN_RATE);
        // make.right.equalTo(addbut).offset(0);
        make.top.equalTo(addbut).offset(12);
        make.width.offset(14/SCREEN_RATE);
        make.height.offset(14/SCREEN_RATE1);
    }];
    [addbut addTarget:self action:@selector(addclick:) forControlEvents:UIControlEventTouchUpInside];
    [addbut.layer setBorderColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1].CGColor];
    [addbut.layer setBorderWidth:1];
    [addbut.layer setMasksToBounds:YES];
    //剪切
    addbut.clipsToBounds=YES;
    //圆角
    addbut.layer.cornerRadius = 10.0;
    [seachview addSubview:addbut];
    [addbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(seachview).offset(10);
        make.right.equalTo(seachview).offset(-10);
        make.top.equalTo(seachview).offset(52);
        make.height.offset(38);
    }];
    [self.view addSubview:seachview];
    //创建UITableView后，要去遵守他的两个协议
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 162, self.view.frame.size.width, self.view.frame.size.height-104) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsMultipleSelection = YES;
    [self.view addSubview:_tableView];
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//设置行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_result.count==0){
        return _dataArray.count;
    }else{
        return self.result.count;
    }

}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    contactmenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
    if (!cell) {
        cell= (contactmenCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"contactmenCell" owner:self options:nil]  lastObject];
    }
    if([_metype isEqualToString:@"hid"]){
        cell.imv.hidden=YES;
    }
    cell.celldict=_dataArray[indexPath.row];
    if(_result.count==0){
        if (_dataArray.count!=0) {
            cell.namelabel.text=_dataArray[indexPath.row][@"contactName"];
            cell.numberLabel.text=_dataArray[indexPath.row][@"mobile"];
            if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
                cell.imv.image=[UIImage imageNamed:@"check_on"];
            }else{
                cell.imv.image=[UIImage imageNamed:@"check_off"];
            }

        }
            }else{
        cell.namelabel.text=_result[indexPath.row][@"contactName"];
        cell.numberLabel.text=_result[indexPath.row][@"mobile"];
        if([_result[indexPath.row][@"num"] isEqualToString:@"0"]){
            cell.imv.image=[UIImage imageNamed:@"check_on"];
        }else{
            cell.imv.image=[UIImage imageNamed:@"check_off"];
        }
    }
       return cell;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//获取cell的方法
    contactmenCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(_result.count==0){
        if([_dataArray[indexPath.row][@"num"] isEqualToString:@"1"]){
            
            for (int i=0;i<_dataArray.count;i++) {
                _dataArray[i][@"num"]=@"1";
            }
            _dataArray[indexPath.row][@"num"]=@"0";
        }
        else{
            _dataArray[indexPath.row][@"num"]=@"1";
        }

    }else{
        if([_result[indexPath.row][@"num"] isEqualToString:@"1"]){
            
            for (int i=0;i<_result.count;i++) {
                _result[i][@"num"]=@"1";
            }
            _result[indexPath.row][@"num"]=@"0";
        }
        else{
            _result[indexPath.row][@"num"]=@"1";
        }
    }
       [_tableView reloadData];
   if(![_metype isEqualToString:@"hid"]){
    //延迟1秒执行
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
   }
}
-(void)delayMethod{
    
    NSMutableArray * arr = [NSMutableArray new ];
    if(_result.count==0){
    for (NSMutableDictionary * dict in _dataArray) {
        if([dict[@"num"] isEqualToString:@"0"]){
            NSMutableDictionary * dict1 = [NSMutableDictionary new ];
            [dict1 setValue:dict[@"contactName"] forKey:@"name"] ;
            [dict1 setValue:dict[@"mobile"] forKey:@"mobile"] ;
            [arr addObject:dict1];
            if(_block){
                _block(arr);
            }
        }
    }
        if(arr.count==0){
            [UIAlertView showAlertWithTitle1:@"请选择联系人" duration:1.1];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
}else{
        for (NSMutableDictionary * dict in _result) {
            if([dict[@"num"] isEqualToString:@"0"]){
                NSMutableDictionary * dict1 = [NSMutableDictionary new ];
                [dict1 setValue:dict[@"contactName"] forKey:@"name"] ;
                [dict1 setValue:dict[@"mobile"] forKey:@"mobile"] ;
                [arr addObject:dict1];
                if(_block){
                    _block(arr);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
      if(arr.count==0){
        [UIAlertView showAlertWithTitle1:@"请选择联系人" duration:1.1];
      }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        
      }
    }
}

-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    contactmenCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
       addConectVC * addmvc = [addConectVC new];
        addmvc.messdict=cell.celldict;
        [self presentViewController:addmvc animated:NO completion:nil];
    }];
    modifyAction.backgroundColor = [UIColor colorWithRed:255/255.0 green:206/255.0 blue:47/255.0 alpha:1];
    return @[ modifyAction];
}

#pragma mark -调用手机通讯录
-(void)okbut:(UIButton*)send{
    // 1.创建选择联系人的控制器
    CNContactPickerViewController *contactViewC = [[CNContactPickerViewController alloc] init];
    // 2.设置代理
    contactViewC.delegate = self;
    // 3.弹出控制器
    [self presentViewController:contactViewC animated:YES completion:nil];
}
// 1.点击取消按钮调用的方法
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    NSLog(@"取消选择联系人");
}
// 2.当选中某一个联系人时会执行该方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    // 1.获取联系人的姓名
    NSString *lastname = contact.familyName;
    NSString *firstname = contact.givenName;
    NSLog(@"%@ %@", lastname, firstname);
    contactName = [NSString stringWithFormat:@"%@%@",lastname, firstname];
    // 2.获取联系人的电话号码(此处获取的是该联系人的第一个号码,也可以遍历所有的号码)
    NSArray *phoneNums = contact.phoneNumbers;
    CNLabeledValue *labeledValue = phoneNums[0];
    CNPhoneNumber *phoneNumer = labeledValue.value;
    phoneNumber = [phoneNumer.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNumber);
    back=YES;
}
#pragma mark -添加联系人
-(void)addclick:(UIButton*)send{
    addConectVC * addvc = [addConectVC new];
     [self presentViewController:addvc animated:NO completion:nil];
}
#pragma mark -返回
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -调用手机通讯录的返回
//--（存在bug会经过选择联系人的界面，有待优化）
-(void)back1{
    back=NO;
    NSMutableArray * arr = [NSMutableArray new ];
    NSMutableDictionary * dict1 = [NSMutableDictionary new ];
    [dict1 setValue:contactName forKey:@"name"] ;
    [dict1 setValue:phoneNumber forKey:@"mobile"] ;
    [arr addObject:dict1];
    if(_block){
        _block(arr);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendMessage:(contactBlcok)block{
    _block=block;
}
@end
