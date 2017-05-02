//
//  projectChangeVC.m
//  Tour
//
//  Created by Euet on 17/4/20.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "projectChangeVC.h"

@interface projectChangeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * tableView;
    //默认数组源
    NSMutableArray * dataArray;
    //自定义数组源
    NSMutableArray * customArray;


    NSString * customstr;

}
@end
@implementation projectChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"项目";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-64) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:tableView];
    [self loat];

}
-(void)loat{
    dataArray=[NSMutableArray new];
    customArray=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    //项目
    ProjectQueryRequest *  project =[ProjectQueryRequest new];
    project.Start =0;
    project.Count=100;
    project.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    project.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic ProjectQueryRequest:project success:^(id data) {
        NSLog(@"%@",data);
        [SVProgressHUD dismiss];
        dataArray=data[@"projectList"];
        customArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"customArr"];
        [tableView reloadData];
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44/SCREEN_RATE1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return  44/SCREEN_RATE1;
    }else{
        return  0;

    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 44/SCREEN_RATE1)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        UILabel * label=[UILabel new];
        if (section==0) {
            label.text=@"默认项目";
        }else{
            label.text=@"自定义项目";
        }
        label.font=[UIFont systemFontOfSize:13];
        label.adjustsFontSizeToFitWidth=YES;
        label.textColor=UIColorFromRGBA(0x888888, 1.0);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(20/SCREEN_RATE1);
            make.left.equalTo(view).offset(15/SCREEN_RATE);
            make.width.offset(80/SCREEN_RATE);
            make.height.offset(20/SCREEN_RATE1);
        }];
         return view;
   }
//设置组的未视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 44/SCREEN_RATE1)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        UIView * viewline = [UIView new];
        viewline.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
        [view addSubview:viewline];
        [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(0);
            make.left.equalTo(view).offset(0);
            make.width.offset(deviceScreenWidth);
            make.height.offset(1/SCREEN_RATE1);
        }];

        UILabel * label=[UILabel new];
        label.text=@"没有合适的项目？创建一个新的项目";
//        label.adjustsFontSizeToFitWidth=YES;
        label.font=[UIFont systemFontOfSize:14];
        label.textColor=UIColorFromRGBA(0x004284, 1.0);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(11/SCREEN_RATE1);
            make.left.equalTo(view).offset(15/SCREEN_RATE);
            make.width.offset(deviceScreenWidth-15/SCREEN_RATE);
            make.height.offset(20/SCREEN_RATE1);
        }];
        
        UIView * viewline1 = [UIView new];
        viewline1.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
        [view addSubview:viewline1];
        [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(43/SCREEN_RATE1);
            make.left.equalTo(view).offset(0);
            make.width.offset(deviceScreenWidth);
            make.height.offset(1/SCREEN_RATE1);
        }];
        
        UITapGestureRecognizer *tapgg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showff:)];
        [view addGestureRecognizer:tapgg];
        return view;
    }else{
        return 0;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return dataArray.count;
    }else{
        return customArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44/SCREEN_RATE1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    if (indexPath.section==1) {
        cell.textLabel.text=customArray[indexPath.row][@"projectName"];
    }else{
        cell.textLabel.text=dataArray[indexPath.row][@"projectName"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if(_block){
            _block(dataArray[indexPath.row]);
        }
    }else{
        if(_block){
            _block(customArray[indexPath.row]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showff:(UITapGestureRecognizer *)tapgg{
    [AlertViewManager alertWithTitle1:@"温馨提示" message:@"请输入你新建的项目名称" textFieldNumber:1 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:^(UITextField *textField, NSUInteger index) {
        if (index==0) {
            customstr=textField.text;
        }
    } actionHandler:^(UIAlertAction *action, NSUInteger index,NSString*text) {
        if (index==1){
            NSMutableArray * arr =[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"customArr"]];
            NSMutableDictionary * dict  =[NSMutableDictionary new];
            [dict setValue:text forKey:@"projectName"];
            if (arr.count==10) {
                    [arr removeObjectAtIndex:0];
                }
            
                [arr addObject:dict];
                [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"customArr"];
                customArray=[NSMutableArray arrayWithArray:arr];
                [tableView reloadData];
           
            if(_block){
                _block(dict);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
            NSLog(@"%@",text);
        }
    }];
}
-(void)back:(UIButton*)but{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)SelectprijectWithBlock:(SelectprijectBalock)block{
    _block=block;
}

@end
