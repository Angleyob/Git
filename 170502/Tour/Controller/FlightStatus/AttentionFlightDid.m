//
//  AttentionFlightDid.m
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "AttentionFlightDid.h"
#import "AttentionCell.h"

@interface AttentionFlightDid ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView * _TableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _dataArray1;
    UIImageView * image;
    UIView * viewq;
}

@end

@implementation AttentionFlightDid
-(void)viewWillAppear:(BOOL)animated{
    if (_dataArray.count!=0) {
        [self loadata];
    }  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self creatTable];
//    [self loadata];
}
-(void)loadata{
//    _dataArray=[NSMutableArray new];
//    _dataArray1=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;
    AttentionFlightScheduleListQuery * atf = [AttentionFlightScheduleListQuery new];
    atf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    atf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    atf.Count=100;
    atf.Start=0;
    atf.PhoneNumber=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"mobile"];
    [Flight AttentionFlightScheduleListQuery:atf success:^(id data) {
        self.view.userInteractionEnabled=YES;
        
//    [ZYZModelTool modelToolWithDictionary:data[@"data"][0] modelName:@"AttentionModel.h"];

    [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        [_dataArray removeAllObjects];
        [_dataArray1 removeAllObjects];
        if ([data[@"status"] isEqualToString:@"T"]) {
            
            for (NSMutableDictionary * dic in data[@"data"]) {
                [_dataArray1 addObject:dic];
                AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
                [ _dataArray addObject:model];
            }
            if (_dataArray.count==0) {
                viewq.hidden=NO;
            }else{
                viewq.hidden=YES;
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
//        NSLog(@"%@",_dataArray1);
        [_TableView reloadData];
        
    } failure:^(NSError *error) {
    self.view.userInteractionEnabled=YES;
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)initview{
    _dataArray=[NSMutableArray new];
    _dataArray1=[NSMutableArray new];
}
-(void)creatTable{
    _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, self.view.frame.size.width, self.view.frame.size.height-100)];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_TableView];
  
    viewq= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    viewq.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    image = [[UIImageView alloc] initWithFrame:CGRectMake(50/SCREEN_RATE,117/SCREEN_RATE1, 280/SCREEN_RATE, 225/SCREEN_RATE1)];
    image.image=[UIImage imageNamed:@"empty_page"];
    [viewq addSubview:image];
    [self.view addSubview:viewq];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146/SCREEN_RATE1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[AttentionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.backgroundColor=[UIColor blackColor];
    cell.celldict=_dataArray1[indexPath.row];
    
    [cell setCellWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    StatusMessageVC * smvc = [StatusMessageVC new];
    smvc.dict=_dataArray1[indexPath.row];
     [self presentViewController:smvc animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
