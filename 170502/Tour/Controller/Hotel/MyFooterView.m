//
//  MyFooterView.m
//  Tour
//
//  Created by Euet on 17/3/28.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "MyFooterView.h"

@implementation MyFooterView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _button=[[UIButton alloc]init];
        [_button addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
        _button.frame =CGRectMake(0,0, 40,30);
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame =CGRectMake(0,0, 40,30);
        _titleLab.textAlignment =NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor whiteColor];
        [_button addSubview:_titleLab];
        
        [self addSubview:_button];
        
    }
    
    return self;
}
-(void)butclick:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(bookbutClick:)]) {
        [self.delegate bookbutClick:self];
    }
}
@end
