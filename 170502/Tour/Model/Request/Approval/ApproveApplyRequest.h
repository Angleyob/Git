//
//  ApproveApplyRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ApproveApplyRequest : RequestBase
@property(nonatomic,copy) NSString * OrderNo;
@property(nonatomic,copy) NSString * OrderType;
@property(nonatomic,copy) NSString * approveWay;

@end
