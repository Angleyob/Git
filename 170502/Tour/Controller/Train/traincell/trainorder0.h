//
//  trainorder0.h
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class trainorder0;
@protocol trainorder0Delegate <NSObject>
-(void)jtbutton:(trainorder0 *)cell;
-(void)tgbuttonClick:(trainorder0*)cell;
@end
@interface trainorder0 : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *runtimelabel;
@property (weak, nonatomic) IBOutlet UIView *viewline;
@property (weak, nonatomic) IBOutlet UILabel *freeprice;
@property (weak, nonatomic) IBOutlet UILabel *freetitle;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *Pricetitle;
@property (weak, nonatomic) IBOutlet UILabel *fromstation;
@property (weak, nonatomic) IBOutlet UILabel *fromtime;
@property (weak, nonatomic) IBOutlet UILabel *fromdata;
@property (weak, nonatomic) IBOutlet UIButton *tgbutton;
@property (weak, nonatomic) IBOutlet UIButton *jtbutton;
@property (weak, nonatomic) IBOutlet UILabel *trainNO;
@property (strong, nonatomic) IBOutlet UIImageView *ratinimage;
@property (weak, nonatomic) IBOutlet UILabel *tostation;
@property (weak, nonatomic) IBOutlet UILabel *totime;
@property (weak, nonatomic) IBOutlet UILabel *todate;
@property (nonatomic ,weak) id<trainorder0Delegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *orderlabel;

@end
