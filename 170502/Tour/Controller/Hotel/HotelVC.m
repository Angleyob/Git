//
//  HotelVC.m
//  Tour
//
//  Created by Euet on 17/1/17.
//  Copyright © 2017年 lhy. All rights reserved.
#import "HotelVC.h"
#import "hotelCell.h"
#import "hotelmssModel.h"
#import "MJRefresh.h"
#import "hotelView.h"
#import "CollectionViewCellHtole.h"
#import "sxtablecell.h"
#import "MapViewController.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
@interface HotelVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIView * footview;
    //底部视图控件
    UIImageView * priceim;
    UILabel * pricelabel;
    UIImageView * timeiamge;
    UILabel * timelabel;
    UIImageView * sxiamge;
    UILabel * sxlabel;
    
    //星级筛选视图
    UIView * PSSXview;
    //更多筛选视图
    //蒙版视图
    UIView * _SXconnetview;

    UIView * SXview;
    UITableView * _tableView3;
    NSMutableArray * _sxdata;
    
    NSMutableArray * _GJdata;
    NSMutableArray * _JJdata;
    NSMutableArray * _SEdata;

    //更多筛选的条件数组
    NSMutableArray * otherGJarr;
    NSMutableArray * otherSEarr;


    //滚动选择框
    NSArray*_arr;
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
 // 排序
    NSMutableArray * recomarr;
 // 升
    NSMutableArray * pricearr;
    NSMutableArray * stararr;
 // 降
    NSMutableArray * pricearr1;
    NSMutableArray * stararr1;
}

@property (nonatomic,copy)hotelView*aView3;

@property (nonatomic, strong) NSMutableArray *colldataArr;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *colldataArr1;

@property (nonatomic, strong) UICollectionView *collectionView1;


/** 搜索栏*/
@property (nonatomic,strong) UISearchBar *searchBar;
/** 搜索栏下的透明层*/
@property (nonatomic,strong) UIView *searchBarBgView;
@property (nonatomic,assign) int page;
@property (nonatomic,copy) NSMutableArray * dataArray;
@property (nonatomic,copy) NSMutableArray * dataArray1;

@property (nonatomic,strong)  UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * result;
-(void)initSearchBar;//创建搜索
@end
@implementation HotelVC

-(NSMutableArray *)result{
    if (!_result) {
        self.result = [NSMutableArray array];
    }
    return _result;
}
-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入搜索关键字";
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    NSLog(@"heahtdyfgh");
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            cancel.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            cancel.titleLabel.font=[UIFont systemFontOfSize:14];
            cancel.titleLabel.textAlignment=NSTextAlignmentCenter;
            cancel.clipsToBounds=YES;
            //圆角
            cancel.layer.cornerRadius = 5.0;
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
    hotelmssModel * model =[[hotelmssModel alloc] init];
    for (int i = 0; i < _dataArray.count; i++) {
        model=_dataArray[i];
        NSString *string =model.hotelName ;
        if (string.length >= searchText.length) {
//            NSString *str = [model.hotelName substringWithRange:NSMakeRange(0, searchText.length)];
//            
//            if ([str isEqualToString:searchText]) {
//                [self.result addObject:_dataArray[i]];
//            }
            
            if([string rangeOfString:searchText].location !=NSNotFound)//_roaldSearchText
            {
                [self.result addObject:_dataArray[i]];
//                NSLog(@"yes");
            }
            else
            {
//                NSLog(@"no");
            }
        }
    }
//    NSLog(@"%@",self.result);
    [_tableView reloadData];
}
/**
 *  取消的响应事件
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
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated{
     [SVProgressHUD dismiss];
    self.tabBarController.tabBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    seatstring=@"推荐度";
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=[NSString stringWithFormat:@"酒店-%@",_outcity];
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    UIButton * refreshbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 40, 20)];
    [refreshbut setTitle:@"地图" forState:UIControlStateNormal];
    
[refreshbut addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:refreshbut];
    
//    refreshbut.hidden=YES;
    
    footview =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-50, deviceScreenWidth, 50)];
    footview.backgroundColor=[UIColor colorWithRed:48/255.0 green:61/255.0 blue:79/255.0 alpha:1];
    [self.view addSubview:footview];
   
    UIButton * pricebut = [UIButton new];
    pricebut.tag =444;
    [pricebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:pricebut];
    [pricebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset((deviceScreenWidth-240)/4);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(80);
    }];
    priceim = [[UIImageView alloc]initWithFrame:CGRectMake(30,0, 20, 20)];
    priceim.image= [UIImage imageNamed:@"recommend_check"];
    [pricebut addSubview:priceim];
    pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 80, 14)];
    pricelabel.text=seatstring;
    pricelabel.textAlignment=NSTextAlignmentCenter;
    pricelabel.font= [UIFont systemFontOfSize:11];
    pricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    [pricebut addSubview:pricelabel];
    UIButton * timebut = [UIButton new];
    timebut.tag =445;
    [timebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:timebut];
    [timebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(2*((deviceScreenWidth-240)/4)+80);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(80);
    }];
    timeiamge = [[UIImageView alloc]initWithFrame:CGRectMake(30,0, 20, 20)];
    timeiamge.image= [UIImage imageNamed:@"star_filter_uncheck"];
    [timebut addSubview:timeiamge];
    timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 80, 14)];
    timelabel.text=@"价格星级筛选";
    timelabel.textAlignment=NSTextAlignmentCenter;
    timelabel.font =[UIFont systemFontOfSize:11];
    //timelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [timebut addSubview:timelabel];
    
    UIButton * sxbut = [UIButton new];
    sxbut.tag =446;
    [sxbut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:sxbut];
    [sxbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(3*((deviceScreenWidth-240)/4)+2*80);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(80);
    }];
    sxiamge = [[UIImageView alloc]initWithFrame:CGRectMake(30,0, 20, 20)];
    sxiamge.image= [UIImage imageNamed:@"filter_off"];
    [sxbut addSubview:sxiamge];
    sxlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 80, 14)];
    sxlabel.text=@"更多筛选";
    sxlabel.textAlignment=NSTextAlignmentCenter;
    sxlabel.font =[UIFont systemFontOfSize:11];
    // sxlabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [sxbut addSubview:sxlabel];
    
    if (_Approval==YES) {
        [self loaddataApproval];
    }else{
        [self loaddata];
        //筛选条件
        [self loaddataHbs];
  
    }
    [self creattableView];
    // 6、搜索栏
   // [self addSearchBar];
    [self initSearchBar];
    _SXconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _SXconnetview.backgroundColor=[UIColor blackColor];
    _SXconnetview.alpha=0.7;
    [self.view  addSubview:_SXconnetview];

    _page=50;
    // 5、添加上下刷新
    [self addRefresh];
    NSArray * arry1 = @[@{@"1":@"不限",@"num":@"1",@"2":@""},@{@"1":@"150元以下",@"num":@"0",@"type":@"1",@"2":@"150"},@{@"1":@"150-300元",@"num":@"0",@"2":@"150-300"},@{@"1":@"300-500元",@"num":@"0",@"2":@"300-500"},@{@"1":@"500元以上",@"num":@"0",@"2":@"500"}];
    _colldataArr=[NSMutableArray arrayWithArray:arry1];
    NSMutableArray *  pssarr1 = [NSMutableArray new];
    for (NSDictionary * dict  in _colldataArr) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [pssarr1 addObject:d];
    }
    _colldataArr=[NSMutableArray arrayWithArray:pssarr1];
    
    NSArray * arry2 = @[@{@"1":@"不限",@"num":@"1",@"2":@""},@{@"1":@"二星级以下",@"num":@"0",@"type":@"2",@"2":@"2"},@{@"1":@"三星",@"num":@"0",@"2":@"3"},@{@"1":@"四星",@"num":@"0",@"2":@"4"},@{@"1":@"五星",@"num":@"0",@"2":@"5"}];
    _colldataArr1=[NSMutableArray arrayWithArray:arry2];
    NSMutableArray *  pssarr2 = [NSMutableArray new];
    for (NSDictionary * dict  in _colldataArr1) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [pssarr2 addObject:d];
    }
    _colldataArr1=[NSMutableArray arrayWithArray:pssarr2];
}
-(void)back:(UIButton*)but{
    [self.navigationController popViewControllerAnimated:NO];
//   [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -审批数据
-(void)loaddataApproval{
    __weak typeof(self) weakself = self;
//    NSLog(@"%@",_HdataDict);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;
    HotelQuery * hq = [HotelQuery new];
    hq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    hq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    hq.CityId=_HdataDict[@"cityId"];
    hq.OrderBy=0;
    hq.Count=_page;
    hq.Star=0;
    hq.Start=0;
    _dataArray=[NSMutableArray new];
    _dataArray1=[NSMutableArray new];
    recomarr=[NSMutableArray new];
    pricearr=[NSMutableArray new];
    pricearr1=[NSMutableArray new];
    stararr=[NSMutableArray new];
    stararr1=[NSMutableArray new];
    [Hotel HotelQuery:hq success:^(id data) {
        [SVProgressHUD dismiss];
        _dataArray1=data[@"hotelList"];
        NSLog(@"%@",data[@"hotelList"][0]);
        for (NSMutableDictionary * dic in data[@"hotelList"]) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        //        NSLog(@"%@",_dataArray);
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"recomDegree" ascending:YES];
        
        NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
        
        NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"star" ascending:YES];
        
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
        NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
        
        
        NSMutableArray * ar1= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors]];
        
        for (NSMutableDictionary * dic in ar1) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [recomarr addObject:model];
        }
        NSMutableArray * ar2= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors1]];
        for (NSMutableDictionary * dic in ar2) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [pricearr addObject:model];
        }
        NSMutableArray * ar3= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors2]];
        
        for (NSMutableDictionary * dic in ar3) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [stararr addObject:model];
        }
        
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
        
        NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"star" ascending:NO];
        
        NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        NSArray *descriptors22 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
        
        NSMutableArray * ar4= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors11]];
        for (NSMutableDictionary * dic in ar4) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [pricearr1 addObject:model];
        }
        NSMutableArray * ar5= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors22]];
        
        for (NSMutableDictionary * dic in ar5) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [stararr1 addObject:model];
        }
        [_tableView reloadData];
        self.view.userInteractionEnabled=YES;
        //结束头部刷新
        [self.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    [self loaddataHbs];
}
-(void)loaddataHbs{
    HotelBaseDataList * hbs = [HotelBaseDataList new];
    hbs.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    hbs.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Hotel HotelBaseDataList:hbs success:^(id data) {
        
        _GJdata=[NSMutableArray new];
        _JJdata=[NSMutableArray new];
        _SEdata=[NSMutableArray new];
        NSLog(@"%@",data);
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setObject:@"不限" forKey:@"shorName"];
        [dict setObject:@"1" forKey:@"num"];
        [dict setObject:@"g" forKey:@"TYPE"];
        [_GJdata addObject:dict];
        
        NSMutableDictionary * dict0 = [NSMutableDictionary new];
        [dict0 setObject:@"不限" forKey:@"shorName"];
        [dict0 setObject:@"1" forKey:@"num"];
        [dict0 setObject:@"j" forKey:@"TYPE"];
        [_JJdata addObject:dict0];
        
        NSMutableDictionary * dict2 = [NSMutableDictionary new];
        [dict2 setObject:@"不限" forKey:@"name"];
        [dict2 setObject:@"1" forKey:@"num"];
        [dict2 setObject:@"s" forKey:@"TYPE"];
        [_SEdata addObject:dict2];
        
        for (NSDictionary * dic in data[@"brands"]) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dict setObject:@"0" forKey:@"num"];
            
            if ([dic[@"type"] isEqualToString:@"1001402"]) {
                [_JJdata addObject:dict];
            }else{
                [_GJdata addObject:dict];
            }
        }
        
        for (NSMutableDictionary * dic in data[@"facilities"]) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dict setObject:@"0" forKey:@"num"];
            [_SEdata addObject:dict];
        }
        _sxdata = [NSMutableArray arrayWithArray:_JJdata];
        //        NSLog(@"%@",_sxdata);
        [_tableView3 reloadData];
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;
    }];
    
}
#pragma mark -正常单
-(void)loaddata{
//    NSLog(@"%@",_requtstdict);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;
    HotelQuery * hq = [HotelQuery new];
    hq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    hq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    hq.CityId=_requtstdict[@"outcitycode"];
    hq.OrderBy=0;
    hq.Count=_page;
    hq.Star=0;
    hq.Start=0;
    
    if ([_requtstdict[@"type"] isEqualToString:@"YES"]) {
        //判断是否为酒店名
        if ([[_requtstdict[@"seatDict"] allValues] containsObject: _requtstdict[@"seatname"]]) {
            //判断是否为机场车站
            if ([[_requtstdict[@"seatDict"] allKeys] containsObject:@"poiName"]) {
                //            _requtstdict[@"seatname"]=_requtstdict[@"seatDict"][@"poiName"];
                hq.Type=@"2";
                hq.LocationName=_requtstdict[@"seatDict"][@"poiName"];
                hq.Longitude=_requtstdict[@"seatDict"][@"longitude"];
                hq.Latitude=_requtstdict[@"seatDict"][@"latitude"];
            }else{
                // _requtstdict[@"seatname"]=_requtstdict[@"seatDict"][@"name"];
                hq.Type=@"1";
                hq.LocationId=_requtstdict[@"seatDict"][@"id"];
                hq.LocationName=_requtstdict[@"seatDict"][@"name"];
            }
        }else{
            hq.HotelName=_requtstdict[@"seatname"];
            hq.Type=@"3";
        }
    }
    if (_GJJSE==YES) {
        if(otherGJarr.count!=0){
            NSMutableArray  * arr = [NSMutableArray new];
            for (NSDictionary * dict in otherGJarr) {
                [arr addObject:dict[@"id"]];
            }
            hq.Brand=[arr componentsJoinedByString:@","];
        }
        
        if(otherSEarr.count!=0){
            NSMutableArray  * arr = [NSMutableArray new];
            for (NSDictionary * dict in otherSEarr) {
                [arr addObject:dict[@"id"]];
            }
            hq.Facility=[arr componentsJoinedByString:@","];
        }
    }
    
    _dataArray=[NSMutableArray new];
    _dataArray1=[NSMutableArray new];
    recomarr=[NSMutableArray new];
    pricearr=[NSMutableArray new];
    pricearr1=[NSMutableArray new];
    stararr=[NSMutableArray new];
    stararr1=[NSMutableArray new];
    [Hotel HotelQuery:hq success:^(id data) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD dismiss];
        _GJJSE=NO;
        _dataArray1=data[@"hotelList"];
 //  NSLog(@"%@",_dataArray1);
 //   NSLog(@"%@",data[@"hotelList"][0]);
        for (NSMutableDictionary * dic in data[@"hotelList"]) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
                    [_dataArray addObject:model];
                }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"recomDegree" ascending:YES];
        
        NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
        
        NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"star" ascending:YES];
        
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
        NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
      
        NSMutableArray * ar1= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors]];
        
        for (NSMutableDictionary * dic in ar1) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [recomarr addObject:model];
        }
          NSMutableArray * ar2= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors1]];
        for (NSMutableDictionary * dic in ar2) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [pricearr addObject:model];
        }
        NSMutableArray * ar3= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors2]];

        for (NSMutableDictionary * dic in ar3) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [stararr addObject:model];
        }
        
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
        
        NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"star" ascending:NO];
        
        NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        NSArray *descriptors22 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
        
        NSMutableArray * ar4= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors11]];
        for (NSMutableDictionary * dic in ar4) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [pricearr1 addObject:model];
        }
        NSMutableArray * ar5= [NSMutableArray arrayWithArray:[_dataArray1 sortedArrayUsingDescriptors:descriptors22]];
        
        for (NSMutableDictionary * dic in ar5) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [stararr1 addObject:model];
        }
        [_tableView reloadData];
        //结束头部刷新
        [self.tableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.tableView.mj_footer endRefreshing];
        
        } failure:^(NSError *error) {
            self.view.userInteractionEnabled=YES;
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            _GJJSE=NO;
    }];
}
- (CGFloat)newSuitFrame:(CGFloat)frame
{
    CGFloat newFrame;
    newFrame=frame/SCREEN_RATE;
    return newFrame;
}
-(void)creattableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, deviceScreenWidth, deviceScreenHeight-104-49)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    _tableView.userInteractionEnabled=YES;
    [self.view addSubview:effectView];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenHeight/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [self loadPickerData];
    effectView.hidden=YES;
    [self.view addSubview:pickerView];
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
#pragma mark -价格星级筛选视图
//    _SXconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
//    _SXconnetview.backgroundColor=[UIColor blackColor];
//    _SXconnetview.alpha=0.7;
//    [self.view  addSubview:_SXconnetview];
    
   PSSXview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,350 )]];
    PSSXview.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:PSSXview];
    UIView * PSSXtitleView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 50)]];
   PSSXtitleView.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [PSSXview addSubview:PSSXtitleView];
    UIButton * PSSXcancelbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(19, 14, 52, 18)]];
    [PSSXcancelbut setTitle:@"取消" forState:UIControlStateNormal];
    PSSXcancelbut.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [PSSXcancelbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PSSXcancelbut addTarget:self action:@selector(PSSXcancelbut:) forControlEvents:UIControlEventTouchUpInside];
    [PSSXview addSubview:PSSXcancelbut];
    
    UIButton * PSSXclearbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(148, 10, 80, 30)]];
    PSSXclearbut.titleLabel.font=[UIFont systemFontOfSize:14];
    PSSXclearbut.backgroundColor=[UIColor darkGrayColor];
    PSSXclearbut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [PSSXclearbut setTitle:@"清除筛选" forState:UIControlStateNormal];
    [PSSXclearbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PSSXclearbut addTarget:self action:@selector(PSSXclearbut:) forControlEvents:UIControlEventTouchUpInside];
    [PSSXview addSubview:PSSXclearbut];
    
    UIButton * PSSXokbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(321, 14, 52, 18)]];
    PSSXokbut.titleLabel.font=[UIFont systemFontOfSize:14];
    [PSSXokbut setTitle:@"确定" forState:UIControlStateNormal];
    [PSSXokbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PSSXokbut addTarget:self action:@selector(PSSXokbut:) forControlEvents:UIControlEventTouchUpInside];
    [PSSXview addSubview:PSSXokbut];
    
    UILabel * titlelabel1  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 60, 64, 18)]];
    titlelabel1.text=@"价格范围";
    titlelabel1.textColor=[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1];
    titlelabel1.adjustsFontSizeToFitWidth=YES;
    [PSSXview addSubview:titlelabel1];
    
    //设置item的一些属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80/SCREEN_RATE1, self.view.frame.size.width,120/SCREEN_RATE1 ) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [_collectionView registerClass:[CollectionViewCellHtole class] forCellWithReuseIdentifier:@"cellIde"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [PSSXview addSubview:_collectionView];
    //设置item的一些属性
    UICollectionViewFlowLayout *flow1 = [[UICollectionViewFlowLayout alloc] init];
    flow1.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220/SCREEN_RATE1, self.view.frame.size.width,120/SCREEN_RATE1 ) collectionViewLayout:flow1];
    _collectionView1.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [_collectionView1 registerClass:[CollectionViewCellHtole class] forCellWithReuseIdentifier:@"cellIde1"];
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    [PSSXview addSubview:_collectionView1];
    
    
    UILabel * titlelabel2  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 200, 32, 18)]];
    titlelabel2.text=@"星级";
    titlelabel2.textColor=[UIColor colorWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1];
    titlelabel2.adjustsFontSizeToFitWidth=YES;
    [PSSXview addSubview:titlelabel2];
    

#pragma mark -更多筛选视图
    SXview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )]];
    [self.view addSubview:SXview];
    UIView * sxtitleView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 50)]];
    sxtitleView.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [SXview addSubview:sxtitleView];
    UIButton * cancelbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(19, 14, 52, 18)]];
    [cancelbut setTitle:@"取消" forState:UIControlStateNormal];
    cancelbut.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [cancelbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelbut addTarget:self action:@selector(cancelbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:cancelbut];
    
    UIButton * clearbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(148, 10, 80, 30)]];
    clearbut.titleLabel.font=[UIFont systemFontOfSize:14];
    clearbut.backgroundColor=[UIColor darkGrayColor];
    clearbut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [clearbut setTitle:@"清除筛选" forState:UIControlStateNormal];
    [clearbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearbut addTarget:self action:@selector(clearbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:clearbut];
    
    UIButton * okbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(321, 14, 52, 18)]];
    okbut.titleLabel.font=[UIFont systemFontOfSize:14];
    [okbut setTitle:@"确定" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:okbut];
    UIView * leftView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 50, 120, 292)]];
    leftView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [SXview addSubview:leftView];
    
    UIButton * Lbut1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 120, 60)]];
    Lbut1.tag=1001;
    Lbut1.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut1.backgroundColor=[UIColor whiteColor];
    [Lbut1 setTitle:@"经济连锁酒店" forState:UIControlStateNormal];
    [Lbut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut1 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 61, 120, 1)]];
    lineView.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView];
    
    UIButton * Lbut2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 62, 120, 60)]];
    Lbut2.tag=1002;
    Lbut2.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut2 setTitle:@"高级连锁酒店" forState:UIControlStateNormal];
    [Lbut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut2 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut2];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 122, 120, 1)]];
    lineView1.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView1];
    UIButton * Lbut3 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 123, 120, 60)]];
    Lbut3.tag=1003;
    Lbut3.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut3 setTitle:@"设施服务" forState:UIControlStateNormal];
    [Lbut3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut3 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut3];
    
    UIView * lineView2 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 184, 120, 1)]];
    lineView2.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView2];
    
    
    _tableView3= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(118, 50, 255, 298)] style:UITableViewStylePlain];
    _tableView3.backgroundColor=[UIColor whiteColor];
    _tableView3.dataSource=self;
    _tableView3.delegate=self;
    [SXview addSubview:_tableView3];
// _sxdata=[NSMutableArray arrayWithArray:];
    [_tableView3 reloadData];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        return [self newSuitFrame:110];
    }else{
        return 40/SCREEN_RATE;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_tableView]) {
        if(_result.count==0){
            return _dataArray.count;
        }else{
            return self.result.count;
        }
    }else{
        return _sxdata.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   if ([tableView isEqual:_tableView]) {
    hotelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[hotelCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        //cell= (hotelCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"hotelCell" owner:self options:nil]  lastObject];
    }
    //NSLog(@"%@",_dataArray[indexPath.row]);
    if(_result.count==0){
        if(indexPath.row< _dataArray.count) {
     [cell setCellWithModel:_dataArray[indexPath.row]];
        }
//        [cell setCellWithModel:_dataArray[indexPath.row]];
    }else{
        [cell setCellWithModel:_result[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
   }else{
       sxtablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
       // cell的复用
       if (!cell) {
           cell = [[sxtablecell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
       }
       if ([[_sxdata[1] allKeys] containsObject:@"shorName"]) {
           cell.strlabel.text=_sxdata[indexPath.row][@"shorName"];
       }else{
           cell.strlabel.text=_sxdata[indexPath.row][@"name"];
       }
       
       if([_sxdata[indexPath.row][@"num"] isEqualToString:@"1"]){
           cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
       }else{
           cell.strlabel.textColor=[UIColor blackColor];
       }
       return cell;
   }
}
//点击cell触摸方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
if([tableView isEqual:_tableView]){
    NSLog(@"%@",_menarray);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    
    hotelMessageVC * hmvc =[hotelMessageVC new];
    hmvc.menarray=_menarray;
    hotelmssModel * model =[hotelmssModel new];
    if(_result.count!=0){
        model=_result[indexPath.row];
    }else{
        model=_dataArray[indexPath.row];
    }
    
    NSMutableDictionary * dict1 =[NSMutableDictionary new];
    [dict1 setValue:_outcity forKey:@"hcity"];
    [dict1 setValue:model.hotelName forKey:@"hotelName"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"hostory" object:nil userInfo:dict1];

    
//  NSLog(@"%@",model.hotelId);
       HotelInfQuery * hiq =[HotelInfQuery new];
    hiq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    hiq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    hiq.HotelId=model.hotelId;
    [Hotel HotelInfQuery:hiq success:^(id data) {
         [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            hmvc.hotelId=model.hotelId;
            hmvc.hotelname=model.hotelName;
            hmvc.datadict=data;
            hmvc.requtstdict=_requtstdict;
            [self.navigationController  pushViewController:hmvc animated:YES];
//        [self presentViewController:hmvc animated:NO completion:nil];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    }else{
        if ([_sxdata[0][@"TYPE"] isEqualToString:@"j"]) {
            if(indexPath.row!=0){
                int count=0;
                if ([_JJdata[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    _JJdata[indexPath.row][@"num"]=@"0";
                    
                    for (int i=0;i<_JJdata.count;i++) {
                        if ([_JJdata[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<_JJdata.count;i++) {
                            _JJdata[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        _JJdata[0][@"num"]=@"1";
                    }
                }else{
                    _JJdata[0][@"num"]=@"0";
                    //如果不是 改成1
                    _JJdata[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<_JJdata.count;i++) {
                    _JJdata[i][@"num"]=@"0";
                }
                //如果不是 改成1
                _JJdata[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:_JJdata];
            [_tableView3 reloadData];
        }else if ([_sxdata[0][@"TYPE"] isEqualToString:@"g"]){
            int count=0;
            if(indexPath.row!=0){
                if ([_GJdata[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    _GJdata[indexPath.row][@"num"]=@"0";
                    for (int i=0;i<_GJdata.count;i++) {
                        if ([_GJdata[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<_GJdata.count;i++) {
                            _GJdata[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        _GJdata[0][@"num"]=@"1";
                    }

                }else{
                    _GJdata[0][@"num"]=@"0";
                    //如果不是 改成1
                    _GJdata[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<_GJdata.count;i++) {
                    _GJdata[i][@"num"]=@"0";
                }
                //如果不是 改成1
                _GJdata[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:_GJdata];
            [_tableView3 reloadData];
        }else if ([_sxdata[0][@"TYPE"] isEqualToString:@"s"]){
            int count=0;
            if(indexPath.row!=0){
                if ([_SEdata[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    _SEdata[indexPath.row][@"num"]=@"0";
                    for (int i=0;i<_GJdata.count;i++) {
                        if ([_GJdata[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<_GJdata.count;i++) {
                            _GJdata[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        _GJdata[0][@"num"]=@"1";
                    }
                    
                }else{
                    _SEdata[0][@"num"]=@"0";
                    //如果不是 改成1
                    _SEdata[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<_SEdata.count;i++) {
                    _SEdata[i][@"num"]=@"0";
                }
                //如果不是 改成1
                _SEdata[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:_SEdata];
            [_tableView3 reloadData];
        }else{
        }
    }
}
#pragma mark -底部视图按钮
-(void)footclick:(UIButton*)send{
    switch (send.tag) {
        case 444:
            priceim.image= [UIImage imageNamed:@"recommend_check"];
            pricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            timeiamge.image= [UIImage imageNamed:@"star_filter_uncheck"];
            timelabel.text=@"价格星级筛选";
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            sxiamge.image= [UIImage imageNamed:@"filter_off"];
            sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            [self chick];
            [_tableView reloadData];
            break;
        case 445:
            PSSXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1-350, 375, 350)];
            _SXconnetview.frame=CGRectMake(0, 0, 375/SCREEN_RATE, deviceScreenHeight-350/SCREEN_RATE1);

            timeiamge.image= [UIImage imageNamed:@"star_filter_check"];
            timelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"recommend_uncheck"];
            pricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            timelabel.text=@"价格星级筛选";
            pricelabel.text=@"推荐度";
            sxiamge.image= [UIImage imageNamed:@"filter_off"];
            sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            [_tableView reloadData];
            break;
        case 446:{
            sxiamge.image= [UIImage imageNamed:@"filter_on"];
            sxlabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"recommend_uncheck"];
            pricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            timelabel.text=@"价格星级筛选";
            timeiamge.image= [UIImage imageNamed:@"star_filter_uncheck"];
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            pricelabel.text=@"推荐度";
            SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1-340, 375, 400)];
            _SXconnetview.frame=CGRectMake(0, 0, 375/SCREEN_RATE, deviceScreenHeight-340/SCREEN_RATE1);

            break;
        }
        default:
            break;
    }
}
#pragma mark - 5、上下拉刷新
- (void)addRefresh{
    __weak typeof(self) weakself = self;
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.view.userInteractionEnabled=NO;

        weakself.page =50;
        if (_Approval==YES) {
            [weakself loaddataApproval];
        }else{
            [weakself loaddata];
        }
    }];
    
    self.tableView.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.view.userInteractionEnabled=NO;

        // 进入刷新状态后会自动调用这个block
        weakself.page =_page+50;
        if (_Approval==YES) {
            [weakself loaddataApproval];
        }else{
            [weakself loaddata];
        }
    }];
}

#pragma mark 设置滚动选择框

-(void)picker:(UIButton*)send{
    UIView * vv=[UIView new];
    switch (send.tag) {
        case 211:
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            break;
        case 212:
//            footview.hidden=NO;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            pricelabel.text=seatstring;
            if ([seatstring isEqualToString:@"价格从低到高"]) {
                _dataArray=[NSMutableArray arrayWithArray:pricearr];
            }else if ([seatstring isEqualToString:@"价格从高到低"]){
                _dataArray=[NSMutableArray arrayWithArray:pricearr1];
            }else if ([seatstring isEqualToString:@"推荐度"]){
                _dataArray=[NSMutableArray arrayWithArray:recomarr];
            }else if ([seatstring isEqualToString:@"星级从高到低"]){
                _dataArray=[NSMutableArray arrayWithArray:stararr1];
            }else if ([seatstring isEqualToString:@"星级从低到高"]){
                _dataArray=[NSMutableArray arrayWithArray:stararr];
            }else{
            }
            [_tableView reloadData];
            break;
        default:
            break;
    }
}
-(void)chick{
    [UIView animateWithDuration:0.5 animations:^{
//        footview.hidden=YES;
        effectView.hidden=NO;
        // 设置view弹出来的位置
        pickerView.frame = CGRectMake(0, deviceScreenHeight-(self.view.frame.size.height/3+30), self.view.frame.size.width, self.view.frame.size.height/3+30);
        UIView * vv =(UIView*)[self.view viewWithTag:133];
        vv.frame = CGRectMake(0, deviceScreenHeight-(self.view.frame.size.height/3+60), self.view.frame.size.width, 40);
    }];
}
-(void)loadPickerData{
    _arr=@[@"推荐度",@"价格从低到高",@"价格从高到低",@"星级从高到低",@"星级从低到高"];
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
//    [pickerView selectRow:0 inComponent:0 animated:NO];

    seatstring = _arr[rowOne];
    //NSLog(@"%@",seatstring);
}
//一组返回item数量
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _colldataArr.count;
}
-(CollectionViewCellHtole *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_collectionView]) {
        //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
        CollectionViewCellHtole *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde" forIndexPath:indexPath];
        if ([_colldataArr[indexPath.row][@"num"] isEqualToString:@"1"]) {
            cell.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
            cell.str.textColor=[UIColor whiteColor];
        }else{
            cell.backgroundColor=[UIColor whiteColor];
            cell.str.textColor=[UIColor blackColor];
        }
        cell.str.text=_colldataArr[indexPath.row][@"1"];
        return cell;
    }else{
        //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
        CollectionViewCellHtole *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde1" forIndexPath:indexPath];
        if ([_colldataArr1[indexPath.row][@"num"] isEqualToString:@"1"]) {
            cell.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
            cell.str.textColor=[UIColor whiteColor];
        }else{
            cell.backgroundColor=[UIColor whiteColor];
            cell.str.textColor=[UIColor blackColor];

        }
        cell.str.text=_colldataArr1[indexPath.row][@"1"];
        return cell;
    }
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellHtole * cell = (CollectionViewCellHtole*)[collectionView cellForItemAtIndexPath:indexPath];
    if ([collectionView isEqual:_collectionView]) {
        NSMutableArray *  arr = [NSMutableArray arrayWithArray:_colldataArr];
        NSMutableArray *  arr1 = [NSMutableArray new];
        for (NSDictionary * dict  in arr) {
            NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
            [arr1 addObject:d];
        }
        _colldataArr=[NSMutableArray arrayWithArray:arr1];
        int count =0;
        if(indexPath.row!=0){
            if ([_colldataArr[indexPath.row][@"num"] isEqualToString:@"1"]) {
                _colldataArr[indexPath.row][@"num"]=@"0";
                for (int i=0;i<_colldataArr.count;i++) {
                    if ([_colldataArr[i][@"num"] isEqualToString:@"1"]) {
                        count=count+1;
                    }
                }
                if (count==0) {
                    for (int i=0;i<_colldataArr.count;i++) {
                        _colldataArr[i][@"num"]=@"0";
                    }
                    //如果不是 改成1
                    _colldataArr[0][@"num"]=@"1";
                }
            }else{
                _colldataArr[0][@"num"]=@"0";
                //如果不是 改成1
                _colldataArr[indexPath.row][@"num"]=@"1";
            }
        }else{
            for (int i=0;i<_colldataArr.count;i++) {
                _colldataArr[i][@"num"]=@"0";
            }
            //如果不是 改成1
            _colldataArr[indexPath.row][@"num"]=@"1";;
        }
        [_collectionView reloadData];
    }else{
        NSMutableArray *  arr = [NSMutableArray arrayWithArray:_colldataArr1];
        NSMutableArray *  arr1 = [NSMutableArray new];
        for (NSDictionary * dict  in arr) {
            NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
            [arr1 addObject:d];
        }
        _colldataArr1=[NSMutableArray arrayWithArray:arr1];
        int count =0;

        if(indexPath.row!=0){
            if ([_colldataArr1[indexPath.row][@"num"] isEqualToString:@"1"]) {
                _colldataArr1[indexPath.row][@"num"]=@"0";
              
                for (int i=0;i<_colldataArr1.count;i++) {
                    if ([_colldataArr1[i][@"num"] isEqualToString:@"1"]) {
                        count=count+1;
                    }
                }
                if (count==0) {
                    for (int i=0;i<_colldataArr1.count;i++) {
                        _colldataArr1[i][@"num"]=@"0";
                    }
                    //如果不是 改成1
                    _colldataArr1[0][@"num"]=@"1";
                }

            }else{
                _colldataArr1[0][@"num"]=@"0";
                //如果不是 改成1
                _colldataArr1[indexPath.row][@"num"]=@"1";
            }
        }else{
            for (int i=0;i<_colldataArr1.count;i++) {
                _colldataArr1[i][@"num"]=@"0";
            }
            //如果不是 改成1
            _colldataArr1[indexPath.row][@"num"]=@"1";;
        }
        [_collectionView1 reloadData];
    }
}
//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [framsizeclass newCGSize:CGSizeMake(106, 44)];
}
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{//表示距上，左，下，右边界的距离
    return [framsizeclass newUIEdgeInsets:UIEdgeInsetsMake(10,10,10,10)];
}
-(void)ma{
    [_collectionView reloadData];
}
-(void)PSSXcancelbut:(UIButton*)send{
    _dataArray=[NSMutableArray new];
    for (NSMutableDictionary * dic in _dataArray1) {
        hotelmssModel * model =[[hotelmssModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

    PSSXview.frame= [framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,350 )];
}
-(void)PSSXokbut:(UIButton*)send{
      PSSXview.frame= [framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,350 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

//    //数据源
//    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
  NSMutableArray *  arr = [NSMutableArray arrayWithArray:_dataArray1];
//    NSLog(@"%@",arr);
    NSMutableArray *  arr1 = [NSMutableArray new];
    //价格
    for (NSDictionary * dict in _colldataArr) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr1 = [NSMutableArray arrayWithArray:arr];
                break;
            }else{
                if ([dict[@"2"] isEqualToString:@"150"]) {
                    for (int i=0; i<arr.count; i++) {
                        if ([arr[i][@"minPrice"] floatValue]<[[dict[@"2"] substringWithRange:NSMakeRange(0,3)] floatValue]) {
                            [arr1 addObject:arr[i]];
                        }
                    }
                }
                
                 if ([dict[@"2"] isEqualToString:@"500"]){
                    for (int i=0; i<arr.count; i++) {
                        if ([arr[i][@"minPrice"] floatValue]>[[dict[@"2"] substringWithRange:NSMakeRange(0,3)] floatValue]) {
                            [arr1 addObject:arr[i]];
                        }
                    }
                }
                if ([dict[@"2"] isEqualToString:@"150-300"]){
                    for (int i=0; i<arr.count; i++) {
                        if ([arr[i][@"minPrice"] floatValue]>[[dict[@"2"] substringWithRange:NSMakeRange(0,3)] floatValue]) {
                            if ([arr[i][@"minPrice"] floatValue]<[[dict[@"2"] substringWithRange:NSMakeRange(4,3)] floatValue]) {
                                [arr1 addObject:arr[i]];
                            }
                            
                        }
                    }
                }
                if ([dict[@"2"] isEqualToString:@"300-500"]){
                    for (int i=0; i<arr.count; i++) {
                        if ([arr[i][@"minPrice"] floatValue]>[[dict[@"2"] substringWithRange:NSMakeRange(0,3)] floatValue]) {
                            if ([arr[i][@"minPrice"] floatValue]<[[dict[@"2"] substringWithRange:NSMakeRange(4,3)] floatValue]) {
                                [arr1 addObject:arr[i]];
                            }
                        }
                    }
                }
            }
        }
    }
    NSLog(@"%@",arr1);

    NSMutableArray *  arr2 = [NSMutableArray new];
//星级
    for (NSDictionary * dict in _colldataArr1) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr2 = [NSMutableArray arrayWithArray:arr1];
                break;
            }else{
                if ([dict[@"2"] isEqualToString:@"2"]) {
                    for (int i=0; i<arr1.count; i++) {
                        if ([[arr1[i][@"star"]  substringWithRange:NSMakeRange(0,1)] intValue]<=[[dict[@"2"] substringWithRange:NSMakeRange(0,1)] intValue]) {
                            [arr2 addObject:arr1[i]];
                        }
                    }
                }
                if ([dict[@"2"] isEqualToString:@"3"]) {
                    for (int i=0; i<arr1.count; i++) {
                        if ([[arr1[i][@"star"]  substringWithRange:NSMakeRange(0,1)]isEqualToString:[dict[@"2"] substringWithRange:NSMakeRange(0,1)]]) {
                            [arr2 addObject:arr1[i]];
                        }
                    }
                }
                if ([dict[@"2"] isEqualToString:@"4"]) {
                    for (int i=0; i<arr1.count; i++) {
                        if ([[arr1[i][@"star"]  substringWithRange:NSMakeRange(0,1)]isEqualToString:[dict[@"2"] substringWithRange:NSMakeRange(0,1)]]) {
                            [arr2 addObject:arr1[i]];
                        }
                    }
                }
                if ([dict[@"2"] isEqualToString:@"5"]) {
                    for (int i=0; i<arr1.count; i++) {
                        if ([[arr1[i][@"star"]  substringWithRange:NSMakeRange(0,1)]isEqualToString:[dict[@"2"] substringWithRange:NSMakeRange(0,1)]]) {
                            [arr2 addObject:arr1[i]];
                        }
                    }
                }
            }
        }
    }
    if (arr2.count!=0) {
        _dataArray=[NSMutableArray new];
        for (NSMutableDictionary * dic in arr2) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }else{
        [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的酒店，请重新筛选" duration:1.5];
        _dataArray=[NSMutableArray new];
        for (NSMutableDictionary * dic in _dataArray1) {
            hotelmssModel * model =[[hotelmssModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }
}
-(void)PSSXclearbut:(UIButton*)send{
   
    for (int i=0;i<_colldataArr.count;i++) {
      
            _colldataArr[i][@"num"]=@"0";
    }
    //如果不是 改成1
    _colldataArr[0][@"num"]=@"1";
    
    for (int i=0;i<_colldataArr1.count;i++) {
            _colldataArr1[i][@"num"]=@"0";
    }
    //如果不是 改成1
    _colldataArr1[0][@"num"]=@"1";
    
    _dataArray=[NSMutableArray new];
    for (NSMutableDictionary * dic in _dataArray1) {
        hotelmssModel * model =[[hotelmssModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_collectionView1 reloadData];
    [_collectionView reloadData];

    [_tableView reloadData];
}

#pragma mark -更多筛选按钮点及
-(void)cancelbut:(UIButton*)send{
  SXview.frame = [framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)okbut:(UIButton*)send{
    
//    NSMutableArray *  arr = [NSMutableArray arrayWithArray:_dataArray1];
  
    otherGJarr = [NSMutableArray new];
    otherSEarr  = [NSMutableArray new];

    for (NSDictionary * dict in _JJdata) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                break;
            }else{
                [otherGJarr addObject:dict];
            }
        }
    }
    
    for (NSDictionary * dict in _GJdata) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                break;
            }else{
                [otherGJarr addObject:dict];
            }
        }
    }
    
    for (NSDictionary * dict in _SEdata) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                break;
            }else{
                [otherSEarr addObject:dict];
            }
        }
    }

    NSLog(@"%@",otherSEarr);
    NSLog(@"%@",otherGJarr);
    
    if (otherGJarr.count!=0||otherSEarr.count!=0) {
        _GJJSE=YES;
        [self loaddata];
    }
    
    SXview.frame  =[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    SXview.frame  =[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )];
    PSSXview.frame= [framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,350 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}

-(void)clearbut:(UIButton*)send{
    
    for (int i=0;i<_JJdata.count;i++) {
        _JJdata[i][@"num"]=@"0";
    }
    //如果不是 改成1
    _JJdata[0][@"num"]=@"1";
    
    for (int i=0;i<_GJdata.count;i++) {
        _GJdata[i][@"num"]=@"0";
    }
    //如果不是 改成1
    _GJdata[0][@"num"]=@"1";

    for (int i=0;i<_SEdata.count;i++) {
        _SEdata[i][@"num"]=@"0";
    }
    //如果不是 改成1
    _SEdata[0][@"num"]=@"1";
    
    _dataArray=[NSMutableArray new];
    for (NSMutableDictionary * dic in _dataArray1) {
        hotelmssModel * model =[[hotelmssModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
    [_tableView3 reloadData];
}
-(void)Lbut:(UIButton*)send{
    switch (send.tag) {
        case 1001:{
            _sxdata=[NSMutableArray arrayWithArray:_JJdata];
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1002];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * but2 = (UIButton*)[self.view viewWithTag:1003];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            break;
        }
            
        case 1002:{
            _sxdata=[NSMutableArray arrayWithArray:_GJdata];
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1001];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];

            UIButton * but2 = (UIButton*)[self.view viewWithTag:1003];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            break;
        }
        case 1003:{
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1001];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIButton * but2 = (UIButton*)[self.view viewWithTag:1002];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
                        send.backgroundColor=[UIColor whiteColor];
            _sxdata=[NSMutableArray arrayWithArray:_SEdata];
            break;
        }
        default:
            break;
    }
    [_tableView3 reloadData];
}
-(void)refresh:(UIButton*)send{
    MapViewController *map  =[MapViewController new];
    map.menarray=_menarray;
     map.arr=_dataArray;
[self presentViewController:map animated:NO completion:nil];
}

@end
