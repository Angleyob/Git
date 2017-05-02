//
//  InterfaseTableCell.m
//  UserInterface
//
//  Created by apple on 2017/2/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InterfaseTableCell.h"

@implementation InterfaseTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self access];
    }
    return self;
}
-(void)access
{
    _label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(25, 24, 120, 18)]];
    [self addSubview:_label];

   _logoimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(327, 24, 21, 24)]];
       [self addSubview:_logoimage];
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
