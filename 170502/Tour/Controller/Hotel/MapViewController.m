//
//  MapViewController.m
//  Tour
//
//  Created by Euet on 17/4/5.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "MapViewController.h"
#import "hotelmssModel.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"

#import "YWRoundAnnotationView.h"
#import "YWPointAnnotation.h"

#define YWidth [UIScreen  mainScreen].bounds.size.width
#define YWHeight [UIScreen  mainScreen].bounds.size.height
#define kCalloutViewMargin          -8


@interface MapViewController ()<BMKMapViewDelegate,CLLocationManagerDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate>
{
    
    BMKMapView* mapView;
    BMKLocationService *_locService;
    BMKPointAnnotation *_annotation;                  //声明一个标注
    BMKMapManager *_mapManager;                         //声明一个地图管理


}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"酒店-地图";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    

    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-64)]; //这里可以给屏幕的宽高
    [self.view addSubview:mapView];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    mapView.delegate=self;
    //启动LocationService
    [_locService startUserLocationService];
    
    // 在地图中添加一个PointAnnotation
    
    _annotation = [[BMKPointAnnotation alloc]init];
    
    _annotation.title = @"我的位置";
    [mapView addAnnotation:_annotation];
    NSMutableArray * arrmap = [NSMutableArray new];
    hotelmssModel * model =[hotelmssModel new];
    model=_arr[0];
    for (hotelmssModel * model  in _arr) {
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [model.latitude doubleValue];
        coor.longitude =[model.longitude doubleValue];
        YWPointAnnotation* annotation = [[YWPointAnnotation alloc]initWithCoordinate:coor];
//        annotation.titlelable=model.hotelName;
        annotation.title =model.hotelName;
        
        annotation.coordinate = coor;
        [ arrmap addObject:annotation];
//        [mapView addAnnotation:annotation];
        [mapView selectAnnotation:annotation animated:NO];
    }
    [mapView addAnnotations:arrmap];
}

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    
        if (userLocation != nil) {
        NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
//                //将地图移动到当前位置
//                float zoomLevel = 0.02;
//                BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate,BMKCoordinateSpanMake(zoomLevel, zoomLevel));
//                [mapView setRegion:[mapView regionThatFits:region] animated:YES];
//        
                //大头针摆放的坐标，必须从这里进行赋值，否则取不到值 ，这里可能涉及到委托方法执行顺序的问题
        
        CLLocationCoordinate2D coor;
        coor.latitude = userLocation.location.coordinate.latitude;
        coor.longitude = userLocation.location.coordinate.longitude;
        _annotation.coordinate = coor;
        mapView.centerCoordinate=coor;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapView.delegate = nil; // 不用时，置nil
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        newAnnotationView.draggable = YES;
//        return newAnnotationView;
//    }
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.animatesDrop = YES;
//        newAnnotationView.annotation = annotation;
//            [mapView selectAnnotation: newAnnotationView.annotation animated:YES];
////        这里我根据自己需要，继承了BMKPointAnnotation，添加了标注的类型等需要的信息
//        CustomAnnotation *tt = (CustomAnnotation *)annotation;
//        
////        判断类别，需要添加不同类别，来赋予不同的标注图片
////        if (tt.profNumber == 100000) {
////            newAnnotationView.image = [UIImage imageNamed:@"ic_map_mode_category_merchants_normal.png"];
////        }else if (tt.profNumber == 100001){
////            
////        }
//        //设定popView的高度，根据是否含有缩略图
//        double popViewH = 60;
//        if (annotation.subtitle == nil) {
//            popViewH = 38;
//        }
//        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, popViewH)];
//        popView.backgroundColor = [UIColor whiteColor];
//        [popView.layer setMasksToBounds:YES];
//        [popView.layer setCornerRadius:3.0];
//        popView.alpha = 0.9;
//                //设置弹出气泡图片
//                UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em"]];
//                image.frame = CGRectMake(0, 160, 50, 60);
//                [popView addSubview:image];
//        //自定义气泡的内容，添加子控件在popView上
//        UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, 160, 30)];
//        driverName.text = annotation.title;
//        driverName.numberOfLines = 0;
//        driverName.backgroundColor = [UIColor redColor];
//        driverName.font = [UIFont systemFontOfSize:15];
//        driverName.textColor = [UIColor blackColor];
//        driverName.textAlignment = NSTextAlignmentLeft;
//        [popView addSubview:driverName];
//        
//        UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(8, 30, 180, 30)];
//        carName.text = annotation.subtitle;
//        carName.backgroundColor = [UIColor clearColor];
//        carName.font = [UIFont systemFontOfSize:11];
//        carName.textColor = [UIColor lightGrayColor];
//        carName.textAlignment = NSTextAlignmentLeft;
//        [popView addSubview:carName];
//        
//        if (annotation.subtitle != nil) {
//            UIButton *searchBn = [[UIButton alloc]initWithFrame:CGRectMake(170, 0, 50, 60)];
//            [searchBn setTitle:@"查看路线" forState:UIControlStateNormal];
//            searchBn.backgroundColor = [UIColor redColor];
//            searchBn.titleLabel.numberOfLines = 0;
//            
//            [searchBn addTarget:self action:@selector(searchLine) forControlEvents:UIControlStateNormal];
//            [popView addSubview:searchBn];
//        }
//        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
//        pView.frame = CGRectMake(0, 0, ScreenWidth-100, popViewH);
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = nil;
//        ((BMKPinAnnotationView*)newAnnotationView).paopaoView = pView;
//        return newAnnotationView;
//    }
    if ([annotation isKindOfClass:[YWPointAnnotation class]])
    {
        YWRectAnnotationView *newAnnotationView =(YWRectAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[ YWRectAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        }
        YWPointAnnotation* Newannotation=(YWPointAnnotation*)annotation;
        newAnnotationView.titleText=[ NSString stringWithFormat:@"%@",Newannotation.title];
                newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = YES;
        return newAnnotationView;
        
    }else if ([ annotation  isKindOfClass:[ BMKPointAnnotation class]]){
        
        YWRoundAnnotationView *newAnnotationView =(YWRoundAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"RoundmyAnnotation"];
        if (newAnnotationView==nil)
        {
            newAnnotationView=[[ YWRoundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RoundmyAnnotation"];
        }
        BMKPointAnnotation* Newannotation=(BMKPointAnnotation*)annotation;
        newAnnotationView.titleText=[ NSString stringWithFormat:@"%@",Newannotation.title ];
        newAnnotationView.countText=[ NSString stringWithFormat:@"%d",arc4random()%1000];
        newAnnotationView.canShowCallout = NO;
        newAnnotationView.draggable = YES;
        return newAnnotationView;
    }
    return nil;
}

/**
  * 当选中一个annotation views时，调用此接口
  * @param mapView 地图View
  * @param view 选中的annotation views
  */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
//        NSLog(@"%@",_menarray);
//        [SVProgressHUD showWithStatus:@"正在加载"];
//        [SVProgressHUD show];
//        
//        hotelMessageVC * hmvc =[hotelMessageVC new];
//        hmvc.menarray=_menarray;
//        hotelmssModel * model =[hotelmssModel new];
//      
//        for (hotelmssModel * model  in _arr) {
//            view.annotation.
//        }
//    
//        NSMutableDictionary * dict1 =[NSMutableDictionary new];
//        [dict1 setValue:_outcity forKey:@"hcity"];
//        [dict1 setValue:model.hotelName forKey:@"hotelName"];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"hostory" object:nil userInfo:dict1];
//        
//        //  NSLog(@"%@",model.hotelId);
//        HotelInfQuery * hiq =[HotelInfQuery new];
//        hiq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
//        hiq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
//        hiq.HotelId=model.hotelId;
//        [Hotel HotelInfQuery:hiq success:^(id data) {
//            [SVProgressHUD dismiss];
//            NSLog(@"%@",data);
//            if([data[@"status"] isEqualToString:@"T"]){
//                hmvc.hotelId=model.hotelId;
//                hmvc.hotelname=model.hotelName;
//                hmvc.datadict=data;
//                [self.navigationController  pushViewController:hmvc animated:YES];
//                //        [self presentViewController:hmvc animated:NO completion:nil];
//            }
//        } failure:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
//        }];
}
/**
 *  选中气泡调用方法
 *  @param mapView 地图
 *  @param view    annotation
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
//    if (tt.shopID) {
//        BusinessIfonUVC *BusinessIfonVC = [[BusinessIfonUVC alloc]init];
//        BusinessIfonVC.shopId = tt.shopID;
//        [self.navigationController pushViewController:BusinessIfonVC animated:YES];
//    }
}

-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
