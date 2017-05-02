//
//  SPmencell.m
//  Tour
//
//  Created by Euet on 17/2/13.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "SPmencell.h"

@implementation SPmencell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _menlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(46, 16, 48, 18)]];
    _menlabel.adjustsFontSizeToFitWidth=YES;

    _menlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];

    [self.contentView addSubview:_menlabel];
    
    _mennamelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(124, 16, 100, 18)]];
    _mennamelabel.adjustsFontSizeToFitWidth=YES;
    _mennamelabel.font=[UIFont systemFontOfSize:14];
    _mennamelabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_mennamelabel];
    
    _messageLabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(313, 16, 52, 18)]];
    _messageLabel.textColor=[UIColor colorWithRed:13/255.0 green:70/255.0 blue:128/255.0 alpha:1];
    //_messageLabel.text=@"待审批";
    _messageLabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_messageLabel];
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
