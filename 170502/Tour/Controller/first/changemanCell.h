//
//  changemanCell.h
//  Tour
//
//  Created by Euet on 16/12/26.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changemanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *eiltmenbut;
@property (weak, nonatomic) IBOutlet UILabel *cardnumber;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *cardlabel;
@property (weak, nonatomic) IBOutlet UIButton *deletbut;
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) NSMutableDictionary  *celldict;

@end
