//
//  ContactQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ContactQueryRequest : RequestBase
@property (nonatomic,assign) int  Count;
@property (nonatomic,copy) NSString * SearchKey;
@property (nonatomic,assign)  int  Start;

@end
