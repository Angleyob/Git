//
//  RequesrModel.h
//  Tour
//
//  Created by Euet on 16/12/1.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBase : NSObject
@property(nonatomic,copy)NSString * AppID;
@property(nonatomic,copy)NSString * Ip;
@property(nonatomic,copy)NSString * Channel;
@property(nonatomic,copy)NSString * MemberId;
@property(nonatomic,copy)NSString * LoginUserId;
-(NSMutableDictionary *)createDictionayFromModelProperties;

@end
