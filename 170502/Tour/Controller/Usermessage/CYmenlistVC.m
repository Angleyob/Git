//
//  CYmenlistVC.m
//  Tour
//
//  Created by Euet on 17/2/20.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CYmenlistVC.h"
#import "changemanCell.h"

@interface CYmenlistVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
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
@implementation CYmenlistVC


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
    [self loatadate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    label.text=@"常用旅客";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

        
    
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
    addlabel.text=@"新增旅客";
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
    //创建UITableView后，要去遵守他的两个协议
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 154, self.view.frame.size.width, self.view.frame.size.height-154) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsMultipleSelection = YES;
    [self.view addSubview:_tableView];
    
   }
-(void)loatadate{
    
    _dataArray=[NSMutableArray new];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BookEmpQueryRequest * Query = [BookEmpQueryRequest new];
    Query.BookerId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.Count=100;
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
            [mutDic2 setValue:@"1" forKey:@"num"];
            [arry1 addObject:mutDic2];
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
-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changemanCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * action, NSIndexPath * indexPath) {
        
        addMenViewController * addmvc = [addMenViewController new];
        addmvc.messageDict=cell.celldict;
        addmvc.type=4;
//        NSLog(@"%@",cell.celldict);
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
    return _dataArray.count;
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changemanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
    if (!cell) {
        cell= (changemanCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"changemanCell" owner:self options:nil]  lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.celldict=_dataArray[indexPath.row];
    if ([_dataArray[indexPath.row][@"certType"] isEqualToString:@"NI"]) {
        cell.cardlabel.text=@"身份证";
    }else{
        cell.cardlabel.text=@"护照";
    }
    cell.imv.hidden=YES;
    cell.namelabel.text=_dataArray[indexPath.row][@"empName"];
    cell.cardnumber.text=_dataArray[indexPath.row][@"certNo"];

    if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
        cell.imv.image=[UIImage imageNamed:@"check_on"];
    }else{
        cell.imv.image=[UIImage imageNamed:@"check_off"];
    }
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
}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:nil ];
}
-(void)click:(UIButton*)send{
    addMenViewController * add = [addMenViewController new];
    add.type=4;
    //[self.navigationController  pushViewController:add animated:YES];
    [self presentViewController:add animated:nil completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
