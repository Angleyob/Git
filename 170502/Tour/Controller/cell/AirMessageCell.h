//
//  AirMessageCell.h
//  Tour
//
//  Created by Euet on 16/12/24.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AirMessageCell;
@protocol AirMessageCellDelegate <NSObject>
-(void)bookbutClick:(AirMessageCell *)cell;
-(void)tgbuttonClick:(AirMessageCell*)cell;
@end
@interface AirMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bookbut;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UIImageView *showview;
@property (weak, nonatomic) IBOutlet UILabel *seatlabel;
@property (weak, nonatomic) IBOutlet UILabel *cabinname;
@property (weak, nonatomic) IBOutlet UILabel *gzlabel;
@property (weak, nonatomic) IBOutlet UILabel *czlabel;
@property (weak, nonatomic) IBOutlet UIImageView *gwimagelabel;
@property (weak, nonatomic) IBOutlet UIButton *tgbutton;
@property (weak, nonatomic) IBOutlet UIView *leftview;

@property (nonatomic ,weak) id<AirMessageCellDelegate>delegate;
@property (nonatomic,assign) NSInteger mySection;
@property (nonatomic,copy)  NSDictionary * celldict;

@end
