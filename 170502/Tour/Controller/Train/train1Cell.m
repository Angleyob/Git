//
//  train1Cell.m
//  Tour
//
//  Created by Euet on 17/1/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "train1Cell.h"

@implementation train1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)bookbutton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bookbuttonClick:)]) {
        [self.delegate bookbuttonClick:self];
    }
}

- (IBAction)book123:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(book123Click:)]) {
        [self.delegate book123Click:self];
    }
}
- (IBAction)yybut:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(yybutClick:)]) {
        [self.delegate yybutClick:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
