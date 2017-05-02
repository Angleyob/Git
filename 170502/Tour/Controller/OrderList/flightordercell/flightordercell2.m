//
//  flightordercell2.m
//  Tour
//
//  Created by Euet on 17/2/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "flightordercell2.h"

@implementation flightordercell2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    
    _datelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 17, 54, 14)]];
    _datelabel.adjustsFontSizeToFitWidth=YES;
    _datelabel.textAlignment=NSTextAlignmentCenter;
    _datelabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_datelabel];
    
    _weeklabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 34, 20, 12)]];
    _weeklabel.adjustsFontSizeToFitWidth=YES;
    _timelabel.textColor=[UIColor blackColor];
    _weeklabel.textAlignment=NSTextAlignmentCenter;
    _weeklabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_weeklabel];
    
    _timelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 54, 40, 18)]];
    _timelabel.adjustsFontSizeToFitWidth=YES;
    _timelabel.textAlignment=NSTextAlignmentCenter;
    _timelabel.textColor=[UIColor blackColor];
    _timelabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:_timelabel];
    
    
    _cityimag =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 15, 12, 16)]];
    _cityimag.image=[UIImage imageNamed:@""];
    [self addSubview:_cityimag];
    
    
    _citylabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(100, 13, 180, 16)]];
    _citylabel.adjustsFontSizeToFitWidth=YES;
    _citylabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_citylabel];
    
    
    _statuslabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(298, 13, 42, 16)]];
    _statuslabel.adjustsFontSizeToFitWidth=YES;
    _statuslabel.textAlignment=NSTextAlignmentCenter;
    _statuslabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_statuslabel];
    
    _viewline =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 40, 261, 2)]];
    _viewline.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self addSubview:_viewline];
    
    _flightnolabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 49, 104, 14)]];
    _flightnolabel.adjustsFontSizeToFitWidth=YES;
    _flightnolabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_flightnolabel];
    
    _namelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(234, 49, 106, 14)]];
    _namelabel.adjustsFontSizeToFitWidth=YES;
    _namelabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_namelabel];
    
    _datelabel2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 82, 54, 14)]];
    _datelabel2.adjustsFontSizeToFitWidth=YES;
    _datelabel2.textAlignment=NSTextAlignmentCenter;
    _datelabel2.font=[UIFont systemFontOfSize:13];
    [self addSubview:_datelabel2];
    
    _weeklabel2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 99, 20, 12)]];
    _weeklabel2.adjustsFontSizeToFitWidth=YES;
    _timelabel2.textColor=[UIColor blackColor];
    _weeklabel2.textAlignment=NSTextAlignmentCenter;
    _weeklabel2.font=[UIFont systemFontOfSize:13];
    [self addSubview:_weeklabel2];
    
    _timelabel2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 119, 40, 18)]];
    _timelabel2.adjustsFontSizeToFitWidth=YES;
    _timelabel2.textAlignment=NSTextAlignmentCenter;
    _timelabel2.textColor=[UIColor blackColor];
    _timelabel2.font=[UIFont systemFontOfSize:15];
    [self addSubview:_timelabel2];
    
    
    _viewline2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 114, 261, 2)]];
    _viewline2.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self addSubview:_viewline2];
    
    _viewline3 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 75, 60, 2)]];
    _viewline3.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self addSubview:_viewline3];

    _cityimag2 =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 87, 12, 16)]];
    _cityimag2.image=[UIImage imageNamed:@""];
    [self addSubview:_cityimag2];
    
    
    _citylabel2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(100, 85, 180, 16)]];
    _citylabel2.adjustsFontSizeToFitWidth=YES;
    _citylabel2.font=[UIFont systemFontOfSize:14];
    [self addSubview:_citylabel2];
    
    
    _flightnolabel2 =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 122, 104, 14)]];
    _flightnolabel2.adjustsFontSizeToFitWidth=YES;
    _flightnolabel2.font=[UIFont systemFontOfSize:13];
    [self addSubview:_flightnolabel2];

    
    _addbutton =[[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(353, 70, 8, 13)]];
    [_addbutton setTitle:@">" forState:UIControlStateNormal];
    [_addbutton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_addbutton];

    _pricelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(256, 115, 60, 20)]];
    _pricelabel.adjustsFontSizeToFitWidth=YES;
    _pricelabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:_pricelabel];
    
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
