//
//  tgResonCell.m
//  Tour
//
//  Created by Euet on 17/2/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "tgResonCell.h"

@implementation tgResonCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _headlabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(15, 12, 100, 16)]];
    _headlabel.adjustsFontSizeToFitWidth=YES;
    _headlabel.textAlignment=NSTextAlignmentCenter;
    _headlabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_headlabel];
    
    _resonlabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(170, 12, 175, 16)]];
    _resonlabel.adjustsFontSizeToFitWidth=YES;
    _resonlabel.textColor=[UIColor blackColor];
    _resonlabel.textAlignment=NSTextAlignmentCenter;
    _resonlabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_resonlabel];

    
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
