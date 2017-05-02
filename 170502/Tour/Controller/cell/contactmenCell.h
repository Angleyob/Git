//
//  contactmenCell.h
//  Tour
//
//  Created by Euet on 17/1/3.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactmenCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (copy, nonatomic)  NSMutableDictionary *celldict;

@end
