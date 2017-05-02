//
//  HorderCell.h
//  Tour
//
//  Created by Euet on 17/1/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotelnamelabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelmess;
@property (weak, nonatomic) IBOutlet UILabel *roomname;
@property (strong, nonatomic) IBOutlet UILabel *address;

@end
