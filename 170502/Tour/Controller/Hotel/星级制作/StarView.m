//
//  StarView.m
//  LimitFree
//
//  Created by Jarvan on 15/11/23.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 10)];
    // 停靠向左
    bgImageView.contentMode = UIViewContentModeLeft;
    bgImageView.image = [UIImage imageNamed:@"StarsBackground.png"];
    [self addSubview:bgImageView];
    
    
    starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 10)];
    starImageView.contentMode = UIViewContentModeLeft;
    starImageView.image = [UIImage imageNamed:@"StarsForeground.png"];
    // 设置裁剪，超出部分裁剪
    starImageView.clipsToBounds = YES;
    [bgImageView addSubview:starImageView];
}

- (void)configStarNum:(float)num{
    float x = 65 / 5 * num;
//NSLog(@"%f",x);
    starImageView.frame = CGRectMake(0, 0, x, 10);
}

@end
