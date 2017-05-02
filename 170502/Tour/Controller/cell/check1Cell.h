//
//  check1Cell.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface check1Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *flyimage;
@property (weak, nonatomic) IBOutlet UIImageView *mealimg;
@property (weak, nonatomic) IBOutlet UIImageView *titleimage;
@property (weak, nonatomic) IBOutlet UIImageView *timeimg;

@property (weak, nonatomic) IBOutlet UILabel *outCity;
@property (weak, nonatomic) IBOutlet UILabel *zdlabel;
@property (weak, nonatomic) IBOutlet UILabel *meallabel;
@property (weak, nonatomic) IBOutlet UILabel *airNo;
@property (weak, nonatomic) IBOutlet UILabel *arrviCity;
@property (weak, nonatomic) IBOutlet UILabel *arriveTime;
@property (weak, nonatomic) IBOutlet UILabel *copany;
@property (weak, nonatomic) IBOutlet UILabel *flyTime;

@property (weak, nonatomic) IBOutlet UILabel *outTime;
@property (weak, nonatomic) IBOutlet UILabel *outdatalabel;
@property (weak, nonatomic) IBOutlet UILabel *bettenCity;
@end
