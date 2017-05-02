//
//  API_HTTP.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#ifndef API_HTTP_h
#define API_HTTP_h


#endif /* API_HTTP_h */

#define deviceScreenWidth [[UIScreen mainScreen]bounds].size.width
#define deviceScreenHeight [[UIScreen mainScreen]bounds].size.height

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
#define SCREEN_RATE1 (667/[UIScreen mainScreen].bounds.size.height)

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

//下面这句，注释掉就正式环境，没有注释的话就是测试环境

#define ISDEBUG 1

#ifdef ISDEBUG
                ///////           测试地址            ///////

#define API_Test_Url @"http://wxapi.test.euet.com.cn"
#else
#define API_Test_Url @"https://wxapi.euet.com.cn"

#endif

                // //******  Accont   ****** // //

//AccountVerify--账号密码验证
#define API_AccountVerify   @"/AccountService/AccountVerify"
//BookEmpModify--添加旅客
#define API_BookEmpModify   @"/AccountService/BookEmpModify"
//BookEmpModify--旅客查询
#define API_BookEmpQuery    @"/AccountService/BookEmpQuery"
//CardNoQuery--差旅卡号查询
#define API_CardNoQuery     @"/AccountService/CardNoQuery"
//ContactModify--添加联系人
#define API_ContactModify   @"/AccountService/ContactModify"
//ContactQuery--联系人查询
#define API_ContactQuery    @"/AccountService/ContactQuery"
//EmpQuery--用户信息获取
#define API_EmpQuery        @"/AccountService/EmpQuery"
//Password--忘记密码-获取密码
#define API_Password        @"/AccountService/Password"
//PasswordModify--修改登录密码
#define API_PasswordModify  @"/AccountService/PasswordModify"
// ResetPassword--重置密码
#define API_ResetPassword   @"/AccountService/ResetPassword"
//VerifyCode忘记密码-获取验证码
#define API_VerifyCode      @"/AccountService/VerifyCode"

                            // //******  Basic  ****** // //
//违背原因
#define API_BreachReasonQuery      @"/BasicService/BreachReasonQuery"
//城市查询
#define API_CityQuery              @"/BasicService/CityQuery"
//成本中心
#define API_CostCenterQuery        @"/BasicService/CostCenterQuery"
//商圈 行政区查询
#define API_DistrictQuery          @"/BasicService/DistrictQuery"
//获取员工职级
#define API_EmpRankQuery           @"/BasicService/EmpRankQuery"
//获取赠送保险
#define API_InsureGivingQuery      @"/BasicService/InsureGivingQuery"
//保险查询
#define API_InsureQuery            @"/BasicService/InsureQuery"
//企业注册
#define API_MemberReg              @"/BasicService/MemberReg"
//支付操作
#define API_BasicServicePay        @"/BasicService/Pay"
//获取支付方式
#define API_PayTypeQuery           @"/BasicService/PayTypeQuery"
//关键词获取城市热点
#define API_PointQuery             @"/BasicService/PointQuery"
//项目信息
#define API_ProjectQuery           @"/BasicService/ProjectQuery"
//差旅标准
#define API_TravelStaQuery         @"/BasicService/TravelStaQuery"
//担保信息
#define API_Vouch                  @"/BasicService/Vouch"
//获取火车票，酒店，飞机票 审批规则后台设置情况
#define API_YwApproveSetQuery      @"/BasicService/YwApproveSetQuery"
//国籍信息
#define API_Nation                  @"/BasicService/NationQuery"


                            // //******  Flight  ****** // //

//航空公司
#define API_AirwayQuery            @"/FlightService/AirwayQuery"
//获取航班动态列表
#define API_AttentionFlightScheduleListQuery      @"/FlightService/AttentionFlightScheduleListQuery"
//获得特价舱
#define API_CabinOnSaleQuery      @"/FlightService/CabinOnSaleQuery"
//舱位查询
#define API_CabinQuery            @"/FlightService/CabinQuery"
//舱位类型
#define API_CabinTypeQuery        @"/FlightService/CabinTypeQuery"
//取消关注航班动态
#define API_CancelFlightSchedule  @"/FlightService/CancelFlightSchedule"
//关注航班动态
#define API_CustomFlightSchedule  @"/FlightService/CustomFlightSchedule"
//获取机票改签单详情
#define API_FlightChangeInfQuery  @"/FlightService/FlightChangeInfQuery"
//机票改签单查询
#define API_FlightChangeQuery     @"/FlightService/FlightChangeQuery"
//取消改签申请
#define API_FlightEndorseTicketCancel      @"/FlightService/FlightEndorseTicketCancel"
//提交订单
#define API_FlightOrder           @"/FlightService/FlightOrder"
//机票订单取消
#define API_FlightOrderCancel     @"/FlightService/FlightOrderCancel"
//机票改签申请
#define API_FlightOrderChange     @"/FlightService/FlightOrderChange"
//获取机票订单详情
#define API_FlightOrderInfQuery   @"/FlightService/FlightOrderInfQuery"
//机票订单查询
#define API_FlightOrderQuery      @"/FlightService/FlightOrderQuery"
//机票退票申请
#define API_FlightOrderReturn     @"/FlightService/FlightOrderReturn"
//查询航班
#define API_FlightQuery           @"/FlightService/FlightQuery"
//获取机票退票详情
#define API_FlightReturnInfQuery  @"/FlightService/FlightReturnInfQuery"
//机票退票单查询
#define API_FlightReturnQuery     @"/FlightService/FlightReturnQuery"
//取消退票申请
#define API_FlightReturnTicketCancel      @"/FlightService/FlightReturnTicketCancel"
//获取航班动态列表
#define API_FlightScheduleListQuery      @"/FlightService/FlightScheduleListQuery"
//获取改签说明
#define API_RemarkString          @"/FlightService/RemarkString"
//获取经停城市
#define API_StopOverQuery         @"/FlightService/StopOverQuery"
//白名单验证
#define API_WhiteListVerify       @"/FlightService/WhiteListVerify"

                            // //******  Hotel  ****** // //

#define API_HotelBaseDataList     @"/HotelService/HotelBaseDataList"
#define API_HotelInfQuery         @"/HotelService/HotelInfQuery"
#define API_HotelOrder            @"/HotelService/HotelOrder"
#define API_HotelOrderCancel      @"/HotelService/HotelOrderCancel"
#define API_HotelOrderInfQuery    @"/HotelService/HotelOrderInfQuery"
#define API_HotelOrderQuery       @"/HotelService/HotelOrderQuery"
#define API_HotelQuery            @"/HotelService/HotelQuery"
#define API_RoomQuery             @"/HotelService/RoomQuery"

                            // //******  Train  ****** // //

#define API_PassStationQuery      @"/TrainService/PassStationQuery"
#define API_TGQApproveQuery       @"/TrainService/TGQApproveQuery"
#define API_TrainAccountQuery     @"/TrainService/TrainAccountQuery"
#define API_TrainAccountVerify    @"/TrainService/TrainAccountVerify"
#define API_TrainCancelChange     @"/TrainService/TrainCancelChange"
#define API_TrainChangeInfQuery   @"/TrainService/TrainChangeInfQuery"
#define API_TrainChangeQuery      @"/TrainService/TrainChangeQuery"
#define API_TrainOrder            @"/TrainService/TrainOrder"
#define API_TrainOrderCancel      @"/TrainService/TrainOrderCancel"
#define API_TrainOrderChange      @"/TrainService/TrainOrderChange"
#define API_TrainOrderInfQuery    @"/TrainService/TrainOrderInfQuery"
#define API_TrainOrderQuery       @"/TrainService/TrainOrderQuery"
#define API_TrainOrderReturn      @"/TrainService/TrainOrderReturn"
#define API_TrainQuery            @"/TrainService/TrainQuery"
#define API_TrainReturnInfQuery   @"/TrainService/TrainReturnInfQuery"
#define API_TrainReturnQuery      @"/TrainService/TrainReturnQuery"
#define API_TrainServiceFeeQuery  @"/TrainService/TrainServiceFeeQuery"
#define API_TrainStationQuery     @"/TrainService/TrainStationQuery"
#define API_TrainStationSearch    @"/TrainService/TrainStationSearch"

                            // //******  Appproval  ****** // //

#define API_ApprovalRuleQuery     @"/ApprovalService/ApprovalRuleQuery"
#define API_Approve               @"/ApprovalService/Approve"
#define API_ApproveApply          @"/ApprovalService/ApproveApply"
#define API_ApproveQuery          @"/ApprovalService/ApproveQuery"
#define API_OrderApprovalRecordsQuery      @"/ApprovalService/OrderApprovalRecordsQuery"

                            // //******  InsuranceService  ****** // //

#define API_InsuranceOrderCreate   @"/InsuranceService/InsuranceOrderCreate"
#define API_InsuranceOrderPay      @"/InsuranceService/InsuranceOrderPay"
#define API_InsuranceProductQuery  @"/InsuranceService/InsuranceProductQuery"

                            // //******  Activity  ****** // //

//IndianaActivityQuery--获取活动
#define API_IndianaActivityQuery   @"/ActivityService/IndianaActivityQuery"
//IndianaActivityRecordCreat--参与活动
#define API_IndianaActivityRecordCreate   @"/ActivityService/IndianaActivityRecordCreate"
//IndianaActivityWinnerQuery--获奖名单
#define API_IndianaActivityWinnerQuery    @"/ActivityService/IndianaActivityWinnerQuery"
//IndianaContactSubmit--提交资料
#define API_IndianaContactSubmit     @"/ActivityService/IndianaContactSubmit"

//**************************************************************************//
                ///////           正式地址            ///////
                        // //******  Accont   ****** // //
////AccountVerify--账号密码验证
//#define API_AccountVerify   @""
////BookEmpModify--添加旅客
//#define API_BookEmpModify   @""
////BookEmpModify--旅客查询
//#define API_BookEmpQuery    @""
////CardNoQuery--差旅卡号查询
//#define API_CardNoQuery     @""
////ContactModify--添加联系人
//#define API_ContactModify   @""
////ContactQuery--联系人查询
//#define API_ContactQuery    @""
////EmpQuery--用户信息获取
//#define API_EmpQuery        @""
////Password--忘记密码-获取密码
//#define API_Password        @""
////PasswordModify--修改登录密码
//#define API_PasswordModify  @""
//// ResetPassword--重置密码
//#define API_ResetPassword   @""
////VerifyCode忘记密码-获取验证码
//#define API_VerifyCode      @""
