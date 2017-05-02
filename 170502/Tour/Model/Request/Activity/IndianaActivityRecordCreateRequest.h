//
//  IndianaActivityRecordCreateRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface IndianaActivityRecordCreateRequest : RequestBase
@property(nonatomic,copy)NSString  * ActivityNo;
@property(nonatomic,copy)NSString  * CompanyName;
@property(nonatomic,copy)NSString  * OpenID;
@property(nonatomic,copy)NSString  * UserName;
@end
