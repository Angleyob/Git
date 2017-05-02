//
//  ContactModifyRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ContactModifyRequest : RequestBase

@property (nonatomic,copy) NSString * ContactId;
@property (nonatomic,copy) NSString * ContactName;
@property (nonatomic,copy) NSString * EmpId;
@property (nonatomic,copy) NSString * EnglishName;
@property (nonatomic,copy) NSString * IDCardNo;
@property (nonatomic,copy) NSString * Mobile;
@property (nonatomic,copy) NSString * ModifyType;
@property (nonatomic,copy) NSString * Passport;
@property (nonatomic,copy) NSString * Relation;


@end
