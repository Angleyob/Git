//
//  CollectionViewCellHtole.m
//  Tour
//
//  Created by Euet on 17/3/8.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CollectionViewCellHtole.h"

@implementation CollectionViewCellHtole
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
    _str= [[UILabel alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10,10, 86, 18)]];
    _str.textAlignment=NSTextAlignmentCenter;
    _str.textColor=[UIColor blackColor];
    _str.font=[UIFont systemFontOfSize:15];
    _str.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_str];
}

@end
