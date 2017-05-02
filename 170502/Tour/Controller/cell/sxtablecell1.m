//
//  sxtablecell1.m
//  Tour
//
//  Created by Euet on 17/3/22.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "sxtablecell1.h"

@implementation sxtablecell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _strlabel=[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 6, 190, 44)]];
    _strlabel.font=[UIFont systemFontOfSize:14];
    _strlabel.numberOfLines = 0;//表示label可以多行显示
    _strlabel.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
    
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
