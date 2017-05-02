//
//  TrainOrderReturn.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainOrderReturn : RequestBase
@property (nonatomic,copy) NSString * OrderNo;
@property (nonatomic,copy) NSMutableArray * Retruntickets;
//"OrderNo": "",
//"Retruntickets": [
//                  {
//                      "PassengerName": "",
//                      "PassportsEno": "",
//                      "PassportTypeseId": "",
//                      "TicketNo": ""
//                  }
//                  ]
@end
