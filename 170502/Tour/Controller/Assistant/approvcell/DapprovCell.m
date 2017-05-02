//
//  DapprovCell.m
//  Tour
//
//  Created by Euet on 17/2/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "DapprovCell.h"

@implementation DapprovCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    _logoimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 12, 16, 16)]];
    [self.contentView addSubview:_logoimage];
    _menlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(46, 9, 150, 16)]];
    [self.contentView addSubview:_menlabel];
    _messageLabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 55, 297, 16)]];
    _messageLabel.adjustsFontSizeToFitWidth=YES;
    _messageLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_messageLabel];
    _statelael = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(257, 9, 100, 16)]];
    _statelael.text=@"待审批";
    _statelael.textAlignment=NSTextAlignmentRight;
    _statelael.font=[UIFont systemFontOfSize:14];
//    _statelael.adjustsFontSizeToFitWidth=YES;
    _statelael.textColor=[UIColor colorWithRed:17/255.0 green:119/255.0 blue:192/255.0 alpha:1];
    [self.contentView addSubview:_statelael];
    
    UIView * viewline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 39, 336, 1)]];
    viewline.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.contentView addSubview:viewline];
    _nextimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(348, 59, 8, 13)]];
    _nextimage.image=[UIImage imageNamed:@"right"];
    [self.contentView addSubview:_nextimage];
    UIView * viewline1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 90, 375, 5)]];
    viewline1.backgroundColor=[UIColor colorWithRed:244/255.0 green:246/255.0 blue:248/255.0 alpha:1];
    [self.contentView addSubview:viewline1];
}

- (void)setCellWithModel:(DapprovModel *)app{
    _orderType=app.orderType;

    if([app.orderType isEqualToString:@"机票"]){
        _logoimage.image=[UIImage imageNamed:@"plane"];
        }else if([app.orderType isEqualToString:@"火车票"]){
        _logoimage.image=[UIImage imageNamed:@"train"];
        }else{
        _logoimage.image=[UIImage imageNamed:@"hotelhh"];
        }
    //_menlabel.text=[NSString stringWithFormat:@"出行人:%@",app.]
    _messageLabel.text=app.title;
    
}


- (void)setCellWithModel1:(YapprovModel *)app{
   
    _orderType=app.orderType;
    
    if([app.orderType isEqualToString:@"机票"]){
        _logoimage.image=[UIImage imageNamed:@"plane"];
    }else if([app.orderType isEqualToString:@"火车票"]){
        _logoimage.image=[UIImage imageNamed:@"train"];
    }else{
        _logoimage.image=[UIImage imageNamed:@"hotelhh"];
    }
    
    _statelael.text=app.approveResult;
    
    //_menlabel.text=[NSString stringWithFormat:@"出行人:%@",app.]
    _messageLabel.text=app.title;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
