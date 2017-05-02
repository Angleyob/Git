//
//  CabinQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CabinQuery : RequestBase
@property(nonatomic,copy)NSString*BusinessType;

@property(nonatomic,copy)NSString*FlightNo;

@property(nonatomic,copy)NSString*Rank;

@property(nonatomic,copy)NSString*SessionId;

@end
