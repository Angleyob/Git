//
//  fcheckview3.m
//  Tour
//
//  Created by Euet on 17/3/21.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "fcheckview3.h"

@implementation fcheckview3

-(void)initView{
    
    self.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];

    UILabel *  label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 12, 34, 16)]];
    label.text=@"项目:";
    label.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label];
    
//    _priject = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(73, 12, 120, 16)]];
    _priject = [[UILabel alloc]init];
    _priject.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _priject.adjustsFontSizeToFitWidth=YES;
    _priject.font=[UIFont systemFontOfSize:13];
    _priject.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_priject];
    [_priject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).with.offset(5);
        make.top.equalTo(self).offset(12/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];

    UILabel *  label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 32, 64, 16)]];
    label1.text=@"成本中心:";
    label1.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    label1.adjustsFontSizeToFitWidth=YES;
    label1.font=[UIFont systemFontOfSize:13];
    label1.textAlignment=NSTextAlignmentLeft;
    [self addSubview:label1];
    
//    _concent = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(90, 32, 120, 16)]];
    _concent = [[UILabel alloc]init];
    _concent.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    _concent.adjustsFontSizeToFitWidth=YES;
    _concent.font=[UIFont systemFontOfSize:13];
    _concent.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_concent];
    
    [_concent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).with.offset(5);
        make.top.equalTo(self).offset(32/SCREEN_RATE1);
        make.height.offset(16);
        make.width.offset(deviceScreenWidth-138);
    }];
    
}

@end
