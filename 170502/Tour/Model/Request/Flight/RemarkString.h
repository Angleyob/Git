//
//  RemarkString.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface RemarkString : RequestBase
@property(nonatomic,copy)NSString*PolicyId;
@property(nonatomic,copy)NSString*SeatClass;
@property(nonatomic,copy)NSString*SessionId;
@property(nonatomic,copy)NSString*FlightNo;
@end
