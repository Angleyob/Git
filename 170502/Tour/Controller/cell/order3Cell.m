//
//  order3Cell.m
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "order3Cell.h"

@implementation order3Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)infobut:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(infobutClick:)]) {
        [self.delegate infobutClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
