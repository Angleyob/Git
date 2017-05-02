//
//  hotelorderCell.m
//  Tour
//
//  Created by Euet on 17/2/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelorderCell.h"

@implementation hotelorderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    
    _datelabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(12, 25, 46, 16)]];
    _datelabel.adjustsFontSizeToFitWidth=YES;
    _datelabel.textAlignment=NSTextAlignmentCenter;
//    _datelabel.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_datelabel];
    
    _weeklabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(22, 42, 25, 13)]];
    _weeklabel.adjustsFontSizeToFitWidth=YES;
    _weeklabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _weeklabel.textAlignment=NSTextAlignmentCenter;
//    _weeklabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_weeklabel];
    
    _cityimag=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 15, 12, 16)]];
    _cityimag.image=[UIImage imageNamed:@"location"];

    [self.contentView addSubview:_cityimag];
    
    _citylabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(97, 0, 130, 48)]];
   _citylabel.font=[UIFont systemFontOfSize:13];
    _citylabel.adjustsFontSizeToFitWidth=YES;
       _citylabel.numberOfLines = 0;//表示label可以多行显示
//    _citylabel.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
   
    [self.contentView addSubview:_citylabel];
    
    _menimag=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(234, 15, 25, 16)]];
    [self.contentView addSubview:_menimag];
    
    _statuslabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(298, 25, 56, 16)]];
    _statuslabel.adjustsFontSizeToFitWidth=YES;
    _statuslabel.textAlignment=NSTextAlignmentCenter;
    _statuslabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _statuslabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_statuslabel];
    
    _viewline=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 51, 261, 1)]];
    _viewline.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self.contentView addSubview:_viewline];
    
    _namelabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 62, 126, 14)]];
    _namelabel.adjustsFontSizeToFitWidth=YES;
    _namelabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _namelabel.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_namelabel];
    
    _pricelabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(260, 62, 80, 16)]];
    _pricelabel.adjustsFontSizeToFitWidth=YES;
    _pricelabel.textColor=[UIColor colorWithRed:253/255.0 green:103/255.0 blue:32/255.0 alpha:1];
    _pricelabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:_pricelabel];
    
    _addbutton=[[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 43, 13, 14)]];
    [_addbutton setTitle:@">" forState:UIControlStateNormal];
    [_addbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_addbutton];
}

- (void)awakeFromNib {[super awakeFromNib];}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];}

@end
