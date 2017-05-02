//
//  AirMessageCell.m
//  Tour
//
//  Created by Euet on 16/12/24.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "AirMessageCell.h"
@interface AirMessageCell()


@end
@implementation AirMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)bookbut:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bookbutClick:)]) {
        [self.delegate bookbutClick:self];
    }
}

- (IBAction)tgbutton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tgbuttonClick:)]) {
        [self.delegate tgbuttonClick:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
