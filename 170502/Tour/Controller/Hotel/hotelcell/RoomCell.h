//
//  RoomCell.h
//  Tour
//
//  Created by Euet on 17/1/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RoomCell;
@protocol RoomCellDelegate <NSObject>
-(void)bookbutClick:(RoomCell *)cell;
@end
@interface RoomCell : UITableViewCell
@property (strong, nonatomic)  UILabel *hzlabel;
@property (strong, nonatomic)  UILabel *orderlabel;
@property (strong, nonatomic)  UILabel *pricelable;
@property (strong, nonatomic)  UILabel *gzlabel;
@property (strong, nonatomic)  UIButton *bookbut;
@property (nonatomic ,weak) id<RoomCellDelegate>delegate;
@end
