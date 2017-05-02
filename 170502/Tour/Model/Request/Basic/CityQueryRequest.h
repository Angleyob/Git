//
//  CityQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CityQueryRequest : RequestBase
@property(nonatomic,copy)NSString*Key;
@property(nonatomic,copy)NSString*SearchKey;

@end
