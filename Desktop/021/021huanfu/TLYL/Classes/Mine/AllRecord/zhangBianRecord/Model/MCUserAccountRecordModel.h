//
//  MCUserAccountRecordModel.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MCUserARecordModel : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) UIColor * color;
@property (nonatomic,strong) NSString * imgVName;

@end

@interface MCUserAccountRecordModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end

@interface MCUserAccountRecordDataModel : NSObject


@property (nonatomic,strong) NSString * AllMoney;
@property (nonatomic,strong) NSString * PageCount;
@property (nonatomic,strong) NSString * DataCount;
@property (nonatomic,strong) NSArray * UfInfo;

//{
//    "code": 200,
//    "message": "成功",
//    "data": {
//        "AllMoney":271,
//        "PageCount":4,
//        "DataCount":64,
//        "UfInfo":[
//                  {
//                      "RechargeType":0,
//                      "FeeMoney":0,
//                      "UserName":"kaka",
//                      "Marks":"12",
//                      "DetailsSource":10,
//                      "ThenBalance":96245.1128,
//                      "UseMoney":2,
//                      "InsertTime":"2017-07-31 15:53:56",
//                      "OrderID":"BETDQPC1N6U8SUD",
//                  }
//                  ]
//    }
//}

@end

@interface MCUserAccountRecordDetailDataModel : NSObject

@property (nonatomic,strong) NSString * RechargeType;//":0,
@property (nonatomic,strong) NSString * FeeMoney;//":0,
@property (nonatomic,strong) NSString * UserName;//":"kaka",
@property (nonatomic,strong) NSString * Marks;//":"12",
@property (nonatomic,strong) NSString * DetailsSource;//":10,
@property (nonatomic,strong) NSString * ThenBalance;//":96245.1128,
@property (nonatomic,strong) NSString * UseMoney;//":2,
@property (nonatomic,strong) NSString * InsertTime;//":"2017-07-31 15:53:56",
@property (nonatomic,strong) NSString * OrderID;//":"BETDQPC1N6U8SUD",

+(NSString *)getMarksDetail:(MCUserAccountRecordDetailDataModel *)model;

@end



































