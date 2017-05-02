//
//  ApproveRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ApproveRequest : RequestBase

@property(nonatomic,copy) NSString * AprvContent;
@property(nonatomic,copy) NSString * AprvDatetime;
@property(nonatomic,copy) NSString * AprvStatus;
@property(nonatomic,copy) NSString * OrderNo;
@property(nonatomic,copy) NSString * OrderType;

@end
