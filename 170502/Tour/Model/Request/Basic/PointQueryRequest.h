//
//  PointQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PointQueryRequest : RequestBase

@property(nonatomic,copy)NSString*CityId;
@property(nonatomic,copy)NSString*Value;


@end
