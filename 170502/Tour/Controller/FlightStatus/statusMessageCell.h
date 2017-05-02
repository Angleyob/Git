//
//  statusMessageCell.h
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"

@interface statusMessageCell : UITableViewCell

@property(nonatomic,strong)UILabel * flightnum;
@property(nonatomic,strong)UILabel * flydate;
@property(nonatomic,strong)UILabel * fromcity;
@property(nonatomic,strong)UILabel * tocity;
@property(nonatomic,strong)UILabel * fromflycity;
@property(nonatomic,strong)UILabel * toflycity;
@property(nonatomic,strong)UILabel * ZDlabel;
@property(nonatomic,strong)UILabel * planlabel1;
@property(nonatomic,strong)UILabel * planlabel2;
@property(nonatomic,strong)UILabel * planflydate1;
@property(nonatomic,strong)UILabel * planflydate2;
@property(nonatomic,strong)UILabel * realtime1;
@property(nonatomic,strong)UILabel * realtime2;
@property(nonatomic,strong)UILabel * seat1;
@property(nonatomic,strong)UILabel * seat2;
@property(nonatomic,strong)UILabel * startime;
@property(nonatomic,strong)UILabel * stoptime;
@property(nonatomic,strong)UILabel * seatId1;
@property(nonatomic,strong)UILabel * seatId2;
@property(nonatomic,strong)UILabel * weather1;
@property(nonatomic,strong)UILabel * weather2;
@property(nonatomic,strong)UILabel * temp1;
@property(nonatomic,strong)UILabel * temp2;
@property(nonatomic,strong)UILabel * TSmessage;

@property(nonatomic,strong)UIImageView * flightlogoimage;

@property(nonatomic,strong)UIImageView * fly1;

@property(nonatomic,strong)UIImageView * fly2;

@property(nonatomic,strong)UIImageView * flystatusimage;
@property(nonatomic,strong)UIImageView * flystatusimage1;

@property(nonatomic,strong)UIImageView * lineimage;


@property(nonatomic,strong)UIImageView * weatherImage1;

@property(nonatomic,strong)UIImageView * weatherImage2;

-(void)setCellWithModel:(AttentionModel *)app;


@end
