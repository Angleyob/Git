//
//  secretNum.m
//  Tour
//
//  Created by Euet on 17/3/31.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "secretNum.h"

@implementation secretNum

+(NSString*)IdCardtest:(NSString*)string{
    // 身份证密文显示
    NSMutableString * testIDStr = [NSMutableString stringWithString:string];
    if (testIDStr.length>=14) {
        NSRange range=NSMakeRange(6, 8);
        if (testIDStr.length > range.length) {
            [testIDStr replaceCharactersInRange:range withString:@"********"];
        }
    }
    return testIDStr;
}

+(NSString*)otherCardtest:(NSString*)string{
    // 身份证密文显示
    NSMutableString * testIDStr = [NSMutableString stringWithString:string];
    if (testIDStr.length>=8) {
        NSRange range=NSMakeRange(3, 4);
        if (testIDStr.length > range.length) {
            [testIDStr replaceCharactersInRange:range withString:@"********"];
        }
    }
   
    return testIDStr;
}

@end
