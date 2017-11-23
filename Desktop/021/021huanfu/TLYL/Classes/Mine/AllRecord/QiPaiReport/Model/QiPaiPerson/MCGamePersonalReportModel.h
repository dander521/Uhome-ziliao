//
//  MCGamePersonalReportModel.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGamePersonalReportModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCGamePersonalReportDataModel : NSObject

@property (nonatomic,strong)NSString * PageCount;//:1,
@property (nonatomic,strong)NSString * DataCount;//":1,
@property (nonatomic,strong)NSArray  * Reportlst;
@property (nonatomic,strong)NSArray  * ReportComm;

@end


@interface MCGamePersonalReportlstModel : NSObject

@property (nonatomic,strong)NSString * HisDate;//:"2017-08-29 00:00:00",
@property (nonatomic,strong)NSString * GamePay;//":-14456,
@property (nonatomic,strong)NSString * GameGet;//":3307,
@property (nonatomic,strong)NSString * RoomFee;//":-165.35,
@property (nonatomic,strong)NSString * PL;//":-11314.35



@end



@interface MCGamePersonalReportCommModel : NSObject

@property (nonatomic,strong)NSString * HisDate;//":"2017-08-29 00:00:00",
@property (nonatomic,strong)NSString * GamePay;//":-14456,
@property (nonatomic,strong)NSString * GameGet;//":3307,
@property (nonatomic,strong)NSString * RoomFee;//":-165.35,
@property (nonatomic,strong)NSString * PL;//":-11314.35


@end


//{
//    "code": 200,
//    "message": "成功",
//    "data": {
//        "ReportComm":[
//                      {
//                          "HisDate":"2017-08-29 00:00:00",
//                          "GamePay":-14456,
//                          "GameGet":3307,
//                          "RoomFee":-165.35,
//                          "PL":-11314.35
//                      }
//                      ],
//        "Reportlst":[
//                     {
//                         "HisDate":"2017-08-29 00:00:00",
//                         "GamePay":-14456,
//                         "GameGet":3307,
//                         "RoomFee":-165.35,
//                         "PL":-11314.35
//                     }
//                     ],
//        "PageCount":1,
//        "DataCount":1
//    }
//}

