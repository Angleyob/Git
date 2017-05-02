//
//  PayRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PayRequest : RequestBase

@property(nonatomic,copy)NSString*BankCode;
@property(nonatomic,copy)NSString*BankPayType;
@property(nonatomic,copy)NSString*BusinessType;
@property(nonatomic,copy)NSString*CardHolder;
@property(nonatomic,copy)NSString*CardNo;
@property(nonatomic,copy)NSString*CardType;
@property(nonatomic,copy)NSString*Mobile;
@property(nonatomic,copy)NSString*IDCard;
@property(nonatomic,copy)NSString*Month;
@property(nonatomic,copy)NSString*OpenId;
@property(nonatomic,copy)NSString*PaperType;
@property(nonatomic,copy)NSString*PayDockCode;
@property(nonatomic,copy)NSString*PayMethod;
@property(nonatomic,copy)NSString*PayType;
@property(nonatomic,copy)NSString*PlatformVIP;
@property(nonatomic,copy)NSString*SpareField;
@property(nonatomic,copy)NSString*SubCode;
@property(nonatomic,copy)NSString*VerifyCode;
@property(nonatomic,copy)NSString*Year;

@property(nonatomic,strong)NSMutableArray*orderInfos;

@end
