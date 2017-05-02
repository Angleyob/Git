//
//  StarView.h
//
//  Created by Jarvan on 15/11/23.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    UIImageView *bgImageView;
    UIImageView *starImageView;
}

/** 星级*/
- (void)configStarNum:(float)num;

@end
