//
//  BookEmpQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface BookEmpQueryRequest : RequestBase
@property (nonatomic,copy) NSString * BookerId;
@property (nonatomic,assign) int  Count;
@property (nonatomic,copy) NSString * DepartMentNo;
@property (nonatomic,copy) NSString * EmpNo;
@property (nonatomic,assign) int  Start;
@end
