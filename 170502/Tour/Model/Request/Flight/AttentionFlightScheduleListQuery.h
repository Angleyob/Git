//
//  AttentionFlightScheduleListQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface AttentionFlightScheduleListQuery : RequestBase
@property(nonatomic,copy)NSString*PhoneNumber;
@property(nonatomic,assign) int Start;
@property(nonatomic,assign) int Count;


@end
