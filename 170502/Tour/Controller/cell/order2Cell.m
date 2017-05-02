//
//  order2Cell.m
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "order2Cell.h"
@interface order2Cell()

@property (weak, nonatomic) IBOutlet UIButton *deleat;

@end
@implementation order2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_deleat addTarget:self action:@selector(DeleatbutClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)DeleatbutClick:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(DeleatbutClick:)]) {
        [self.delegate DeleatbutClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
