//
//  DetailsCell.m
//  UserInterface
//
//  Created by apple on 2017/2/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailsCell.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@implementation DetailsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self access];
    }
    return self;
}
-(void)access
{
    _label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 18, 80, 18)]];
    _label.font=[UIFont systemFontOfSize:14];
    [self addSubview:_label];
    _textField = [[UITextField alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 18,375-160, 18)]];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_textField];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
