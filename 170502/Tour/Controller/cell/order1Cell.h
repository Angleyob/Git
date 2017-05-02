//
//  order1Cell.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class order1Cell;
@protocol order1CellDelegate <NSObject>
-(void)MessageClick:(order1Cell *)cell;
@end

@interface order1Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderlabel;
@property (weak, nonatomic) IBOutlet UILabel *celloutlabel;
@property (weak, nonatomic) IBOutlet UILabel *airlabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;
@property (nonatomic ,weak) id<order1CellDelegate>delegate;

@end
