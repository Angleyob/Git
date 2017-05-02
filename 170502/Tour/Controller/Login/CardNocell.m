//
//  CardNocell.m
//  Tour
//
//  Created by Euet on 17/2/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "CardNocell.h"

@implementation CardNocell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _strlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, deviceScreenWidth-70, 40)];
    _strlabel.font=[UIFont systemFontOfSize:14];
    _strlabel.textColor=[UIColor blackColor];
    _strlabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_strlabel];
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
