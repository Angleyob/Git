//
//  statusCell.h
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"
#import "statusCell.h"

@class statusCell;
@protocol statusCellDelegate <NSObject>
-(void)statusbutClick:(statusCell *)cell;
@end
@interface statusCell : UITableViewCell
@property(nonatomic,copy)NSMutableDictionary * celldict;


@property(nonatomic,strong)UILabel * flightnumLabel;

@property(nonatomic,strong)UILabel * fromtimeLabel;

@property(nonatomic,strong)UILabel * totimeLabel;


@property(nonatomic,strong)UILabel * ywlabel;

@property(nonatomic,strong)UILabel * fromcityLabel;

@property(nonatomic,strong)UILabel * tocityLabel;

@property(nonatomic,strong)UILabel * fromflycityLabel;

@property(nonatomic,strong)UILabel * toflycityLabel;

@property(nonatomic,strong)UIImageView * flightlogoimage;

@property(nonatomic,strong)UIImageView * flystatusimage;

@property (nonatomic ,weak) id<statusCellDelegate>delegate;

//关注按钮
@property(nonatomic,strong)UIButton * Attentionbut;
@property(nonatomic,strong)UILabel * Attentionlabel;
@property(nonatomic,strong)UIImageView * Attentionimage;

- (void)setCellWithModel:(AttentionModel *)app;


@end
