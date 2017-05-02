//
//  Pay orderInfosmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//此模型是放入payRequest模型的orderInfos数组属性中
@interface Pay_orderInfosmodel : NSObject
@property(nonatomic,copy)NSString*OrderNo;
@property(nonatomic,copy)NSString* PayAmount;
@end
