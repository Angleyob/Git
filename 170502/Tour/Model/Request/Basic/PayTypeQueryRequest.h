//
//  PayTypeQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PayTypeQueryRequest : RequestBase
@property(nonatomic,copy)NSString*BusinessType;
@property(nonatomic,copy)NSString*OrderNo;
@property(nonatomic,copy)NSString*PlatformVIP;
@end
