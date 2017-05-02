//
//  TrainPassengerList.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainPassengerList : NSObject
//{
//    "PassengerId": "",
//    "PassengerName": "",
//    "PassportNo": "",
//    "PassportTypeId": "",
//    "Password": "",
//    "Price": 0,
//    "SeatCode": "",
//    "TicketType": "",
//    "UserName": ""
//}
@property (nonatomic,copy) NSString * PassengerId;
@property (nonatomic,copy) NSString * PassengerName;
@property (nonatomic,copy) NSString * PassportNo;
@property (nonatomic,copy) NSString * PassportTypeId;
@property (nonatomic,assign) int  Price;
@property (nonatomic,copy) NSString * SeatCode;
@property (nonatomic,copy) NSString * TicketType;
@property (nonatomic,copy) NSString * UserName;
@property (nonatomic,copy) NSString * password;

@end
