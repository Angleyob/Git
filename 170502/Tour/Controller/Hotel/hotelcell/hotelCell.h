//
//  hotelCell.h
//  Tour
//
//  Created by Euet on 17/1/17.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "hotelmssModel.h"

@interface hotelCell : UITableViewCell
//@property (nonatomic,strong) hotelmssModel *topModel;

@property (strong, nonatomic)  UILabel *pricelabel;
@property (strong, nonatomic)  UILabel *labelfoot;
@property (strong, nonatomic)  UILabel *messageLabel;
@property (strong, nonatomic)  UILabel *hotelname;
@property (strong, nonatomic)  UIImageView *hotelimage;
@property (strong, nonatomic)  UILabel *gclabel;
@property (strong, nonatomic)  UILabel *tjlabel;

@property (strong, nonatomic)  UIImageView *image1;
@property (strong, nonatomic)  UIImageView *image2;
@property (strong, nonatomic)  UIImageView *image3;
@property (strong, nonatomic)  UIImageView *image4;
@property (strong, nonatomic)  UIImageView *image5;

/** app星级*/
@property (nonatomic,strong) StarView *appStartView;

- (void)setCellWithModel:(hotelmssModel *)app;

@end
