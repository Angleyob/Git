//
//  CollectionViewCell.m
//  和浮雕和
//
//  Created by Euet on 16/12/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "CollectionViewCell.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@implementation CollectionViewCell
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
    _imageview=[[UIImageView alloc] initWithFrame:[self newSuitFrame:CGRectMake(0,0, 15, 15)]];
    _imageview.image=[UIImage imageNamed:@"delete"];
    [self.contentView addSubview:_imageview];
     _str= [[UILabel alloc] initWithFrame:[self newSuitFrame:CGRectMake(30,0, 75, 20)]];
    _str.font=[UIFont systemFontOfSize:15];
    _str.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_str];
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE;
    return newFrame;
}

@end
