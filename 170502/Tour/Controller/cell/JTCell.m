//
//  JTCell.m
//  Tour
//
//  Created by Euet on 17/2/4.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "JTCell.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
#import "flightJTmodel.h"

@implementation JTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{

    _jtcity=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(35, 7, 56, 16)]];
    _jtcity.textAlignment=NSTextAlignmentCenter;
    _jtcity.font=[UIFont systemFontOfSize:14];
    _jtcity.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_jtcity];
    
    _view1=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(104, 0, 1, 30)]];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view1];

    _stoptime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(119, 7, 56, 16)]];
    _stoptime.textAlignment=NSTextAlignmentCenter;
    _stoptime.font=[UIFont systemFontOfSize:14];
    _stoptime.textColor=[UIColor whiteColor];

    [self.contentView addSubview:_stoptime];

    _view2=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(187, 0, 1, 30)]];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view2];

    _outtime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(202, 7, 56, 16)]];
    _outtime.textAlignment=NSTextAlignmentCenter;
    _outtime.font=[UIFont systemFontOfSize:14];
    _outtime.textColor=[UIColor whiteColor];

    [self.contentView addSubview:_outtime];

    _view3=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(270, 0, 1, 30)]];
    _view3.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_view3];

    _freetime=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(274, 7, 79, 16)]];
    _freetime.textAlignment=NSTextAlignmentCenter;
    _freetime.adjustsFontSizeToFitWidth=YES ;
    _freetime.font=[UIFont systemFontOfSize:14];
    _freetime.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_freetime];

}

- (void)setCellWithModel:(flightJTmodel *)app{
    _jtcity.text=app.cityName;
    _stoptime.text=app.stopOverStartTime;
    _outtime.text=app.stopOverEndTime;

    if(app.overTime.length>2){
        int a;
        NSString * b = [app.overTime substringToIndex:2];
        a=[b intValue];
        _freetime.text=[NSString stringWithFormat:@"%d小时%@分钟",a,[app.overTime substringFromIndex:3]];
    }else{
        _freetime.text=[NSString stringWithFormat:@"%@分钟",app.overTime];
    }
    
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
