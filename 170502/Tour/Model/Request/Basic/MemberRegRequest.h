//
//  MemberRegRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface MemberRegRequest : RequestBase
@property(nonatomic,copy)NSString*Address;
@property(nonatomic,copy)NSString*CityCode;
@property(nonatomic,copy)NSString*CompanyName;
@property(nonatomic,copy)NSString*Contact;
@property(nonatomic,copy)NSString*Email;
@property(nonatomic,copy)NSString*IndustryCode;
@property(nonatomic,copy)NSString*Mobile;
@property(nonatomic,copy)NSString*Size;
@property(nonatomic,copy)NSString*ZipCode;
@end
