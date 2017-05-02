//
//  trainorder0.m
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "trainorder0.h"

@implementation trainorder0

- (IBAction)tgbuttonclick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tgbuttonClick:)]) {
        [self.delegate tgbuttonClick:self];
    }
}
- (IBAction)jtbuttonclick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(jtbutton:)]) {
        [self.delegate jtbutton:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
