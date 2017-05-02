//
//  APIClass.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "APIClass.h"

@implementation APIClass

+(NSString*)WithApiHead:(NSString*)ApiHead ApiBody:(NSString*)ApiBody{
    return [ApiHead stringByAppendingString:ApiBody];
}

@end
