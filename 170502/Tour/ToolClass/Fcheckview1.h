//
//  Fcheckview1.h
//  Tour
//
//  Created by Euet on 17/3/21.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcheckview1 : UIView

@property(nonatomic,strong)UILabel*SecondviolateItem;
@property(nonatomic,strong)UILabel*SecondviolateReason;
@property(nonatomic,strong)UILabel*violateItem;
@property(nonatomic,strong)UILabel*violateReason;
@property(nonatomic,strong)UILabel*priject;
@property(nonatomic,strong)UILabel*concent;
-(void)initView;
@end