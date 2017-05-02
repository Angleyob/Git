//
//  TrianCityVC.m
//  Tour
//
//  Created by Euet on 17/1/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrianCityVC.h"
#import "BMChineseSort.h"
#import "Person.h"
#import "TraincityMotel.h"
#import <Foundation/Foundation.h>

#import "CollectionHotcityCell.h"

@interface TrianCityVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    
    NSMutableArray *cityarray;

    
    NSArray * _da;
    NSMutableArray *stringsToSort;
    NSMutableArray *_arrayData;
    
    NSMutableArray *_arr;

    
    NSMutableArray<Person *> *dataArray;
    
    

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

@implementation TrianCityVC

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
    self.tabBarController.tabBar.hidden=YES;
        UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"选择站点";
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
    
    NSArray * arr1 = @[@"北京",@"上海",@"重庆",@"广州",@"深圳",@"天津"];
    cityarray=[NSMutableArray arrayWithArray:arr1];
    
    [self loaddata];
    
    [self creattable];
    
    [self initSearchBar];
    
}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:NO completion:nil];
    //[self.navigationController popViewControllerAnimated:YES ];
}
-(void)loaddata{
    stringsToSort=[NSMutableArray array];
    _dataArr=[NSMutableArray new];
    _arr=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainStationQuery * tsq  =[TrainStationQuery new];
    tsq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tsq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tsq.Start=0;
    tsq.Count=20;
    [Train TrainStationQuery:tsq success:^(id data) {
        [SVProgressHUD dismiss];
        
//        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _arr=data[@"trainStationList"];
            
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"tcity"]==nil) {
                [[NSUserDefaults standardUserDefaults]setObject:_arr forKey:@"tcity"];
            }

//            NSLog(@"%@",_arr);
            _arrayData = [[NSMutableArray alloc]init];
            
            for (int i=0; i<_arr.count; i++) {
                TraincityMotel * model = [TraincityMotel mj_objectWithKeyValues:_arr[i]];
                [ _dataArr addObject:model];
            }
            
            
            for (int i=0; i<_arr.count; i++) {
                
                [stringsToSort addObject:_arr[i][@"stationName"]];
            }
            _arrayData = [[NSMutableArray alloc]init];
            for (NSMutableString *str in stringsToSort) {
                NSString *strUrl = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                if (![_arrayData containsObject:strUrl]) {
                    [_arrayData addObject:strUrl];
                }
            }
            dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i<[_arrayData count]; i++) {
                Person *p = [[Person alloc] init];
                p.name = [_arrayData objectAtIndex:i];
                p.number = i;
                [dataArray addObject:p];
            }
            //根据Person对象的 name 属性 按中文 对 Person数组 排序
            _letterResultArr = [BMChineseSort sortObjectArray:dataArray Key:@"name"];

            self.indexArray = [BMChineseSort IndexWithArray:dataArray Key:@"name"];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
         [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)creattable{
    
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
    
    [_tableView reloadData];
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 114, deviceScreenWidth, deviceScreenHeight-64) style:UITableViewStylePlain ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView=view1;

    [self.view addSubview:_tableView];
}
#pragma mark - UITableView -
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   if(_result==0){
    return [self.indexArray objectAtIndex:section];
   }else{
        return nil;
   }
}
//section数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_result==0){
        return [self.indexArray count];
    }else{
        return 1;
    }
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if(_result==0){
            return [[self.letterResultArr objectAtIndex:section] count];
        }else{
            return _result.count;
        }
    }
        return 0;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
    if([cell.textLabel.text isEqualToString:_outcity]){
        [UIAlertView showAlertWithTitle:@"到达城市不能与出发城市相同，请重新选择"];
    }else if([cell.textLabel.text isEqualToString:_backcity]){
        [UIAlertView showAlertWithTitle:@"出发城市不能与到达城市相同，请重新选择"];
    }else{
        if (_block)
        {
            _block(cell.textLabel.text,_dataArr);
        }
        // [self.navigationController popViewControllerAnimated:YES ];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
//    if (_block)
//    {
//        _block(cell.textLabel.text,_dataArr);
//    }
    // [self.navigationController popViewControllerAnimated:YES ];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)TrianCitysendMessage:(TrianCityBlcok)block{
    _block=block;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (tableView == _tableView) {
            if(_result==0){
                //获得对应的Person对象<替换为你自己的model对象>
                Person *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                //NSLog(@"%@",_dataArr[indexPath.row][@"stationName"]);
                cell.textLabel.text =p.name;
        }else{
            cell.textLabel.text =_result[indexPath.row];
        }
    }
    return cell;
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
    
    if([cell.str.text isEqualToString:_outcity]){
        [UIAlertView showAlertWithTitle:@"到达城市不能与出发城市相同，请重新选择"];
    }else if([cell.str.text isEqualToString:_backcity]){
        [UIAlertView showAlertWithTitle:@"出发城市不能与到达城市相同，请重新选择"];
    }else{
        if (_block)
        {
            _block(cell.str.text,_dataArr);
        }
        // [self.navigationController popViewControllerAnimated:YES ];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake(self.view.frame.size.width/6, 25);
    return [framsizeclass newCGSize:CGSizeMake(100, 25)];
    
}
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{//表示距上，左，下，右边界的距离
    // return UIEdgeInsetsMake(20, deviceScreenWidth/5, 20,deviceScreenWidth/5);
    return [framsizeclass newUIEdgeInsets:UIEdgeInsetsMake(20,20,20,20)];
}


@end
