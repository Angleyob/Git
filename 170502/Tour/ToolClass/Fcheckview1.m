//
//  Fcheckview1.m
//  Tour
//
//  Created by Euet on 17/3/21.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "Fcheckview1.h"

@implementation Fcheckview1

-(void)initView{
    
    self.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UILabel *  label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 12, 98, 16)]];
    label.text=@"返程违规事项:";
    label.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label];
    
//    _SecondviolateItem = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 12, 150, 16)]];
    _SecondviolateItem = [[UILabel alloc]init];
    _SecondviolateItem.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _SecondviolateItem.adjustsFontSizeToFitWidth=YES;
    _SecondviolateItem.font=[UIFont systemFontOfSize:13];
    _SecondviolateItem.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_SecondviolateItem];
    
    [_SecondviolateItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).with.offset(5);
        make.top.equalTo(self).offset(12/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];
    
    UILabel *  label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 32, 98, 16)]];
    label1.text=@"返程违规原因:";
    label1.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label1.adjustsFontSizeToFitWidth=YES;
    label1.font=[UIFont systemFontOfSize:13];
    label1.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label1];
    
//    _SecondviolateReason = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 32, 150, 16)]];
    _SecondviolateReason = [[UILabel alloc]init];
    _SecondviolateReason.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _SecondviolateReason.font=[UIFont systemFontOfSize:13];
    _SecondviolateReason.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_SecondviolateReason];
    
    [_SecondviolateReason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).with.offset(5);
        make.top.equalTo(self).offset(32/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    
    UILabel *  labe2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 50, 98, 16)]];
    labe2.text=@"去程违规事项:";
    labe2.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    labe2.adjustsFontSizeToFitWidth=YES;
    labe2.font=[UIFont systemFontOfSize:13];
    labe2.textAlignment=NSTextAlignmentLeft;
    [self addSubview:labe2];
    
//    _violateItem = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 50, 150, 16)]];
    _violateItem = [[UILabel alloc]init];
    _violateItem.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _violateItem.adjustsFontSizeToFitWidth=YES;
    _violateItem.font=[UIFont systemFontOfSize:13];
    _violateItem.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_violateItem];
    
    [_violateItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labe2.mas_right).with.offset(5);
        make.top.equalTo(self).offset(50/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    
    UILabel *  label21 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 68, 98, 16)]];
    label21.text=@"去程违规原因:";
    label21.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label21.adjustsFontSizeToFitWidth=YES;
    label21.font=[UIFont systemFontOfSize:13];
    label21.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label21];
    
//    _violateReason = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 68, 150, 16)]];
    _violateReason = [[UILabel alloc]init];
    _violateReason.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _violateReason.adjustsFontSizeToFitWidth=YES;
    _violateReason.font=[UIFont systemFontOfSize:13];
    _violateReason.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_violateReason];
    
    [_violateReason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label21.mas_right).with.offset(5);
        make.top.equalTo(self).offset(68/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    
    
    UILabel *  label3 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 86, 34, 16)]];
    label3.text=@"项目:";
    label3.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label3.adjustsFontSizeToFitWidth=YES;
    label3.font=[UIFont systemFontOfSize:13];
    label3.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label3];
    
//    _priject = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(73, 86, 100, 16)]];
    _priject = [[UILabel alloc]init];
    _priject.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _priject.adjustsFontSizeToFitWidth=YES;
    _priject.font=[UIFont systemFontOfSize:13];
    _priject.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_priject];
    [_priject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right).with.offset(5);
        make.top.equalTo(self).offset(86/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    UILabel *  label4 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 104, 64, 16)]];
    label4.text=@"成本中心:";
    label4.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label4.adjustsFontSizeToFitWidth=YES;
    label4.font=[UIFont systemFontOfSize:13];
    label4.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label4];
//    _concent = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(90, 104, 100, 16)]];
    _concent = [[UILabel alloc]init];
    _concent.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _concent.adjustsFontSizeToFitWidth=YES;
    _concent.font=[UIFont systemFontOfSize:13];
    _concent.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_concent];

    [_concent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label4.mas_right).with.offset(5);
        make.top.equalTo(self).offset(104/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    
    
    
    
    
}
@end