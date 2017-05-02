//
//  TrainAccountVerify.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainAccountVerify : RequestBase
@property (nonatomic,copy)NSMutableDictionary * account;
//这些属性以字典的形式放到字典属性
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * password;

@end
