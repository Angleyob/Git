//
//  sxtablecell.m
//  Tour
//
//  Created by Euet on 17/2/21.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "sxtablecell.h"

@implementation sxtablecell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _strlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 9, 116, 18)]];
    _strlabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_strlabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
