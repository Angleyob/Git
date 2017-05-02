//
//  CJNmessCell.m
//  Tour
//
//  Created by Euet on 17/2/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CJNmessCell.h"

@implementation CJNmessCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    
    _label1=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(30, 11, 29, 16)]];
    _label1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _label1.text=@"姓名";
    _label1.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_label1];
    
    _namelabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(92, 11, 120, 16)]];
    _namelabel.font=[UIFont systemFontOfSize:14];
    _namelabel.adjustsFontSizeToFitWidth=YES;
    _namelabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_namelabel];
    _label2=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(226, 11, 29, 16)]];
     _label2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    _label2.text=@"类型";
    _label2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_label2];
    _typelabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(274, 11, 29, 16)]];
    _typelabel.text=@"成人";
    _typelabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_typelabel];
    _label3=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(30, 36, 42, 16)]];
    _label3.text=@"身份证";
    _label3.font=[UIFont systemFontOfSize:13];
    _label3.adjustsFontSizeToFitWidth=YES;
     _label3.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [self.contentView addSubview:_label3];
    _IdNumlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(110, 35, 176, 16)]];
    _IdNumlabel.font=[UIFont systemFontOfSize:14];
    _IdNumlabel.adjustsFontSizeToFitWidth=YES;
    _IdNumlabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_IdNumlabel];
    _rightimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(340, 0, 35, 30)]];
    [self.contentView addSubview:_rightimage];
    
    _disledimage=[[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(320, 23, 20, 20)]];
    _disledimage.image=[UIImage imageNamed:@"check_off"];
    [self.contentView addSubview:_disledimage];
}
- (void)setCellWithModel:(passageMenModel *)app1{
  //  NSLog(@"%@",app1);
    _namelabel.text=app1.passengerName;
    if([app1.passengerType isEqualToString:@"1"]){
        _typelabel.text=@"成人";
    }else if ([app1.passengerType isEqualToString:@"2"]){
        _typelabel.text=@"儿童";
    }else{
        _typelabel.text=@"婴儿";
    }
    if([app1.idType isEqualToString:@"NI"]){
        _label3.text=@"身份证";
        _IdNumlabel.text=[secretNum IdCardtest:app1.idNo];

    }else if ([app1.idType isEqualToString:@"ID"]){
        _label3.text=@"护照";
        _IdNumlabel.text=[secretNum otherCardtest:app1.idNo];
    }else{
        _IdNumlabel.text=app1.idNo;

        _label3.text=@"其它";
    }
}
- (void)setCellWithModelT:(passageTrainMenModel *)app{
    _namelabel.text=app.passengerName;
    if([app.passengerType isEqualToString:@"成人票"]){
        _typelabel.text=@"成人";
    }else if ([app.passengerType isEqualToString:@"儿童票"]){
        _typelabel.text=@"儿童";
    }else{
        _typelabel.text=@"婴儿";
    }
    _label3.text=@"身份证";
    _IdNumlabel.text=[secretNum IdCardtest:app.passportNo];
}



- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
