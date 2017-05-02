//
//  order1Cell.m
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "order1Cell.h"

@implementation order1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (IBAction)Messagebut:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MessageClick:)]) {
        [self.delegate MessageClick:self];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
