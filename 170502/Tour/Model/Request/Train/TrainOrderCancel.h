//
//  TrainOrderCancel.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainOrderCancel : RequestBase
@property (nonatomic,copy) NSString * OrderNo;

@end