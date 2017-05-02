//
//  CollectionHotcityCell.m
//  Tour
//
//  Created by Euet on 17/2/3.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CollectionHotcityCell.h"

@implementation CollectionHotcityCell
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
    _str= [[UILabel alloc] initWithFrame:CGRectMake(0,0, 70, 20)];
    [self.contentView addSubview:_str];
}

@end
