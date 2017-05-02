//
//  RoomCell.m
//  Tour
//
//  Created by Euet on 17/1/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "RoomCell.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
@implementation RoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE;
    return newFrame;
}
- (void)makeUI{
    self.contentView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    _hzlabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(30, 7, 165, 40)]];
    _hzlabel.font= [UIFont systemFontOfSize:12];
    _hzlabel.lineBreakMode = NSLineBreakByWordWrapping;
    _hzlabel.numberOfLines = 0;
// _hzlabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_hzlabel];
    
    _pricelable=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(226, 13, 90, 14)]];
    _pricelable.font=[UIFont systemFontOfSize:14];
    _pricelable.adjustsFontSizeToFitWidth=YES;
    _pricelable.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
    [self.contentView addSubview:_pricelable];
    
    _orderlabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(30, 46, 84, 16)]];
        _orderlabel.font= [UIFont systemFontOfSize:13];
        _orderlabel.adjustsFontSizeToFitWidth=YES;
     _orderlabel.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
    [self.contentView addSubview:_orderlabel];
    _gzlabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(249, 36, 28, 16)]];
    _gzlabel.adjustsFontSizeToFitWidth=YES;

    [self.contentView addSubview:_gzlabel];
    
   _bookbut=[[UIButton alloc]initWithFrame:[self newSuitFrame:CGRectMake(288, 11, 72, 44)]];
    [_bookbut addTarget:self action:@selector(bookbutClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bookbut setTitle:@"预订" forState:UIControlStateNormal];
    [_bookbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //剪切
    _bookbut.clipsToBounds=YES;
    //圆角
    _bookbut.layer.cornerRadius = 10.0;
    _bookbut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [self.contentView addSubview:_bookbut];

}
-(void)bookbutClick:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(bookbutClick:)]) {
        [self.delegate bookbutClick:self];
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
