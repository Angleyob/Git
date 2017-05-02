//
//  AttentionCell.m
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "AttentionCell.h"

@implementation AttentionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    UIView * view = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 3, 375, 140)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:view];
    
    _dateLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 5, 150, 16)]];
    _dateLabel.font=[UIFont systemFontOfSize:14];
    _dateLabel.textColor=UIColorFromRGBA(0x9b9b9b, 1.0);
    [view addSubview:_dateLabel];
    
    _dayLabel=[[UILabel alloc]init];
    _dayLabel.textColor=UIColorFromRGBA(0x9b9b9b, 1.0);
    _dayLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20/SCREEN_RATE);
        make.top.equalTo(view).offset(5/SCREEN_RATE1);
        make.height.offset(16/SCREEN_RATE1);
        make.width.offset(34/SCREEN_RATE);
    }];

    _lineimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 29, 345, 2)]];
    _lineimage.image=[UIImage imageNamed:@"11"];
    [view addSubview:_lineimage];
    
    _flightlogoimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 43, 15, 13)]];
    _flightlogoimage.image=[UIImage imageNamed:@""];
    [view addSubview:_flightlogoimage];

    _ywlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(173, 96, 28, 16)]];
    [view addSubview:_ywlabel];
    
    _flightnumLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(35, 39, 150, 16)]];
    _flightnumLabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    _flightnumLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:_flightnumLabel];

    
    _fromtimeLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 66, 59, 24)]];
    [view addSubview:_fromtimeLabel];

    
    _syLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(78, 66, 12, 24)]];
    _syLabel.font=[UIFont systemFontOfSize:8];
    _syLabel.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];

    //自动折行设置
    _syLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _syLabel.numberOfLines = 0;
    [view addSubview:_syLabel];
    
    _syLabel1=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(285, 66, 12, 24)]];
    _syLabel1.font=[UIFont systemFontOfSize:8];
    _syLabel1.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];

    //自动折行设置
    _syLabel1.lineBreakMode =NSLineBreakByWordWrapping;
    _syLabel1.numberOfLines = 0;
    [view addSubview:_syLabel1];
    
    _flystatusimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(124, 71, 138, 21)]];
    _flystatusimage.image=[UIImage imageNamed:@""];
    [view addSubview:_flystatusimage];

    
    _totimeLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(301, 66, 59, 24)]];
    
    [view addSubview:_totimeLabel];

    _fromcityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 93, 83, 16)]];
    _fromcityLabel.font=[UIFont systemFontOfSize:14];

    [view addSubview:_fromcityLabel];
    
//    _tocityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(332, 93, 83, 16)]];
//    _tocityLabel.font=[UIFont systemFontOfSize:14];
//    _tocityLabel.textAlignment=NSTextAlignmentRight;
//    [view addSubview:_tocityLabel];
    
    _tocityLabel=[[UILabel alloc]init];
        _tocityLabel.font=[UIFont systemFontOfSize:14];
        _tocityLabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:_tocityLabel];
    [_tocityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15/SCREEN_RATE);
        make.top.equalTo(view).offset(93/SCREEN_RATE1);
        make.height.offset(16/SCREEN_RATE1);
        make.width.offset(83/SCREEN_RATE);
    }];

    _fromflycityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 113, 143, 14)]];
    
    _fromflycityLabel.font=[UIFont systemFontOfSize:12];
    _fromflycityLabel.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];

    [view addSubview:_fromflycityLabel];
    _toflycityLabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(223, 113, 143, 14)]];
    _toflycityLabel.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    _toflycityLabel.textAlignment=NSTextAlignmentRight;
    _toflycityLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:_toflycityLabel];
  }
-(void)setCellWithModel:(AttentionModel *)app{

    NSString * weekstr= [weekday weekdaywith1:app.flightDate];
    
    _dateLabel.text=[NSString stringWithFormat:@"%@  %@",app.flightDate,weekstr];
    
    
    //获取当前时间并转换
    NSDate * date1 = [NSDate date];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate * day1 =[dateFormatter1 dateFromString:app.flightDate];
    
    NSInteger da = [weekday getDaysFrom:date1 To:day1];
    if (da==0) {
        _dayLabel.text=@"今天";
    }else if(da==1){
        _dayLabel.text=@"今天";
    }else {
        _dayLabel.text=@"";
    }

    _fromcityLabel.text=app.departCityName;
    _tocityLabel.text=app.arriveCityName;
    
    if ([app.flightStatus isEqualToString:@"0"]) {
        _flystatusimage.image=[UIImage imageNamed:@"state_to_take_off"];
    }else if ([app.flightStatus isEqualToString:@"1"]){
        _flystatusimage.image=[UIImage imageNamed:@"state_wait_fly"];
    }else if ([app.flightStatus isEqualToString:@"2"]){
        _flystatusimage.image=[UIImage imageNamed:@"state_in_flight"];
    }
    else if ([app.flightStatus isEqualToString:@"3"]){
        _flystatusimage.image=[UIImage imageNamed:@"state_cancel"];
    }
    else if ([app.flightStatus isEqualToString:@"4"]){
        _flystatusimage.image=[UIImage imageNamed:@"state_to_take_off"];
    }else{
        
    }
    if ([app.delayedStatus isEqualToString:@"1"]) {
           _ywlabel.text=@"延误";
            _ywlabel.textColor=[UIColor colorWithRed:244/255.0 green:165/255.0 blue:54/255.0 alpha:1];
    }
    
    _flightlogoimage.image=[UIImage imageNamed:app.airwayId];
    _flightnumLabel.text=[NSString stringWithFormat:@"%@ %@",app.airwayName,app.flightNo];
    if ([app.flightStatus isEqualToString:@"2"]||[app.flightStatus isEqualToString:@"3"]) {
        _syLabel.text=@"实际";
        _syLabel1.text=@"实际";
        _fromtimeLabel.text=app.realTimes;
        _totimeLabel.text=app.realTimee;
    }else{
        _syLabel.text=@"预计";
        _syLabel1.text=@"预计";
        _fromtimeLabel.text=app.callTimes;
        _totimeLabel.text=app.calTimee;
    }
    _fromflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.departName,app.arrt];
    _toflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.arrName,app.arrt];
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
