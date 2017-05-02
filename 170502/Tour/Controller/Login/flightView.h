//
//  flightView.h
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flightView : UIView

@property(nonatomic,strong)UIButton*onebut;
@property(nonatomic,strong)UIButton*twobut;
@property(nonatomic,strong)UIButton*outCitybut;
@property(nonatomic,strong)UIButton*backCitybut;
@property(nonatomic,strong)UIButton*changebut;
@property(nonatomic,strong)UIButton*dataOutbut;
@property(nonatomic,strong)UIButton*databackbut;
@property(nonatomic,strong)UIButton*seatbut;

@property(nonatomic,strong)UIView*publieview;

@property(nonatomic,strong)UIButton*publiebut;
@property(nonatomic,strong)UIButton*menbut;
@property(nonatomic,strong)UIButton*lookupBut;

@property(nonatomic,strong)UILabel*outCitylabel;
@property(nonatomic,strong)UILabel*backCitylabel;

@property(nonatomic,strong)UILabel*databacklabel;
@property(nonatomic,strong)UILabel*datacha;
@property(nonatomic,strong)UILabel*dataOutlabel;

@property(nonatomic,strong)UILabel*weekOutlabel;
@property(nonatomic,strong)UILabel*weekbacklabel;


@property(nonatomic,strong)UILabel*seatlabel;
@property(nonatomic,strong)UILabel*menlabel;
@property(nonatomic,strong)UILabel*oldlabel;

@property(nonatomic,strong)UILabel*twoDaylabel;

@property(nonatomic,strong)UILabel * histotyLabel;

@property(nonatomic,strong)UIView * changeMen;


@property(nonatomic,copy)NSString* str;
@property(nonatomic,copy)NSString* cityOutstr;
@property(nonatomic,copy)NSString* cityBackstr;

@property(nonatomic,copy)NSString* weekstr;
@property(nonatomic,copy)NSString* weekstr1;


@property(nonatomic,assign)NSInteger day;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger year;

@property(nonatomic,assign)NSString * publicNo;
@property(nonatomic,copy)NSMutableArray * Mendataarr;
@property(nonatomic,strong)UICollectionView * menconView;
@property(nonatomic,strong) UICollectionView *collectionView2;
@property(nonatomic,copy)NSMutableArray * lastarr;

-(void)initwithview;
@end
