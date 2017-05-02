//
//  hotelCell.m
//  Tour
//
//  Created by Euet on 17/1/17.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelCell.h"
#import "UIImageView+WebCache.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
@implementation hotelCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _hotelimage=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(10, 11, 120, 90)]];
    _hotelimage.image=[UIImage imageNamed:@""];
    [self.contentView addSubview:_hotelimage];
    _hotelname=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(140,2,195,40)]];
    _hotelname.font=[UIFont systemFontOfSize:14];
    _hotelname.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
// _hotelname.text=@"上海浦东机场大酒店";
// _hotelname.adjustsFontSizeToFitWidth=YES;
    _hotelname.lineBreakMode = NSLineBreakByWordWrapping;
    _hotelname.numberOfLines = 0;
    [self.contentView addSubview:_hotelname];
    _gclabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(140,40,54,14)]];
//    _gclabel.text=@"上海/浦东";
    _gclabel.textColor=UIColorFromRGBA(0x7bbf23, 1.0);
    _gclabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_gclabel];
    _tjlabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(140,57,30,12)]];
    _tjlabel.text=@"推荐度";
    _tjlabel.textColor=UIColorFromRGBA(0x9f9f9f, 1.0);
    _tjlabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_tjlabel];
    
    _image1=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(172, 60, 10, 10)]];
    _image2=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(184, 60, 10, 10)]];
    _image3=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(196, 60, 10, 10)]];
    _image4=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(208, 60, 10, 10)]];
    _image5=[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(220, 60, 10, 10)]];
    [self.contentView addSubview:_image1];
    [self.contentView addSubview:_image2];
    [self.contentView addSubview:_image3];
    [self.contentView addSubview:_image4];
    [self.contentView addSubview:_image5];
    
    _pricelabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(264,48,80,31)]];
    _pricelabel.textAlignment = NSTextAlignmentRight;
    _pricelabel.font=[UIFont systemFontOfSize:15];
    _pricelabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
    [self.contentView addSubview:_pricelabel];
    _labelfoot=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(349,58,11,12)]];
    _labelfoot.text=@"起";
    _labelfoot.textColor=UIColorFromRGBA(0x9f9f9f, 1.0);
    _labelfoot.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_labelfoot];
     _messageLabel=[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(140,68,225,40)]];
    _messageLabel.font=[UIFont systemFontOfSize:9];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.textColor=UIColorFromRGBA(0x888888, 1.0);
//   _messageLabel.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:_messageLabel];
}
- (void)setCellWithModel:(hotelmssModel *)app{
//    NSLog(@"%@",app.hotelName);
    [_hotelimage sd_setImageWithURL:[NSURL URLWithString:app.imageUrl] placeholderImage:[UIImage imageNamed:@"hotel1"]];
    _hotelname.text=app.hotelName;
    _gclabel.text=app.starName;
    _messageLabel.text=app.address;
    _pricelabel.text=[NSString stringWithFormat:@"￥%@",app.minPrice];
    
    if([app.star isEqualToString:@"1A"]){
        _image1.image=[UIImage imageNamed:@"star"];
    }else if([app.star isEqualToString:@"2A"]){
        _image1.image=[UIImage imageNamed:@"star"];
        _image2.image=[UIImage imageNamed:@"star"];
    }else if([app.star isEqualToString:@"3A"]){
        _image1.image=[UIImage imageNamed:@"star"];
        _image2.image=[UIImage imageNamed:@"star"];
        _image3.image=[UIImage imageNamed:@"star"];
    }else if([app.star isEqualToString:@"4A"]){
        _image1.image=[UIImage imageNamed:@"star"];
        _image2.image=[UIImage imageNamed:@"star"];
        _image3.image=[UIImage imageNamed:@"star"];
        _image4.image=[UIImage imageNamed:@"star"];
    }else if([app.star isEqualToString:@"5A"]){
        _image1.image=[UIImage imageNamed:@"star"];
        _image2.image=[UIImage imageNamed:@"star"];
        _image3.image=[UIImage imageNamed:@"star"];
        _image4.image=[UIImage imageNamed:@"star"];
        _image5.image=[UIImage imageNamed:@"star"];
    }else{
    }
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
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
