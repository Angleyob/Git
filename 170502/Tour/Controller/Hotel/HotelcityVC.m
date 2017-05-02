//
//  HotelcityVC.m
//  Tour
//
//  Created by Euet on 17/1/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "HotelcityVC.h"
#import "BMChineseSort.h"
#import "person1.h"
#import <Foundation/Foundation.h>
#import "CollectionHotcityCell.h"

@interface HotelcityVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *flightarr;
    NSMutableArray *cityarray;

    
    NSMutableArray *stringsToSort;
    NSMutableArray *_arrayData;
    UITableView *table;
    NSMutableArray<person1 *> *dataArray;
}
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

/** 搜索栏*/
@property (nonatomic,strong) UISearchBar *searchBar;
/** 搜索栏下的透明层*/
@property (nonatomic,strong) UIView *searchBarBgView;

@property (nonatomic,strong) NSMutableArray * result;

@end
@implementation HotelcityVC
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作在此次添加
        //模拟数据加载 dataArray中得到Person的数组
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        [self loadData];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
            //根据Person对象的 name 属性 按中文 对 Person数组 排序
            _indexArray = [BMChineseSort IndexWithArray:dataArray Key:@"name"];
            self.letterResultArr = [BMChineseSort sortObjectArray:dataArray Key:@"name"];
            //在主线程刷新UI
            [table reloadData];
        });
    });
}

-(NSMutableArray *)result{
    if (!_result) {
        self.result = [NSMutableArray array];
    }
    return _result;
}

-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50)];
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
            cancel.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
            cancel.titleLabel.font=[UIFont systemFontOfSize:14];
            //            cancel.titleLabel.textAlignment=NSTextAlignmentCenter;
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
    hotelmssModel * model =[[hotelmssModel alloc] init];
    for (int i = 0; i < _arrayData.count; i++) {
        ;
        NSString *string =_arrayData[i];
        if (string.length >= searchText.length) {
            //            NSString *str = [model.hotelName substringWithRange:NSMakeRange(0, searchText.length)];
            //
            //            if ([str isEqualToString:searchText]) {
            //                [self.result addObject:_dataArray[i]];
            //            }
            
            if([string rangeOfString:searchText].location !=NSNotFound)//_roaldSearchText
            {
                [self.result addObject:_arrayData[i]];
            }
            else
            {
            }
        }
    }
    // NSLog(@"%@",self.result);
    [table reloadData];
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
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//       //根据Person对象的 name 属性 按中文 对 Person数组 排序
// _indexArray = [BMChineseSort IndexWithArray:dataArray Key:@"name"];
// self.letterResultArr = [BMChineseSort sortObjectArray:dataArray Key:@"name"];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"选择城市";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    
    NSArray * arr1 = @[@"北京",@"上海",@"重庆",@"广州",@"深圳",@"杭州"];
    cityarray=[NSMutableArray arrayWithArray:arr1];
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, deviceScreenWidth, 105)];
    UIView * view2  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 25)];
    view2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    //view2.backgroundColor=[UIColor redColor];
    [view1 addSubview:view2];
    UILabel * labelhot = [[UILabel alloc]initWithFrame:CGRectMake(20, 2, deviceScreenWidth-20, 20)];
    labelhot.text=@"热门城市";
    labelhot.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view2 addSubview:labelhot];
    //设置item的一些属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置item的滑动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    UICollectionViewScrollDirectionVertical,
    _menconView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 80) collectionViewLayout:flow];
    //    UICollectionViewScrollDirectionHorizonta
    _menconView.backgroundColor = [UIColor whiteColor];
    //设置复用
    //第一个参数 复用cell类型
    //第二个参数 cell标示
    [_menconView registerClass:[CollectionHotcityCell class] forCellWithReuseIdentifier:@"cellIde"];
    //xib复用方法
    //collectionView registerNib:[] forCellWithReuseIdentifier:<#(NSString *)#>
    _menconView.backgroundColor=[UIColor whiteColor];
    _menconView.delegate = self;
    _menconView.dataSource = self;
    [view1 addSubview:_menconView];

    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 115, deviceScreenWidth, deviceScreenHeight-115)];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView=view1;

    [self.view addSubview:table];
    [self initSearchBar];

    }
//加载模拟数据
-(void)back:(UIButton *)send{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loadData{
    stringsToSort=[NSMutableArray array];
    NSString*filePath=[[NSBundle mainBundle] pathForResource:@"hotelcuty"ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString * str;
    str = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
   id  json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//NSLog(@"8888%@",json);
//    for (NSMutableDictionary * dic in json) {
//        FlightModel * model = [FlightModel mj_objectWithKeyValues:dic];
//        [flightarr addObject:model];
//    }
    for (NSDictionary * dict in json) {
        [stringsToSort addObject:dict[@"cityName"]];
    }
    _arrayData = [[NSMutableArray alloc]init];
    for (NSString *str in stringsToSort) {
        if (![_arrayData containsObject:str]) {
            [_arrayData addObject:str];
        }
    }
    //模拟网络请求接收到的数组对象 Person数组
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[_arrayData count]; i++) {
        person1 *p = [[person1 alloc] init];
        p.name = [_arrayData objectAtIndex:i];
        p.number = i;
        [dataArray addObject:p];
    }
    [self initSearchBar];

}
#pragma mark - UITableView -
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(_result==0){
        return [self.indexArray objectAtIndex:section];
    }else{
        return nil;
    }}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_result==0){
        return [self.indexArray count];
    }else{
        return 1;
    }
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == table) {
        if(_result==0){
            return [[self.letterResultArr objectAtIndex:section] count];
        }else{
            return _result.count;
        }
    }
    return 0;}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (tableView == table) {
        if(_result==0){
            //获得对应的Person对象<替换为你自己的model对象>
            person1 *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            //NSLog(@"%@",_dataArr[indexPath.row][@"stationName"]);
            cell.textLabel.text =p.name;
        }else{
            cell.textLabel.text =_result[indexPath.row];
        }
    }
    return cell;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    if (_block)
    {
        _block(cell.textLabel.text);
    }
    //[self.navigationController popViewControllerAnimated:YES ];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendMessage:(hotelBlcok)block{
    _block=block;
}
//一组返回item数量
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cityarray.count;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
    CollectionHotcityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde" forIndexPath:indexPath];
    cell.str.text=cityarray[indexPath.row];
    cell.str.textAlignment = NSTextAlignmentCenter;
    cell.str.layer.borderColor = [[UIColor grayColor]CGColor];
    cell.str.layer.borderWidth = 1.0f;
    cell.str.layer.masksToBounds = YES;
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionHotcityCell *cell = [
                                   collectionView cellForItemAtIndexPath:indexPath];
    //[_dataArray1 removeObjectAtIndex:indexPath.row];
    NSLog(@"indexPath.row = %ld",indexPath.row);
    
         if (_block)
        {
            _block(cell.str.text);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
}
//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [framsizeclass newCGSize:CGSizeMake(100, 25)];
    
}
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{//表示距上，左，下，右边界的距离
    // return UIEdgeInsetsMake(20, deviceScreenWidth/5, 20,deviceScreenWidth/5);
    return [framsizeclass newUIEdgeInsets:UIEdgeInsetsMake(20,20,20,20)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
