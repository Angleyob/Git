//
//  flightordercell.m
//  Tour
//
//  Created by Euet on 17/2/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "flightordercell.h"

@implementation flightordercell

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
   _datelabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_datelabel];
    
    _weeklabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 34, 20, 12)]];
    _weeklabel.adjustsFontSizeToFitWidth=YES;
    _weeklabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _weeklabel.textAlignment=NSTextAlignmentCenter;
//    _weeklabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_weeklabel];
    
    _timelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 54, 56, 18)]];
    _timelabel.adjustsFontSizeToFitWidth=YES;
    _timelabel.textAlignment=NSTextAlignmentCenter;
    _timelabel.textColor=[UIColor blackColor];
//    _timelabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:_timelabel];

    _cityimag =[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 15, 12, 16)]];
    _cityimag.image=[UIImage imageNamed:@"location"];
    [self addSubview:_cityimag];

    _citylabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(100, 13, 180, 16)]];
    _citylabel.adjustsFontSizeToFitWidth=YES;
    _citylabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_citylabel];

    
    _statuslabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(298, 13, 42, 16)]];
    _statuslabel.adjustsFontSizeToFitWidth=YES;
    _statuslabel.textAlignment=NSTextAlignmentCenter;
    _statuslabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _statuslabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_statuslabel];

       _viewline =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 40, 261, 1)]];
    _viewline.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self addSubview:_viewline];
    
    _flightnolabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 49, 104, 14)]];
    _flightnolabel.adjustsFontSizeToFitWidth=YES;
    _flightnolabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _flightnolabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_flightnolabel];
    
    _namelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 70, 126, 14)]];
    _namelabel.adjustsFontSizeToFitWidth=YES;
    _namelabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _namelabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_namelabel];

    _pricelabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(290, 56, 60, 20)]];
    _pricelabel.adjustsFontSizeToFitWidth=YES;
    _pricelabel.textColor=[UIColor colorWithRed:253/255.0 green:103/255.0 blue:32/255.0 alpha:1];
    _pricelabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:_pricelabel];
    
    _addbutton =[[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(353, 42, 12, 13)]];
    [_addbutton setTitle:@">" forState:UIControlStateNormal];
    [_addbutton setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_addbutton];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
