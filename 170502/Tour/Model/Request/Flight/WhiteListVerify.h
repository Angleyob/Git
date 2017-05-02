//
//  WhiteListVerify.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface WhiteListVerify : RequestBase
@property(nonatomic,copy)NSMutableArray*Passengers;
@property(nonatomic,copy)NSMutableArray*White;

//"Passengers": [
//               {
//                   "Passcard": "",
//                   "PassCardType": "",
//                   "Passname": ""
//               }
//               ],
//"White": [
//          {
//              "Cabin": "",
//              "Flightno": "",
//              "Policyid": "",
//              "Sessionid": ""
//          }
//          ]
@end
