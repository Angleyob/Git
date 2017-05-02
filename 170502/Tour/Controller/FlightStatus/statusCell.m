//
//  statusCell.m
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "statusCell.h"

@implementation statusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    UIView * view = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 3, 375, 110)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:view];
    
    _flightlogoimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 9, 15, 13)]];
    _flightlogoimage.image=[UIImage imageNamed:@""];
    [view addSubview:_flightlogoimage];
    
    _ywlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(144, 66, 28, 16)]];
    [view addSubview:_ywlabel];
   
    UIView * viewline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(315, 6, 1, 95)]];
    viewline.backgroundColor=UIColorFromRGBA(0xe5e5e5, 1.0);
    [view addSubview:viewline];
    
    _Attentionbut=[[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(317, 0, 58, 110)]];
    [_Attentionbut addTarget:self action:@selector(statusbutClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_Attentionbut];
      _Attentionimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(18, 33, 20, 21)]];
//    _Attentionimage.image=[UIImage imageNamed:@"follow"];
    [_Attentionbut addSubview:_Attentionimage];
    _Attentionlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(4, 58, 47, 16)]];
//    _Attentionlabel.text=@"关注";
    _Attentionlabel.textAlignment=NSTextAlignmentCenter;
    _Attentionlabel.font=[UIFont systemFontOfSize:13];
//  /  _Attentionlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [_Attentionbut addSubview:_Attentionlabel];
    
    _flightnumLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(35, 9, 150, 16)]];
    _flightnumLabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    _flightnumLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:_flightnumLabel];
    
    _fromtimeLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 36, 59, 24)]];
    [view addSubview:_fromtimeLabel];
    
    _flystatusimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(89, 41, 138, 21)]];
    _flystatusimage.image=[UIImage imageNamed:@""];
    [view addSubview:_flystatusimage];
    
    _totimeLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(241, 36, 59, 24)]];
    [view addSubview:_totimeLabel];
    
    _fromcityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 63, 83, 16)]];
    _fromcityLabel.font=[UIFont systemFontOfSize:14];
    
    [view addSubview:_fromcityLabel];
    
    _tocityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(212, 63, 83, 16)]];
    _tocityLabel.font=[UIFont systemFontOfSize:14];
    _tocityLabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:_tocityLabel];
    
    _fromflycityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 82, 143, 14)]];
    
    _fromflycityLabel.font=[UIFont systemFontOfSize:12];
    _fromflycityLabel.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    
    [view addSubview:_fromflycityLabel];
    
    _toflycityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(163, 82, 143, 14)]];
    _toflycityLabel.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    _toflycityLabel.textAlignment=NSTextAlignmentRight;
    _toflycityLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:_toflycityLabel];
}
- (void)statusbutClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(statusbutClick:)]) {
        [self.delegate statusbutClick:self];
    }
}
//-(void)setCellWithModel:(AttentionModel *)app{
//    _fromcityLabel.text=app.departCityName;
//    _tocityLabel.text=app.arriveCityName;
//    _fromtimeLabel.text=app.planTimes;
//    _totimeLabel.text=app.planTimee;
//    _flightlogoimage.image=[UIImage imageNamed:app.airwayId];
//    if ([app.flightStatus isEqualToString:@"0"]) {
//        _flystatusimage.image=[UIImage imageNamed:@"state_to_take_off"];
//    }else if ([app.flightStatus isEqualToString:@"1"]){
//        _flystatusimage.image=[UIImage imageNamed:@"state_wait_fly"];
//    }else if ([app.flightStatus isEqualToString:@"2"]){
//        _flystatusimage.image=[UIImage imageNamed:@"state_in_flight"];
//    }
//    else if ([app.flightStatus isEqualToString:@"3"]){
//        _flystatusimage.image=[UIImage imageNamed:@"state_cancel"];
//    }
//    else if ([app.flightStatus isEqualToString:@"4"]){
//        _flystatusimage.image=[UIImage imageNamed:@"state_to_take_off"];
//    }else{
//    }
//    if ([app.num isEqualToString:@"1"]) {
//        _Attentionimage.image=[UIImage imageNamed:@"followed"];
//        _Attentionlabel.text=@"已关注";
//        _Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
//        _Attentionbut.userInteractionEnabled=NO;
//    }else{
//        _Attentionbut.userInteractionEnabled=YES;
//    }
//    _flightnumLabel.text=[NSString stringWithFormat:@"%@ %@",app.airwayName,app.flightNo];
//    _fromflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.departName,app.arrt];
//    _toflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.arrName,app.arrt];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
