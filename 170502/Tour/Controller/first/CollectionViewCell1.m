//
//  CollectionViewCell1.m
//  Tour
//
//  Created by Euet on 17/2/24.
//  Copyright © 2017年 lhy. All rights reserved.

#import "CollectionViewCell1.h"

@implementation CollectionViewCell1
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
    _str=[[UILabel alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(5,0, 52, 20)]];
    _str.font=[UIFont systemFontOfSize:14];
    _str.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_str];

}
@end
