//
//  ApprovalVC.m
//  Tour
//  Created by Euet on 17/2/10.
//  Copyright © 2017年 lhy. All rights reserved.

#import "ApprovalVC.h"
#import "DapprovModel.h"
#import "DapprovCell.h"


#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface ApprovalVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * Dbutton;
    UIButton * Ybutton;
    UIView * viewline;
    UIScrollView*_scrollView1;
    //待审批数据
    NSMutableArray * _DArray;
    //已审批
    NSMutableArray * _YArray;
    //已拒绝
    NSMutableArray * _YJArray;

    

}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UITableView * tableView1;

@end

@implementation ApprovalVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationController.navigationBar.hidden=YES;
       self.tabBarController.tabBar.hidden=YES;
  //  [self loadData];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"审批管理";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    [self initview];
}
#pragma mark -加载数据
-(void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    _DArray = [NSMutableArray new];
    _YArray=[NSMutableArray new];
    ApproveQueryRequest * apr =[ApproveQueryRequest new];
    apr.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    apr.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    apr.Count=50;
    apr.Start=0;
    apr.Channel=@"1";
    apr.ApprovalStatus=@"0";
    [Approval ApproveQuery:apr success:^(id data) {
        NSLog(@"%@",data);
         [SVProgressHUD dismiss];
        if([data[@"status"] isEqualToString:@"T"]){
            for (NSMutableDictionary * dict  in data[@"approveOrderList"]) {
                DapprovModel * model =[[DapprovModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_DArray addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
      [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    ApproveQueryRequest * apr0 =[ApproveQueryRequest new];
    apr0.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    apr0.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    apr0.Count=50;
    apr0.Start=0;
    apr0.ApprovalStatus=@"1";
    [Approval ApproveQuery:apr0 success:^(id data) {
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            for (NSMutableDictionary * dict  in data[@"approveOrderList"]) {
                YapprovModel * model =[[YapprovModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_YArray addObject:model];
            }
            [_tableView1 reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    ApproveQueryRequest * apr1 =[ApproveQueryRequest new];
    apr1.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    apr1.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    apr1.Count=50;
    apr1.Start=0;
    apr1.ApprovalStatus=@"2";
    [Approval ApproveQuery:apr1 success:^(id data) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark -初始化视图
-(void)initview{
    UIView * view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 375/SCREEN_RATE, 45/SCREEN_RATE)];
    view0.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:view0];
    Dbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 375/SCREEN_RATE/2, 40/SCREEN_RATE)];
    [Dbutton setTitle:@"待审批" forState:UIControlStateNormal];
    [Dbutton addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
     [Dbutton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
    Dbutton.tag=100;
    [view0 addSubview:Dbutton];
    Ybutton = [[UIButton alloc]initWithFrame:CGRectMake(375/SCREEN_RATE/2, 0, 375/SCREEN_RATE/2, 40/SCREEN_RATE)];
    Ybutton.tag=101;
    [Ybutton addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [Ybutton setTitleColor:[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
    [Ybutton setTitle:@"已审批" forState:UIControlStateNormal];
    [view0 addSubview:Ybutton];

    viewline = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 375/SCREEN_RATE/2, 5)];
    viewline.backgroundColor=[UIColor colorWithRed:13/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view0 addSubview:viewline];
    
    _scrollView1 =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+43, self.view.frame.size.width,self.view.frame.size.height-64-43)];
    _scrollView1.contentSize= CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height-64-43);
    //边界不滑动
    _scrollView1.bounces = NO;
    _scrollView1.alpha=1;
    //分页
    _scrollView1.pagingEnabled = YES;
    // _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView1.showsVerticalScrollIndicator=NO;
    
    UIView * Dview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth,deviceScreenHeight-64-43)];
    Dview.backgroundColor= [UIColor redColor];
    [_scrollView1 addSubview:Dview];
                                                                
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth,deviceScreenHeight-64-43)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.backgroundColor=[UIColor grayColor];
    [Dview addSubview:_tableView];
    
    UIView * Yview = [[UIView alloc]initWithFrame:CGRectMake(deviceScreenWidth, 0, deviceScreenWidth,deviceScreenHeight-64-43)];
    Yview.backgroundColor= [UIColor greenColor];
    [_scrollView1 addSubview:Yview];
    
    _tableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth,deviceScreenHeight-64-43)];
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    //_tableView1.backgroundColor=[UIColor grayColor];
    [Yview addSubview:_tableView1];
    [self.view addSubview:_scrollView1];
    //添加KVO
    [_scrollView1 addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark - 监听scrollow滑动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == _scrollView1 && [keyPath isEqualToString:@"contentOffset"]) {
        //获取contentOffset
        NSValue * pointValue = change[@"new"];
        CGFloat point;
        [pointValue getValue:&point];
        //NSLog(@"%lf",point);
        viewline.frame=CGRectMake((point/(375/SCREEN_RATE))*(375/SCREEN_RATE/2), 40, 375/SCREEN_RATE/2, 5);
        if(point/(375/SCREEN_RATE)==0){
            [Dbutton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
            [Ybutton setTitleColor:[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
        }else if(point/(375/SCREEN_RATE)==1){
            [Ybutton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
            [Dbutton setTitleColor:[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
        }
    }
}
#pragma mark -按钮点击
-(void)onclick:(UIButton*)send{
       switch (send.tag) {
        case 100:
               _scrollView1.contentOffset=CGPointMake(self.view.frame.size.width*(send.tag-100), 0);
               viewline.frame=CGRectMake((send.tag-100)*(375/SCREEN_RATE/2), 40, 375/SCREEN_RATE/2, 5);
               [Dbutton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
               [Ybutton setTitleColor:[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        case 101:
                _scrollView1.contentOffset=CGPointMake(self.view.frame.size.width*(send.tag-100), 0);
                viewline.frame=CGRectMake((send.tag-100)*(375/SCREEN_RATE/2), 40, 375/SCREEN_RATE/2, 5);
                [Ybutton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
                [Dbutton setTitleColor:[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
-(void)back:(UIButton*)send{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -taleview代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:_tableView]){
    return  _DArray.count;
    }else{
    return  _YArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95/SCREEN_RATE;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DapprovCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[DapprovCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    if([tableView isEqual:_tableView]){
    [cell setCellWithModel:_DArray[indexPath.row]];
    }else{
    [cell setCellWithModel1:_YArray[indexPath.row]];
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DapprovCell * cell= [tableView cellForRowAtIndexPath:indexPath];
    
if([tableView isEqual:_tableView]){
    ApprovFlightVC * afvc =[ApprovFlightVC new];
    afvc.DandYStr=@"D";
    DapprovModel * model = [DapprovModel new];
    model=_DArray[indexPath.row];
    afvc.orderStr=model.orderNo;
    if([cell.orderType isEqualToString:@"机票"]){
        //机票
        afvc.orderType=cell.orderType;
    }else if([cell.orderType isEqualToString:@"火车票"]){
        afvc.orderType=cell.orderType;
    }else{
        afvc.orderType=cell.orderType;
    }
    
  [self.navigationController  pushViewController:afvc animated:YES];
   //[self presentViewController:afvc animated:NO completion:nil];

}else{
    ApprovFlightVC * afvc =[ApprovFlightVC new];
    DapprovModel * model = [DapprovModel new];
    model=_YArray[indexPath.row];
    afvc.orderStr=model.orderNo;
    afvc.DandYStr=@"Y";
        if([cell.orderType isEqualToString:@"机票"]){
            //机票
            afvc.orderType=cell.orderType;
        }else if([cell.orderType isEqualToString:@"火车票"]){
            afvc.orderType=cell.orderType;
        }else{
            afvc.orderType=cell.orderType;
        }
    
    [self.navigationController  pushViewController:afvc animated:YES];

//    [self presentViewController:afvc animated:NO completion:nil];
    }
}
-(void)dealloc{
    [_scrollView1 removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
