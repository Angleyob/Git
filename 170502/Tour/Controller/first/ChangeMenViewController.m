//
//  ChangeMenViewController.m
//  Tour
//
//  Created by Euet on 16/12/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ChangeMenViewController.h"
#import "CollectionViewCell.h"
#import "changemanCell.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface ChangeMenViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    UITableView *_tableView;
    UICollectionView *_collectionView;
}
/** 搜索栏*/
@property (nonatomic,strong) UISearchBar *searchBar;
/** 搜索栏下的透明层*/
@property (nonatomic,strong) UIView *searchBarBgView;
@property (nonatomic,strong) NSMutableArray * result;
@end


@implementation ChangeMenViewController

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
        NSString *string =_dataArray[i][@"empName"] ;
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
    [self loaddata];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
-(void)loaddata{

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BookEmpQueryRequest * Query = [BookEmpQueryRequest new];
    Query.BookerId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.Count=100;
    Query.Start=0 ;
    Query.DepartMentNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"departMent"];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Account BookEmpQuery:Query success:^(id data) {
         [SVProgressHUD dismiss];
        NSLog(@"****%@",data[@"message"]);
        NSArray * arr =data[@"empList"];
        NSMutableArray * arry = [NSMutableArray arrayWithArray:arr];
        NSMutableArray * arry1=[NSMutableArray new];

        for(int i=0;i<arry.count;i++){
            NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:arry[i]];
//            if ([arry[i][@"empName"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"userName"] ]) {
//                [mutDic2 setValue:@"0" forKey:@"num"];
//            }else{
                [mutDic2 setValue:@"1" forKey:@"num"];
//            }
            [arry1 addObject:mutDic2];
        }
        
        for (int i=0; i<_menarry.count; i++) {
            for(int j=0;j<arry.count;j++){
                NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:arry[j]];
            if ([arry[j][@"empName"] isEqualToString:_menarry[i][@"empName"]]) {
               arry1[j][@"num"]=@"0";
             }
            }

        }
        
        
        NSLog(@"%@",arry1);
        for (NSMutableDictionary * dict in arry1)
        {
            [ _dataArray addObject:dict];
        }
        NSLog(@"%@",_dataArray);
        [_tableView reloadData];
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    if (_type==1) {
        label.text=@"选择乘机人";
    }else if (_type==2){
        label.text=@"选择乘车人";
    }else{
        label.text=@"选择入住人";
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
    UIButton * okbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 40, 20)];
    [okbut setTitle:@"确定" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okbut];

    
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
    if (_type==1) {
        addlabel.text=@"新增乘机人";
    }else if (_type==2){
        addlabel.text=@"新增乘车人";
    }else{
        addlabel.text=@"新增入住人";
    }
    addlabel.font=[UIFont systemFontOfSize:14];
    addlabel.adjustsFontSizeToFitWidth=YES;
    addlabel.textAlignment=NSTextAlignmentCenter;
    addlabel.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [addbut addSubview:addlabel];
    [addlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addbut).offset(145/SCREEN_RATE);
       // make.right.equalTo(addbut).offset(0);
        make.top.equalTo(addbut).offset(6);
        make.height.offset(20);
        make.width.offset(75);
    }];
    UIImageView * addimage = [UIImageView new];
    addimage.image=[UIImage imageNamed:@"add"];
    [addbut addSubview:addimage];
    [addimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addbut).offset(126/SCREEN_RATE);
       // make.right.equalTo(addbut).offset(0);
        make.top.equalTo(addbut).offset(8);
        make.width.offset(14/SCREEN_RATE);
        make.height.offset(14/SCREEN_RATE1);
    }];
    [addbut addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [addbut.layer setBorderColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1].CGColor];
    [addbut.layer setBorderWidth:1];
    [addbut.layer setMasksToBounds:YES];
    [seachview addSubview:addbut];
    [addbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(seachview).offset(10);
        make.right.equalTo(seachview).offset(-10);
        make.top.equalTo(seachview).offset(52);
        make.height.offset(30);
    }];
    [self.view addSubview:seachview];
    [self initSearchBar];
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray1=[NSMutableArray arrayWithArray:_menarry];
//    NSLog(@"%@",_menarry);
    //设置item的一些属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置item的滑动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    UICollectionViewScrollDirectionVertical,
    //    UICollectionViewScrollDirectionHorizonta
    //创建一个collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 159, self.view.frame.size.width,120 ) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //设置复用
    //第一个参数 复用cell类型 第二个参数 cell标示
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIde"];
    //xib复用方法
    //collectionView registerNib:[] forCellWithReuseIdentifier:<#(NSString *)#>
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    //创建UITableView后，要去遵守他的两个协议
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsMultipleSelection = YES;
    [self.view addSubview:_tableView];
    [self changeframe];
 }
//改变_collectionView的frame
-(void)changeframe{
    if(_dataArray1.count==0){
        _tableView.frame=CGRectMake(0, 174, self.view.frame.size.width, self.view.frame.size.height-174);
        _collectionView.frame=CGRectMake(0, 159, self.view.frame.size.width, 0);
    }else if(_dataArray1.count==1||_dataArray1.count==2||_dataArray1.count==3){
        _tableView.frame=CGRectMake(0, 214, self.view.frame.size.width, self.view.frame.size.height-214);
        _collectionView.frame=CGRectMake(0, 159, self.view.frame.size.width, 50);
    }else if(_dataArray1.count==4||_dataArray1.count==5||_dataArray1.count==6){
        _tableView.frame=CGRectMake(0, 254, self.view.frame.size.width, self.view.frame.size.height-254);
        _collectionView.frame=CGRectMake(0, 159, self.view.frame.size.width, 90);
    }else{
        _tableView.frame=CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284);
        _collectionView.frame=CGRectMake(0, 159, self.view.frame.size.width, 120);
    }
}
-(void)okbut:(UIButton*)send{
    if(_block){
        _block(_dataArray1);
    }
//[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)back:(UIButton*)send{
//    NSLog(@"%@",_dataArray1);
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//是否可以编辑tableView的cell
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changemanCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
        
        addMenViewController * addmvc = [addMenViewController new];
       
        addmvc.messageDict=cell.celldict;
        addmvc.type=_type;
        NSLog(@"%@",cell.celldict);
        [self presentViewController:addmvc animated:NO completion:nil];
        
    }];
    modifyAction.backgroundColor = [UIColor colorWithRed:255/255.0 green:206/255.0 blue:47/255.0 alpha:1];
    return @[ modifyAction];
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
    changemanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
    if (!cell) {
        cell= (changemanCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"changemanCell" owner:self options:nil]  lastObject];
    }
    if(_result.count==0){
        cell.celldict=_dataArray[indexPath.row];
        if ([_dataArray[indexPath.row][@"certType"] isEqualToString:@"NI"]) {
            cell.cardlabel.text=@"身份证";
        }else{
            cell.cardlabel.text=@"护照";
        }
        cell.namelabel.text=_dataArray[indexPath.row][@"empName"];
        cell.cardnumber.text=_dataArray[indexPath.row][@"certNo"];
        
        if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
            cell.imv.image=[UIImage imageNamed:@"check_on"];
        }else{
            cell.imv.image=[UIImage imageNamed:@"check_off"];
        }

    }else{
        cell.celldict=_result[indexPath.row];

        if ([_result[indexPath.row][@"certType"] isEqualToString:@"NI"]) {
            cell.cardlabel.text=@"身份证";
        }else{
            cell.cardlabel.text=@"护照";
        }
        cell.namelabel.text=_result[indexPath.row][@"empName"];
        cell.cardnumber.text=_result[indexPath.row][@"certNo"];
        
        if([_result[indexPath.row][@"num"] isEqualToString:@"0"]){
            cell.imv.image=[UIImage imageNamed:@"check_on"];
        }else{
            cell.imv.image=[UIImage imageNamed:@"check_off"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.cardlabel
    /*
     无detailTextLabel
     UITableViewCellStyleDefault,
     文字在两边
     UITableViewCellStyleValue1,
     文字在中间 不显示图片
     UITableViewCellStyleValue2,
     文字上下
     UITableViewCellStyleSubtitle
     */
//    cell.textLabel.text = _dataArray[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:@"001.jpg"];
    //设置cell右面的装饰
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
   // _imageview= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
   // _imageview.image = [UIImage imageNamed:@"check_off"];
   // cell.accessoryView = _imageview;
    //修改cell线 距离边界的大小
    cell.separatorInset = UIEdgeInsetsMake(10, 10, 100, 0);
    return cell;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的方法
    changemanCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//NSMutableDictionary * dict = [NSMutableDictionary new];
//    [dict setValue:cell.namelabel.text forKey:@"empName"];
//    [dict setValue:cell.cardlabel.text forKey:@"certType"];
//    [dict setValue:cell.cardnumber.text forKey:@"certNo"];
    
    
    if (_type!=3) {
        if(_result.count==0){
            if([_dataArray[indexPath.row][@"num"] isEqualToString:@"1"]){
                if(_dataArray1.count<9){
                    _dataArray[indexPath.row][@"num"]=@"0";
                }else{
                    if (_type==1) {
                        [UIAlertView showAlertWithTitle1:@"您最多只能添加9位乘机人" duration:1.5];
                    }else if (_type==2){
                        [UIAlertView showAlertWithTitle1:@"您最多只能添加9位乘车人" duration:1.5];
                    }else{
                    }

                }
            }
            else{
                _dataArray[indexPath.row][@"num"]=@"1";
            }
            if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
                if(_dataArray1.count<9){
                    if(_dataArray1.count>0){
                        _tableView.frame=CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284);
                        [_tableView reloadData];
                        BOOL is =NO ;
                        for (NSDictionary * dict1 in _dataArray1) {
                            if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                                is = YES;
                            }
                        }
                        if(is==NO){
                            [_dataArray1 addObject:_dataArray[indexPath.row]];
                            cell.imv.image=[UIImage imageNamed:@"check_on"];
                            [_tableView reloadData];
                            [self changeframe];
                            NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                            [_collectionView reloadData];
                        }
                    }else{
                        [_dataArray1 addObject:_dataArray[indexPath.row]];
                        cell.imv.image=[UIImage imageNamed:@"check_on"];
                        [_tableView reloadData];
                        [self changeframe];
                        NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                        [_collectionView reloadData];
                    }
                }else{
                    for (NSDictionary * dict1 in _dataArray1) {
                        if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]){
                            cell.imv.image=[UIImage imageNamed:@"check_off"];
                            [_dataArray1 removeObject:dict1];
                            [self changeframe];
                            [_collectionView reloadData];
                        }else{
                        }
                    }
                }
            }else{
                cell.imv.image=[UIImage imageNamed:@"check_off"];
                BOOL ii=NO;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArray1];
                for (NSMutableDictionary * dict1 in arr) {
                    if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                        ii=YES;
                        [_dataArray1 removeObject:dict1];
                        [self changeframe];
                        [_collectionView reloadData];
                    }
                }
            }
            
        }else{
            if([_result[indexPath.row][@"num"] isEqualToString:@"1"]){
                if(_dataArray1.count<9){
                    _result[indexPath.row][@"num"]=@"0";
                }else{
                    if (_type==1) {
                        [UIAlertView showAlertWithTitle1:@"您最多只能添加9位乘机人" duration:1.5];
                    }else if (_type==2){
                        [UIAlertView showAlertWithTitle1:@"您最多只能添加9位乘车人" duration:1.5];
                    }else{
                    }
                }
            }
            else{
                _result[indexPath.row][@"num"]=@"1";
            }
            if([_result[indexPath.row][@"num"] isEqualToString:@"0"]){
                if(_dataArray1.count<9){
                    if(_dataArray1.count>0){
                        _tableView.frame=CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284);
                        [_tableView reloadData];
                        BOOL is =NO ;
                        for (NSDictionary * dict1 in _dataArray1) {
                            if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                                is = YES;
                            }
                        }
                        if(is==NO){
                            [_dataArray1 addObject:_result[indexPath.row]];
                            cell.imv.image=[UIImage imageNamed:@"check_on"];
                            [_tableView reloadData];
                            [self changeframe];
                            NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                            [_collectionView reloadData];
                        }
                    }else{
                        [_dataArray1 addObject:_result[indexPath.row]];
                        cell.imv.image=[UIImage imageNamed:@"check_on"];
                        [_tableView reloadData];
                        [self changeframe];
                        NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                        [_collectionView reloadData];
                    }
                }else{
                    for (NSDictionary * dict1 in _dataArray1) {
                        if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]){
                            cell.imv.image=[UIImage imageNamed:@"check_off"];
                            [_dataArray1 removeObject:dict1];
                            [self changeframe];
                            [_collectionView reloadData];
                        }else{
                        }
                    }
                }
            }else{
                cell.imv.image=[UIImage imageNamed:@"check_off"];
                BOOL ii=NO;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArray1];
                for (NSMutableDictionary * dict1 in arr) {
                    if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                        ii=YES;
                        [_dataArray1 removeObject:dict1];
                        [self changeframe];
                        [_collectionView reloadData];
                    }
                }
            }
            
        }
    }else{
        if(_result.count==0){
            if([_dataArray[indexPath.row][@"num"] isEqualToString:@"1"]){
                if(_dataArray1.count<10){
                    _dataArray[indexPath.row][@"num"]=@"0";
                }else{
                [UIAlertView showAlertWithTitle1:@"您最多只能添加10位入住人" duration:1.5];
                }
            }
            else{
                _dataArray[indexPath.row][@"num"]=@"1";
            }
            if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
                if(_dataArray1.count<10){
                    if(_dataArray1.count>0){
                        _tableView.frame=CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284);
                        [_tableView reloadData];
                        BOOL is =NO ;
                        for (NSDictionary * dict1 in _dataArray1) {
                            if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                                is = YES;
                            }
                        }
                        if(is==NO){
                            [_dataArray1 addObject:_dataArray[indexPath.row]];
                            cell.imv.image=[UIImage imageNamed:@"check_on"];
                            [_tableView reloadData];
                            [self changeframe];
                            NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                            [_collectionView reloadData];
                        }
                    }else{
                        [_dataArray1 addObject:_dataArray[indexPath.row]];
                        cell.imv.image=[UIImage imageNamed:@"check_on"];
                        [_tableView reloadData];
                        [self changeframe];
                        NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                        [_collectionView reloadData];
                    }
                }else{
                    for (NSDictionary * dict1 in _dataArray1) {
                        if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]){
                            cell.imv.image=[UIImage imageNamed:@"check_off"];
                            [_dataArray1 removeObject:dict1];
                            [self changeframe];
                            [_collectionView reloadData];
                        }else{
                        }
                    }
                }
            }else{
                cell.imv.image=[UIImage imageNamed:@"check_off"];
                BOOL ii=NO;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArray1];
                for (NSMutableDictionary * dict1 in arr) {
                    if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                        ii=YES;
                        [_dataArray1 removeObject:dict1];
                        [self changeframe];
                        [_collectionView reloadData];
                    }
                }
            }
            
        }else{
            if([_result[indexPath.row][@"num"] isEqualToString:@"1"]){
                if(_dataArray1.count<10){
                    _result[indexPath.row][@"num"]=@"0";
                }else{
                    [UIAlertView showAlertWithTitle1:@"您最多只能添加10位入住人" duration:1.5];
                }
            }
            else{
                _result[indexPath.row][@"num"]=@"1";
            }
            if([_result[indexPath.row][@"num"] isEqualToString:@"0"]){
                if(_dataArray1.count<10){
                    if(_dataArray1.count>0){
                        _tableView.frame=CGRectMake(0, 284, self.view.frame.size.width, self.view.frame.size.height-284);
                        [_tableView reloadData];
                        BOOL is =NO ;
                        for (NSDictionary * dict1 in _dataArray1) {
                            if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                                is = YES;
                            }
                        }
                        if(is==NO){
                            [_dataArray1 addObject:_result[indexPath.row]];
                            cell.imv.image=[UIImage imageNamed:@"check_on"];
                            [_tableView reloadData];
                            [self changeframe];
                            NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                            [_collectionView reloadData];
                        }
                    }else{
                        [_dataArray1 addObject:_result[indexPath.row]];
                        cell.imv.image=[UIImage imageNamed:@"check_on"];
                        [_tableView reloadData];
                        [self changeframe];
                        NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
                        [_collectionView reloadData];
                    }
                }else{
                    for (NSDictionary * dict1 in _dataArray1) {
                        if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]){
                            cell.imv.image=[UIImage imageNamed:@"check_off"];
                            [_dataArray1 removeObject:dict1];
                            [self changeframe];
                            [_collectionView reloadData];
                        }else{
                        }
                    }
                }
            }else{
                cell.imv.image=[UIImage imageNamed:@"check_off"];
                BOOL ii=NO;
                NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArray1];
                for (NSMutableDictionary * dict1 in arr) {
                    if ([cell.namelabel.text isEqualToString:dict1[@"empName"]]) {
                        ii=YES;
                        [_dataArray1 removeObject:dict1];
                        [self changeframe];
                        [_collectionView reloadData];
                    }
                }
            }
        }
    }
   }
//一组返回item数量
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray1.count;
}
-(CollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.str.text=_dataArray1[indexPath.row][@"empName"];
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [_dataArray1 removeObjectAtIndex:indexPath.row];
    for (int i=0; i<_dataArray.count; i++) {
        if([cell.str.text isEqualToString:_dataArray[i][@"empName"]])
        {
            _dataArray[i][@"num"]=@"1";
            [_tableView reloadData];
        }
    }
    [self changeframe];
    [_collectionView reloadData];
}
//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self newCGSize:CGSizeMake(100, 25)];
}
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{//表示距上，左，下，右边界的距离
    return [self newUIEdgeInsets:UIEdgeInsetsMake(20,20,20,20)];
}
-(void)ma{
    [_collectionView reloadData];
}
- (CGSize)newCGSize:(CGSize)frame
{
    CGSize newFrame;
    newFrame.width=frame.width/SCREEN_RATE;
    newFrame.height=frame.height/SCREEN_RATE;
    return newFrame;
}
- (UIEdgeInsets)newUIEdgeInsets:(UIEdgeInsets)frame
{
    UIEdgeInsets newFrame;
    newFrame.top=frame.top/SCREEN_RATE;
    newFrame.left=frame.left/SCREEN_RATE;
    newFrame.bottom=frame.bottom/SCREEN_RATE;
    newFrame.right=frame.right/SCREEN_RATE;
    return newFrame;
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE;
    return newFrame;
}
-(void)click:(UIButton*)send{
    addMenViewController * add = [addMenViewController new];
    add.type=_type;
//    [self.navigationController  pushViewController:add animated:YES];
    [self presentViewController:add animated:nil completion:nil];
}
-(void)sendMessage:(menBlcok)block{
    _block=block;
}

@end


