//
//  statusMessageCell.m
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "statusMessageCell.h"

@implementation statusMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    _flightlogoimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 10, 15, 13)]];
    [self.contentView addSubview:_flightlogoimage];
    
    _flightnum=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(35, 10, 143, 16)]];
    _flightnum.adjustsFontSizeToFitWidth=YES;
    _flightnum.font=[UIFont systemFontOfSize:14];
    _flightnum.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [self.contentView addSubview:_flightnum];

    _flydate=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(240, 10, 120, 16)]];
    _flydate.adjustsFontSizeToFitWidth=YES;
    _flydate.font=[UIFont systemFontOfSize:14];
    _flydate.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [self.contentView addSubview:_flydate];
    
    _fly1=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(16, 71, 20, 10)]];
    [self.contentView addSubview:_fly1];
    
    _fly2=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(341, 71, 20, 10)]];
    [self.contentView addSubview:_fly2];
    
    _fromcity=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(43, 58, 52, 26)]];
    _fromcity.adjustsFontSizeToFitWidth=YES;
    _fromcity.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_fromcity];
    
    _tocity=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(283, 58, 52, 26)]];
    _tocity.adjustsFontSizeToFitWidth=YES;
    _tocity.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_tocity];

    
    _fromflycity=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(26, 91, 120, 26)]];
//    _fromflycity.adjustsFontSizeToFitWidth=YES;
    _fromflycity.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_fromflycity];
    
    _toflycity=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(225, 91, 120, 26)]];
//    _toflycity.adjustsFontSizeToFitWidth=YES;
    _toflycity.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_toflycity];
    
    _flystatusimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(119, 75, 138, 20)]];
    [self.contentView addSubview:_flystatusimage];
    
    UIView * viewline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(21, 125, 333, 2)]];
    viewline.backgroundColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    [self.contentView addSubview:viewline];

    _ZDlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(154, 137, 67, 14)]];
    _ZDlabel.adjustsFontSizeToFitWidth=YES;
    _ZDlabel.font=[UIFont systemFontOfSize:13];
    _ZDlabel.textColor=UIColorFromRGBA(0x9b9b9b, 1.0);
    [self.contentView addSubview:_ZDlabel];
    
    
    _planlabel1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 167, 64, 34)]];
    _planlabel1.numberOfLines = 0;
    _planlabel1.adjustsFontSizeToFitWidth=YES;
    _planlabel1.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_planlabel1];
    
    _planlabel2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(292, 167, 64, 34)]];
    _planlabel2.numberOfLines = 0;
    _planlabel2.textAlignment=NSTextAlignmentRight;
    _planlabel2.adjustsFontSizeToFitWidth=YES;
    _planlabel2.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_planlabel2];

    _realtime1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 209, 48, 14)]];
    _realtime1.text=@"实际出发";
    _realtime1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_realtime1];
    
    _realtime2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(225, 209, 48, 14)]];
    _realtime2.text=@"实际到达";
    _realtime2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_realtime2];
    
    _startime= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 226, 64, 24)]];
    _startime.text=@"__:__";
    _startime.adjustsFontSizeToFitWidth=YES;
    _startime.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_startime];
    
    _stoptime= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(225, 226, 64, 24)]];
    _stoptime.text=@"__:__";
    _stoptime.adjustsFontSizeToFitWidth=YES;
    _stoptime.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_stoptime];
    
    _lineimage= [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(187, 167, 2, 151)]];
    _lineimage.image=[UIImage imageNamed:@"11"];
    [self.contentView addSubview:_lineimage];

    
    _seat1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(114, 209, 36, 14)]];
    _seat1.text=@"航站楼";
    _seat1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_seat1];
    
    _seat2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(319, 209, 36, 14)]];
    _seat2.text=@"航站楼";
    _seat2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_seat2];
    
    _seatId1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(114, 226, 27, 24)]];
    _seatId1.text=@"__";
    _seatId1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_seatId1];
    
    _seatId2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(319, 226, 27, 24)]];
    _seatId2.text=@"__";
    _seatId2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_seatId2];

    _weather1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(45, 276, 62, 16)]];
    _weather1.text=@"大雨转小雨";
    _weather1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_weather1];
    
    _weather2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(295, 276, 62, 16)]];
    _weather2.text=@"大雨转小雨";
    _weather2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_weather2];

    _weatherImage1= [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 276, 20, 20)]];
    _weatherImage1.image=[UIImage imageNamed:@""];
    
    [self.contentView addSubview:_weatherImage1];
    _weatherImage2= [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(270, 276, 20, 20)]];
    _weatherImage2.image=[UIImage imageNamed:@""];
    
    [self.contentView addSubview:_weatherImage2];

    _temp1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 298, 68, 16)]];
    _temp1.text=@"28℃-28℃";
    _temp1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_temp1];
    
    _temp2= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(287, 298, 68, 16)]];
    _temp2.text =@"28℃-28℃";
    _temp2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_temp2];

    UIView * view1= [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 340, 375, 72)]];
    view1.backgroundColor=[UIColor colorWithRed:254/255.0 green:246/255.0 blue:222/255.0 alpha:1];
    [self.contentView addSubview:view1];
    
    _TSmessage= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 9, 353, 52)]];
    _TSmessage.text =@"温馨提示：航班动态信息仅供参考，请以机场实时通知为准；通过关注航班动态，该航班动态发生异动时，我们将会短信通知您.";
    _TSmessage.textColor=[UIColor colorWithRed:193/255.0 green:171/255.0 blue:132/255.0 alpha:1];
    _TSmessage.font=[UIFont systemFontOfSize:12];
    //自动折行设置
    _TSmessage.lineBreakMode =NSLineBreakByWordWrapping;
    _TSmessage.numberOfLines = 0;
    [view1 addSubview:_TSmessage];
}
-(void)setCellWithModel:(AttentionModel *)app{
    
    _flightnum.text=[NSString stringWithFormat:@"%@ %@",app.airwayName,app.flightNo];
    _flydate.text=app.flightDate;
    _flightlogoimage.image=[UIImage imageNamed:app.airwayId];
    _tocity.text=app.arriveCityName;
    _fromcity.text=app.departCityName;
    _fly1.image=[UIImage imageNamed:@"start"];
    _fly2.image=[UIImage imageNamed:@"end"];
    _toflycity.text=app.arrName;
    _fromflycity.text=app.departName;
    _ZDlabel.text=[NSString stringWithFormat:@"准点率%.0lf%@",[app.punctualityRate floatValue]*100,@"%"];
    
    _planlabel1.text=[NSString stringWithFormat:@"计划起飞\n%@/%@ %@",[app.flightDate substringWithRange:NSMakeRange(6, 2)],[app.flightDate substringWithRange:NSMakeRange(8, 2)],app.planTimes];
     _planlabel2.text=[NSString stringWithFormat:@"计划降落\n%@/%@ %@",[app.flightDate substringWithRange:NSMakeRange(6, 2)],[app.flightDate substringWithRange:NSMakeRange(8, 2)],app.planTimee];
    
    if ([app.realTimee isEqualToString:@""]) {
        _stoptime.text=@"__:__";
    }else{
        _stoptime.text=  app.realTimee;
    }
    if ([app.realTimes isEqualToString:@""]) {
        _startime.text=@"__:__";
    }else{
        _startime.text=  app.realTimes;
    }
    
    if ([app.dept isEqualToString:@""]) {
        _seatId1.text=@"__";
    }else{
        _seatId1.text=  app.dept;
    }
    if ([app.arrt isEqualToString:@""]) {
        _seatId2.text=@"__";
    }else{
        _seatId2.text=  app.arrt;
    }

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
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
