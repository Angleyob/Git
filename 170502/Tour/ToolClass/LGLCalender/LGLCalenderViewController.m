//
//  LGLCalenderViewController.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLCalenderViewController.h"
#import "FirstViewController.h"
#import "LGLCalenderCell.h"
#import "LGLHeaderView.h"
#import "LGLCalenderModel.h"
#import "LGLCalenderSubModel.h"
#import "LGLCalendarDate.h"
#import "LGLWeekView.h"
//#import "UIAlertView+show.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LGLCalenderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    
//    NSIndexPath * _number;
   

}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableDictionary *cellDic; // 用来存放Cell的唯一标示符
@end

@implementation LGLCalenderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initOtherData];
    [self addHeaderWeekView];
    [self getData];
    [self createCalendarView];
    
}
- (void)addHeaderWeekView {
    LGLWeekView * week = [[LGLWeekView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    [self.view addSubview:week];
}
- (void)initOtherData {
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"日期选择";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 13, 20)];
    [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    //获取当前的年月日
     _year = [LGLCalendarDate year:[NSDate date]];
     _month = [LGLCalendarDate month:[NSDate date]];
     _day = [LGLCalendarDate day:[NSDate date]];
    if (!_day1) {
        _year1 = _year;
        _month1 = _month;
        _day1 = _day;
    }
}

-(void)back:(UIButton*)send{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createCalendarView
{
      //布局
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //设置item的宽高
    layout.itemSize=CGSizeMake(WIDTH / 7-5, WIDTH/ 7-5);
    //设置滑动方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置行间距
    layout.minimumLineSpacing=5.0f;
    //每列的最小间距
    layout.minimumInteritemSpacing = 0.5f;
    //四周边距
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, WIDTH, HEIGHT - 104) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.collectionView];
   // [self.collectionView registerClass:[LGLCalenderCell class] forCellWithReuseIdentifier:@"calender"];
    [self.collectionView registerClass:[LGLHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView"];
}
- (void)getData {
    [LGLCalenderModel getCalenderDataWithDate:[NSDate date] block:^(NSMutableArray *result) {
        [self.dataSource addObjectsFromArray:result];
        [self.collectionView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    LGLCalenderModel * model = self.dataSource[section];
    return model.details.count + model.firstday;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld +++++ %ld",_number.section,_number.row);
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"LGLCalenderCell%@", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.collectionView registerClass:[LGLCalenderCell class]  forCellWithReuseIdentifier:identifier];
    }
    
    LGLCalenderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            if (self.dataSource.count) {
         LGLCalenderModel * model = self.dataSource[indexPath.section];
        if (indexPath.item >= model.firstday) {
            NSInteger index = indexPath.item - model.firstday;
            LGLCalenderSubModel * subModel = model.details[index];
            if((model.year == _year1) && (model.month == _month1) && (subModel.day == _day1)){
                [cell setBackgroundColor:[UIColor redColor]];
                cell.layer.masksToBounds = YES;
                cell.layer.cornerRadius = (WIDTH / 7-7)/2;
                cell.backgroundColor =  LGLColor(65, 207, 79);
                
            }else{
                [cell setBackgroundColor:[UIColor whiteColor]];
            }
            cell.dateL.text = [NSString stringWithFormat:@"%ld",(long)subModel.day];
            cell.priceL.text = [NSString stringWithFormat:@"￥%@", subModel.price];
            if ((model.year == _year) && (model.month == _month) && (subModel.day == _day))  {
//                cell.layer.masksToBounds = YES;
//                cell.layer.cornerRadius = (WIDTH / 7) / 2;
//                cell.backgroundColor =  LGLColor(65, 207, 79);
                        }
            if ((model.year == _year) && (model.month == _month) && (subModel.day < _day)) {
                cell.backgroundColor = LGLColor(214, 214, 214);
                cell.dateL.textColor = [UIColor lightGrayColor];
                cell.userInteractionEnabled = NO;
            }
            
        }
    }
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LGLHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView" forIndexPath:indexPath];
    LGLCalenderModel * model = self.dataSource[indexPath.section];
    headerView.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",model.year, model.month];
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    LGLCalenderCell *cell = (LGLCalenderCell*)[collectionView cellForItemAtIndexPath:indexPath];
// [cell setBackgroundColor:[UIColor redColor]];
//    _number=indexPath;
    
    LGLCalenderModel * model = self.dataSource[indexPath.section];
    NSInteger index = indexPath.row - model.firstday;
    LGLCalenderSubModel * subModel = model.details[index];
     _year1 =  model.year;
      _month1 = model.month;
      _day1= subModel.day;
 
    NSDate * d1=  [LGLCalendarDate dateFromString:_sss];
     NSDate * d3=  [LGLCalendarDate dateFromString:_twomothdate];
//    NSLog(@"%@",_sss);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue: [NSString stringWithFormat:@"%ld", (long)model.year] forKey:@"year"];
    [dic setValue: [NSString stringWithFormat:@"%ld", (long)model.month] forKey:@"month"];
    [dic setValue: [NSString stringWithFormat:@"%ld", (long)subModel.day] forKey:@"day"];
    
    NSString * date1 =  [NSString stringWithFormat:@"%@-%@-%@",dic[@"year"] ,dic[@"month"], dic[@"day"]];
    NSDate * d2=  [LGLCalendarDate dateFromString:date1];

    if (![_twomothdate isEqualToString:@""]) {
        NSInteger h=[weekday getDaysFrom:d3 To:d2];
        if (h>0) {
            [UIAlertView showAlertWithTitle:@"航班动态查询日期不能大于2个月，请重新选择。"];
        }else{
            self.block(dic);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
    
    if(_isa == YES ){
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        if(h<0){
            self.block(dic);
            [self dismissViewControllerAnimated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if(_type==1){
            [UIAlertView showAlertWithTitle:@"出发日期不能晚于返程日期，请重新选择。"];
            }else{
            [UIAlertView showAlertWithTitle:@"入住日期不能晚于离店日期，请重新选择。"];
            }
        }
    }
    if (_isa == NO) {
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        if(h>=0){
            self.block(dic);
            [self dismissViewControllerAnimated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if(_type==1){
            [UIAlertView showAlertWithTitle:@"返程日期不能早于出发日期，请重新选择。"];
            }else{
            [UIAlertView showAlertWithTitle:@"离店日期不能早于入住日期，请重新选择。"];

            }
        }
     }
    }
    [_collectionView reloadData];
    [_collectionView reloadData];
}
- (void)seleDateWithBlock:(SelectDateBalock)block {
    self.block = block;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableDictionary *)cellDic {
    if (!_cellDic) {
        _cellDic = [NSMutableDictionary dictionary];
    }
    return _cellDic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
