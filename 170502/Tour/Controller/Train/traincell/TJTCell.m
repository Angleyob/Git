//
//  TJTCell.m
//  Tour
//
//  Created by Euet on 17/2/7.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TJTCell.h"

@implementation TJTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    
    _jtoutcity=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(42, 7, 28, 16)]];
    _jtoutcity.textAlignment=NSTextAlignmentCenter;
    _jtoutcity.font=[UIFont systemFontOfSize:14];
    _jtoutcity.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_jtoutcity];
    _view1=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(88, 0, 1, 30)]];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view1];
    
    _jtArrtivecity=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(93, 7, 56, 16)]];
    _jtArrtivecity.adjustsFontSizeToFitWidth=YES;
    _jtArrtivecity.textAlignment=NSTextAlignmentCenter;
    _jtArrtivecity.font=[UIFont systemFontOfSize:14];
    _jtArrtivecity.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_jtArrtivecity];
    
    _view2=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(154, 0, 1, 30)]];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view2];

    _stoptime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(160, 7, 56, 16)]];
    _stoptime.textAlignment=NSTextAlignmentCenter;
    _stoptime.font=[UIFont systemFontOfSize:14];
    _stoptime.textColor=[UIColor whiteColor];
    
    [self.contentView addSubview:_stoptime];
    
    _view3=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(221, 0, 1, 30)]];
    _view3.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view3];
    
    _outtime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(228, 7, 56, 16)]];
    _outtime.textAlignment=NSTextAlignmentCenter;
    _outtime.font=[UIFont systemFontOfSize:14];
    _outtime.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_outtime];
    
    _view4=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(287, 0, 1, 30)]];
    _view4.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view4];
    
    _freetime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(295, 7, 56, 16)]];
    _freetime.textAlignment=NSTextAlignmentCenter;
    _freetime.adjustsFontSizeToFitWidth=YES ;
    _freetime.font=[UIFont systemFontOfSize:14];
    _freetime.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_freetime];
}
- (void)setCellWithModel:(Tjtmodel *)app{
    _jtoutcity.text=[NSString stringWithFormat:@"%d",[app.sequenceNo intValue]+1];
    _jtArrtivecity.text=app.stationName;
    _stoptime.text=app.arrivalsTime;
    _outtime.text=app.departureTime;
    _freetime.text=app.stopTime;
    //    if(app.overTime.length>2){
//        int a;
//        NSString * b = [app.overTime substringToIndex:2];
//        a=[b intValue];
//        _freetime.text=[NSString stringWithFormat:@"%d小时%@分钟",a,[app.overTime substringFromIndex:3]];
//    }else{
//        _freetime.text=[NSString stringWithFormat:@"%@分钟",app.overTime];
//    }
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE;
    return newFrame;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
