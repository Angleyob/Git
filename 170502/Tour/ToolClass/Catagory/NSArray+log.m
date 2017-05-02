//
//  NSArray+log.m
//  Tour
//
//  Created by Euet on 17/3/25.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "NSArray+log.h"

@implementation NSArray (log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
   
}

@end
