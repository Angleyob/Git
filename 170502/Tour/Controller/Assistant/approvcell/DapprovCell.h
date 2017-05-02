//
//  DapprovCell.h
//  Tour
//
//  Created by Euet on 17/2/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DapprovModel.h"
#import "YapprovModel.h"

@interface DapprovCell : UITableViewCell
@property (strong, nonatomic)  UILabel *menlabel;
@property (strong, nonatomic)  UILabel *statelael;
@property (strong, nonatomic)  UILabel *messageLabel;

@property (strong, nonatomic)  UIImageView *logoimage;
@property (strong, nonatomic)  UIImageView *nextimage;

//用于判断审批订单的类型
@property(nonatomic,copy)NSString * orderType;

- (void)setCellWithModel:(DapprovModel *)app;


- (void)setCellWithModel1:(YapprovModel *)app;

@end
