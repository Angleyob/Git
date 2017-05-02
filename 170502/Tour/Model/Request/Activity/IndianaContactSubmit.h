//
//  IndianaContactSubmit.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface IndianaContactSubmit : RequestBase

@property(nonatomic,copy)NSString  * ActivityNo;
@property(nonatomic,copy)NSString  * Address;
@property(nonatomic,copy)NSString  * City;
@property(nonatomic,copy)NSString  * District;
@property(nonatomic,copy)NSString  * DrawNumber;
@property(nonatomic,copy)NSString  * Name;
@property(nonatomic,copy)NSString  * Phone;
@property(nonatomic,copy)NSString  * Province;
@property(nonatomic,copy)NSString  * ZipCode;



@end
