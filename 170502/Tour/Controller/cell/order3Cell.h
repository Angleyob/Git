//
//  order3Cell.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class order3Cell;
@protocol order3CellDelegate <NSObject>
-(void)infobutClick:(order3Cell*)cell;
@end

@interface order3Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *insurelabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLbel;
@property (weak, nonatomic) IBOutlet UIButton *rightbut;
@property (nonatomic ,weak) id<order3CellDelegate>delegate;
@end
