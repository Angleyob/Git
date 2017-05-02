//
//  CollectionViewCell2.m
//  Tour
//
//  Created by Euet on 17/3/27.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CollectionViewCell2.h"

@implementation CollectionViewCell2
//重写父类方法
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void) initUI
{
    
    _str=[[UILabel alloc] initWithFrame:CGRectMake(5,10, (deviceScreenWidth-120)/2+60, 25)];
//_str=[[UILabel alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(5,0, 52, 20)]];
    _str.font=[UIFont systemFontOfSize:14];
//    _str.adjustsFontSizeToFitWidth=YES;
    _str.textAlignment=NSTextAlignmentCenter;
    _str.textColor=[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    _str.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_str];
    
}

@end
