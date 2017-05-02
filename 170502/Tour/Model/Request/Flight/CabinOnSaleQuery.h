//
//  CabinOnSaleQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CabinOnSaleQuery : RequestBase
@property(nonatomic,copy)NSString*BackKey;
@property(nonatomic,copy)NSString*GoKey;
@property(nonatomic,copy)NSString*PassengerType;
@property(nonatomic,copy)NSMutableArray*VoyageList;

@end
