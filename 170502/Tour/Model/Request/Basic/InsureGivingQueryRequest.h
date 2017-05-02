//
//  InsureGivingQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface InsureGivingQueryRequest : RequestBase
@property(nonatomic,copy)NSString*ParaNoComp;
@property(nonatomic,copy)NSString*ParaNoMember;
@property(nonatomic,assign) int Count;
@property(nonatomic,assign) int Start;

@end
