//
//  trainView.m
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "trainView.h"
#import "LGLCalendarDate.h"
#import "CollectionViewCell1.h"
#import "CollectionViewCell2.h"
#import "CollectionViewCell3.h"
#import "MyFooterView.h"
@interface trainView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MyFooterViewDelegate,CLLocationManagerDelegate>
{
    UILabel * _publie;
    UILabel * _private;
    UIView * view6;
    
    //UIView * changeMen;
    UIButton *_ppbut;
    BOOL pp;
    BOOL oneOrtwo;
    BOOL city;
    
    UIView * _menview;
    // UICollectionView * _menconView;
    NSUserDefaults * TpubAndpri;
    NSUserDefaults * GD;
    //只看高铁
    BOOL gd;
    
    UIView * viewlast;

    
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市


}
@end

@implementation trainView
-(void)initwithview{
    
    _Mendataarr = [NSMutableArray new];
    NSMutableDictionary * mendict = [NSMutableDictionary new];
    [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"] forKey:@"empName"];
    [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"] forKey:@"certNo"];
    [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] forKey:@"certType"];
    [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empId"] forKey:@"empId"];

    [_Mendataarr addObject:mendict];
    [_menconView reloadData];

    _year = [LGLCalendarDate year:[NSDate date]];
    _month = [LGLCalendarDate month:[NSDate date]];
    _day = [LGLCalendarDate day:[NSDate date]];
    _weekstr=[weekday weekdaywithday:_day month:_month year:_year];
    _weekstr1=[weekday weekdaywithday:_day month:_month year:_year];
    UIImageView * headView =[UIImageView new];
    headView.image=[UIImage imageNamed:@"banner-railway.jpg"];
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.offset(self.frame.size.height/3-20);
        make.width.offset(self.frame.size.width);
    }];
    pp=YES;
    TpubAndpri= [NSUserDefaults standardUserDefaults];
    [TpubAndpri setObject:@"1" forKey:@"TpubAndpri"];
    
    GD= [NSUserDefaults standardUserDefaults];
    [GD setObject:@"" forKey:@"GD"];
    headView.userInteractionEnabled=YES;
    _outCitybut = [UIButton new];
    _outCitybut.backgroundColor=[UIColor whiteColor];
    _outCitybut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_outCitybut setTitle:@"出发地" forState:UIControlStateNormal];
    [_outCitybut setTitleColor: [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_outCitybut];
    [_outCitybut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(headView).offset(40);
        make.height.offset(22);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    UIView * view1 = [UIView new];
    view1.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_outCitybut).offset(7);
        make.height.offset(1);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _changebut = [UIButton new];
    city=YES;
    _changebut.tag=999;
    [_changebut addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside ];
    [_changebut setBackgroundImage:[UIImage imageNamed:@"switch-city"] forState:UIControlStateNormal];
    [self addSubview:_changebut];
    [_changebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((self.frame.size.width/2)-15);
        make.bottom.equalTo(headView).offset(45);
        make.height.offset(30);
        make.width.offset(30);
    }];
    _backCitybut = [UIButton new];
    _backCitybut.backgroundColor=[UIColor whiteColor];
    _backCitybut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_backCitybut setTitle:@"目的地" forState:UIControlStateNormal];
    [_backCitybut setTitleColor: [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_backCitybut];
    [_backCitybut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(headView).offset(40);
        make.height.offset(22);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    UIView * view2 = [UIView new];
    view2.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(_outCitybut).offset(7);
        make.height.offset(1);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _dataOutbut=[UIButton new];
    _dataOutbut.tag=1001;
    //_dataOutbut.backgroundColor=[UIColor yellowColor];
    [self addSubview:_dataOutbut];
    [_dataOutbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_outCitybut).offset(55);
        make.height.offset(32);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _dataOutlabel  =[UILabel new];
    NSString * str1=[NSString stringWithFormat:@"%ld",_month];
    NSString * str2=[NSString stringWithFormat:@"%ld",_day];
    if (_month<10) {
        str1=[NSString stringWithFormat:@"0%ld",_month];
    }
    if(_day<10){
        str2=[NSString stringWithFormat:@"0%ld",_day];
    }
    _dataOutlabel.text=[NSString stringWithFormat:@"%@月%@日",str1 ,str2];
//    _dataOutlabel.adjustsFontSizeToFitWidth = YES;
    _dataOutlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    _dataOutlabel.font=[UIFont systemFontOfSize:16];
    [_dataOutbut addSubview:_dataOutlabel];
    [_dataOutlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dataOutbut).offset(5);
        make.top.equalTo(_dataOutbut).offset(5);
        make.height.offset(22);
        make.width.offset((self.frame.size.width-80)/3);
    }];
    _weekOutlabel =[UILabel new];
    _weekOutlabel.text=_weekstr;
    _weekOutlabel.font=[UIFont systemFontOfSize:12];
    _weekOutlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    [_dataOutbut addSubview:_weekOutlabel];
    [_weekOutlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dataOutlabel.mas_right).with.offset(5);
        make.top.equalTo(_dataOutbut).offset(13);
        make.height.offset(11);
        make.width.offset(25);
    }];
   
    UIView * view3 = [UIView new];
    view3.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make. left.equalTo(self).offset(20);
        make.bottom.equalTo(_dataOutbut).offset(7);
        make.height.offset(1);
        make.width.offset(self.frame.size.width-40);
    }];
    
    _seatlabel=[UILabel new];
   _seatlabel.adjustsFontSizeToFitWidth=YES;
//    _seatlabel.font=[UIFont systemFontOfSize:14];
    _seatlabel.text=@"只看高铁/动车";
    _seatlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    [self addSubview:_seatlabel];
    [_seatlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(_dataOutbut).offset(62);
        make.height.offset(22);
        make.width.offset((self.frame.size.width-80)/2-30);
    }];
    _seatbut =[UIButton new];
    _seatbut.tag=226;
    gd=YES;
    [_seatbut addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside ];
    [_seatbut setBackgroundImage:[UIImage imageNamed:@"switch-off"] forState:UIControlStateNormal];
    [self addSubview:_seatbut];
    [_seatbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((self.frame.size.width-80)/2-5);
        make.bottom.equalTo(_dataOutbut).offset(55);
        make.height.offset(22);
        make.width.offset(36);
    }];
    UIView * view4 = [UIView new];
    view4.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_seatlabel).offset(7);
        make.height.offset(1);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _publieview =[UIView new];
    UITapGestureRecognizer *pub1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFpub1:)];
    [_publieview addGestureRecognizer:pub1];
    [self addSubview:_publieview];
    [_publieview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(_dataOutbut).offset(55);
        make.height.offset(32);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _publie=[UILabel new];
    _publie.text=@"因私";
    _publie.textAlignment=NSTextAlignmentCenter;
    //公私字符串的判断
    _publie.textColor=[UIColor grayColor];
    _publie.font=[UIFont systemFontOfSize:16];
    [_publieview addSubview:_publie];
    [_publie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_publieview).offset(5);
        make.top.equalTo(_publieview).offset(10);
        make.height.offset(18);
        make.width.offset(40);
    }];
    _ppbut = [UIButton new];
    _ppbut.tag=666;
    pp=NO;
    [_ppbut setBackgroundImage:[UIImage imageNamed:@"switch-on"] forState:UIControlStateNormal];
    [_ppbut addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    [_publieview addSubview:_ppbut];
    [_ppbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_publie.mas_right).with.offset(5);
        make.top.equalTo(_publieview).offset(10);
        make.height.offset(22);
        make.width.offset(38);
    }];
    _private=[UILabel new];
    _private.text=@"因公";
    _private.textAlignment=NSTextAlignmentCenter;
    _private.textColor=[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1];
    _private.font=[UIFont systemFontOfSize:16];
    [_publieview addSubview:_private];
    [_private mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ppbut.mas_right).with.offset(5);
        make.top.equalTo(_publieview).offset(10);
        make.height.offset(18);
        make.width.offset(40);
    }];
    UIView * view5 = [UIView new];
    view5.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view5];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(_publieview).offset(7);
        make.height.offset(1);
        make.width.offset((self.frame.size.width-80)/2);
    }];
    _changeMen=[UIView new];
    _changeMen.backgroundColor=[UIColor whiteColor];
    [self addSubview:_changeMen];
    [_changeMen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_publieview).offset(55);
        make.height.offset(40);
        make.width.offset(self.frame.size.width-40);
    }];
    UIImageView * menview = [UIImageView new];
    menview.image  = [UIImage imageNamed:@"passenger1"];
    [_changeMen addSubview:menview];
    [menview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(23);
        make.bottom.equalTo(_changeMen).offset(-5);
        make.height.offset(16);
        make.width.offset(20);
    }];
    _menview = [UIView new];
    _menview.backgroundColor=[UIColor whiteColor ];
    [_changeMen addSubview:_menview];
    [_menview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_changeMen).offset(25);
        make.bottom.equalTo(_changeMen).offset(-1);
        make.height.offset(43);
        make.width.offset(self.frame.size.width-90);
    }];
    //设置item的一些属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //设置item的滑动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    UICollectionViewScrollDirectionVertical,
    _menconView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-80, 43) collectionViewLayout:flow];
    //    UICollectionViewScrollDirectionHorizonta
    _menconView.backgroundColor = [UIColor whiteColor];
    //设置复用
    //第一个参数 复用cell类型
    //第二个参数 cell标示
    [_menconView registerClass:[CollectionViewCell1 class] forCellWithReuseIdentifier:@"cellIde"];
    //xib复用方法
    //collectionView registerNib:[] forCellWithReuseIdentifier:<#(NSString *)#>
    _menconView.backgroundColor=[UIColor whiteColor];
    _menconView.delegate = self;
    _menconView.dataSource = self;
    [_menview addSubview:_menconView];
    
    _menbut=[UIButton new];
    [_menbut setBackgroundImage:[UIImage imageNamed:@"disclosure-indicator"] forState:UIControlStateNormal];
    [_changeMen addSubview:_menbut];
    [_menbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-23);
        make.bottom.equalTo(_changeMen).offset(-7);
        make.height.offset(15);
        make.width.offset(7);
    }];
    view6 = [UIView new];
    view6.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [self addSubview:view6];
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_changeMen).offset(7);
        make.height.offset(1);
        make.width.offset(self.frame.size.width-40);
    }];
    _lookupBut=[UIButton new];
    _lookupBut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [_lookupBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lookupBut setTitle:@"查询" forState:UIControlStateNormal];
    _lookupBut.titleLabel.font=[UIFont systemFontOfSize:18];
    [self addSubview:_lookupBut];
    [_lookupBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.bottom.equalTo(_menview).offset(55);
        make.height.offset(40);
        make.width.offset(self.frame.size.width-80);
    }];
    
    viewlast = [[UIView alloc]init];
    [self addSubview:viewlast];
    [viewlast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((self.frame.size.width)/2-(self.frame.size.width-140)/2);
        //                make.bottom.equalTo(_lookupBut).offset(30);
        make.top.mas_equalTo(self.lookupBut.mas_bottom).with.offset(10);
        make.height.offset(30);
        make.width.offset(self.frame.size.width-120);
    }];
    
    
    UICollectionViewFlowLayout *layout1 = [UICollectionViewFlowLayout new];
    layout1.itemSize = CGSizeMake((deviceScreenWidth-140)/2+60, 30);
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing = 2;
    layout1.footerReferenceSize =CGSizeMake(40, 30);
    
    
    _collectionView2= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth-130,30) collectionViewLayout:layout1];
    _collectionView2.backgroundColor = [UIColor whiteColor];
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    _collectionView2.scrollsToTop = NO;
    _collectionView2.showsVerticalScrollIndicator = NO;
    _collectionView2.showsHorizontalScrollIndicator = NO;

    [_collectionView2 registerClass:[MyFooterView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [_collectionView2 registerClass:[CollectionViewCell2 class]forCellWithReuseIdentifier:@"celled"];
    [viewlast addSubview:_collectionView2];
    
    NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"tlookupBut"];
    
    _lastarr=[NSMutableArray arrayWithArray:arr1];
    
       [_collectionView2 reloadData];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]) {
        view6.hidden=NO;
        _changeMen.hidden=NO;
    }else{
        view6.hidden=YES;
        _changeMen.hidden=YES;
    }
    [self locationbut1];
    
}
-(void) showGFpub1:(UITapGestureRecognizer *)pub1{
   
    if(pp==YES){
        [_ppbut setBackgroundImage:[UIImage imageNamed:@"switch-on"] forState:UIControlStateNormal];
        _publie.textColor=[UIColor grayColor];
        _private.textColor=[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]) {
            view6.hidden=NO;
            _changeMen.hidden=NO;
        }else{
            view6.hidden=YES;
            _changeMen.hidden=YES;
        }
        pp=NO;
        [TpubAndpri setObject:@"1" forKey:@"TpubAndpri"];
    }else{
        [_ppbut setBackgroundImage:[UIImage imageNamed:@"switch-on-left"] forState:UIControlStateNormal];
        _publie.textColor=[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1];
        _private.textColor=[UIColor grayColor];
        _changeMen.hidden=YES;
        view6.hidden=YES;
        pp=YES;
        [TpubAndpri setObject:@"2" forKey:@"TpubAndpri"];
        //_publicNo=@"2";
    }
}

-(void)click1:(UIButton*)send{
    NSString * str = [[NSString alloc]init];
    NSString * s = [[NSString alloc]init];
    switch (send.tag) {
        case 666:
            if(pp==YES){
                [_ppbut setBackgroundImage:[UIImage imageNamed:@"switch-on"] forState:UIControlStateNormal];
                _publie.textColor=[UIColor grayColor];
                _private.textColor=[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1];
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]) {
                    view6.hidden=NO;
                    _changeMen.hidden=NO;
                }else{
                    view6.hidden=YES;
                    _changeMen.hidden=YES;
                }
                pp=NO;
                [TpubAndpri setObject:@"1" forKey:@"TpubAndpri"];
            }else{
                [_ppbut setBackgroundImage:[UIImage imageNamed:@"switch-on-left"] forState:UIControlStateNormal];
                _publie.textColor=[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1];
                _private.textColor=[UIColor grayColor];
                _changeMen.hidden=YES;
                view6.hidden=YES;
                pp=YES;
                [TpubAndpri setObject:@"2" forKey:@"TpubAndpri"];
                //_publicNo=@"2";
            }
            break;
        case 226:
            if(gd==YES){
                gd=NO;
                [GD setObject:@"G,D" forKey:@"GD"];
                [_seatbut setBackgroundImage:[UIImage imageNamed:@"switch-on"] forState:UIControlStateNormal];
            }else{
                gd=YES;
                [GD setObject:@"" forKey:@"GD"];
                 [_seatbut setBackgroundImage:[UIImage imageNamed:@"switch-off"] forState:UIControlStateNormal];
            }
            break;
        case 802:
            break;
        case 999:
        {
            str = _outCitybut.titleLabel.text;
            s = _backCitybut.titleLabel.text;
            if (![str isEqualToString:@"出发城市"]&&![s isEqualToString:@"到达城市"]) {
                [_outCitybut setTitle:s forState:UIControlStateNormal];
                [_backCitybut setTitle:str forState:UIControlStateNormal];
            }
            break;
        }
        default:
            break;
    }
}
//一组返回item数量
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:_menconView]) {
        return _Mendataarr.count;
    }else{
        return _lastarr.count;
    }
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
//    CollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde" forIndexPath:indexPath];
//    //    cell.backgroundColor=[UIColor redColor];
//    cell.str.font=[UIFont systemFontOfSize:12];
//    cell.str.text=_Mendataarr[indexPath.row][@"empName"];
//
    if ([collectionView isEqual:_menconView]) {
        //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
        CollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIde" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor redColor];
        cell.str.font=[UIFont systemFontOfSize:12];
        cell.str.text=_Mendataarr[indexPath.row][@"empName"];
        return cell;
    }else{
        //去复用队列里找 有没有空闲的cell 如果没有 就自动创建一个
        CollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celled" forIndexPath:indexPath];
        
        //        CollectionViewCell3 *cell1 = (CollectionViewCell3*)[collectionView  dequeueReusableCellWithReuseIdentifier:@"celled" forIndexPath:indexPath];
        
        cell.backgroundColor=[UIColor whiteColor];
        
        cell.str.font=[UIFont systemFontOfSize:12];
        
        cell.str.text=[NSString stringWithFormat:@" %@   - - - - -  %@",_lastarr[indexPath.row][@"outCityname"],_lastarr[indexPath.row][@"backCityname"]];
        return cell;
    }
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //[_dataArray1 removeObjectAtIndex:indexPath.row];
    NSLog(@"indexPath.row = %ld",indexPath.row);
    if ([collectionView isEqual:_collectionView2]) {
        [_outCitybut setTitle:_lastarr[indexPath.row][@"outCityname"] forState:UIControlStateNormal];
        [_backCitybut setTitle:_lastarr[indexPath.row][@"backCityname"] forState:UIControlStateNormal];
    }
}
//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_menconView]) {
        return [framsizeclass newCGSize:CGSizeMake(40, 25)];
    }else{
        return CGSizeMake((deviceScreenWidth-140)/2+60, 30);
    }
}
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([collectionView isEqual:_menconView]) {
        //表示距上，左，下，右边界的距离
        return [framsizeclass newUIEdgeInsets:UIEdgeInsetsMake(20,20,5,20)];
    }else{
        return [framsizeclass newUIEdgeInsets:UIEdgeInsetsMake(15,30,15,30)];
    }
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        MyFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer"forIndexPath:indexPath];
        footerView.delegate=self;
        NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"tlookupBut"];
        if (arr1.count != 0) {
            footerView.titleLab.text =@"清空";
        } else {
            footerView.titleLab.text =@"";
        }
        footerView.titleLab.font=[UIFont systemFontOfSize:11];
        reusableView = footerView;
        return footerView;
    }
    return nil;
}
-(void)bookbutClick:(MyFooterView *)foot{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tlookupBut"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"tlookupBut"];
    
    _lastarr=[NSMutableArray arrayWithArray:arr1];
    //  viewlast.hidden=YES;
    [_collectionView2 reloadData];
}
-(void)locationbut1{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager startUpdatingLocation];
    }else{
        [UIAlertView showAlertWithTitle1:@"请打开定位服务" duration:1.2];
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
}
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(省)  SubLocality(区)
            NSLog(@"555%@", test[@"City"]);
            NSMutableString * text =test[@"City"];
            NSString * city=[text substringToIndex:2];
           
            [SVProgressHUD dismiss];
            
            [locationManager stopUpdatingLocation];
            
            [_outCitybut setTitle:city forState:UIControlStateNormal];
        }
    }];
}


@end
