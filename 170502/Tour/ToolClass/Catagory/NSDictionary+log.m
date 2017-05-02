//
//  NSDictionary+log.m
//  Tour
//
//  Created by Euet on 17/3/25.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "NSDictionary+log.h"

@implementation NSDictionary (log)
- (NSString *)descriptionWithLocale:(id)locale
 {
     
     NSArray *allKeys = [self allKeys];
     NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
     for (NSString *key in allKeys) {
         id value= self[key];
         [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
     }
     [str appendString:@"}"];
     
     return str;
   }
@end
