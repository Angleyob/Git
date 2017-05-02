//
//  order2Cell.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class order2Cell;
@protocol order2CellDelegate <NSObject>
-(void)DeleatbutClick:(order2Cell *)cell;
@end
@interface order2Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellbut;
@property (weak, nonatomic) IBOutlet UILabel *menMessagecell;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (nonatomic ,weak) id<order2CellDelegate>delegate;

@end
