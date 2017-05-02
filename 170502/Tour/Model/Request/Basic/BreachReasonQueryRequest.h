//
//  BreachReasonQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface BreachReasonQueryRequest : RequestBase
@property(nonatomic,assign) int Count;
@property(nonatomic,assign) int Start;
@property(nonatomic,copy) NSString * Type;
@end
