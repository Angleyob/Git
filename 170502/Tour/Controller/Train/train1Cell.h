//
//  train1Cell.h
//  Tour
//
//  Created by Euet on 17/1/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class train1Cell;
@protocol train1CellDelegate <NSObject>
-(void)bookbuttonClick:(train1Cell *)cell;
-(void)book123Click:(train1Cell *)cell;
-(void)yybutClick:(train1Cell *)cell;
@end

@interface train1Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewline;
@property (weak, nonatomic) IBOutlet UILabel *seatlabel;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *image06;
@property (weak, nonatomic) IBOutlet UILabel *label12306;
@property (weak, nonatomic) IBOutlet UIButton *book123;
@property (weak, nonatomic) IBOutlet UILabel *label123;
@property (weak, nonatomic) IBOutlet UIButton *yybut;
@property (weak, nonatomic) IBOutlet UILabel *yylabel;
@property (weak, nonatomic) IBOutlet UILabel *yylabel2;
@property (weak, nonatomic) IBOutlet UIImageView *yyimage;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *gzlabel;
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIButton *bookbutton;

@property (nonatomic ,weak) id<train1CellDelegate>delegate;

@end
