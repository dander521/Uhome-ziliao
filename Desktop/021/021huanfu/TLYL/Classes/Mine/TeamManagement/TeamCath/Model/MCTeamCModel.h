//
//  MCTeamCModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCTeamCModel : NSObject
//IsHistory    是    Boolean    是否为历史记录
//Source    是    Int    查询类型 见备注1
//InsertTimeMin    是    String    开始时间（如：”2017/07/31 00:00:00”）
//InsertTimeMax    是    String    结束时间（如：”2017/07/31 23:59:59”）
//CurrentPageIndex    是    Int    当前页下标（第一页为1，后续页码依次加1）
//CurrentPageSize    是    Int    当前页请求条目数
//ThisUserName    否    String    需要搜索则传用户名，无则不传
@property (nonatomic,assign) BOOL IsHistory;
@property (nonatomic,assign) int Source;
@property (nonatomic,strong) NSString *InsertTimeMin;
@property (nonatomic,strong) NSString *InsertTimeMax;
@property (nonatomic,assign) int CurrentPageSize;
@property (nonatomic,assign) int CurrentPageIndex;
@property (nonatomic,strong) NSString *ThisUserName;
//RechargeType    Int    收支类型
//FeeMoney    Number    手续费
//UserName    String    账户名
//Marks    String    备注 见备注2
//DetailsSource    Int    类型、备注判断条件 见备注2
//ThenBalance    Number    用户余额
//UseMoney    Number    订单金额（投注等）
//InsertTime    String    交易时间
//OrderID  String    订单流水号
@property (nonatomic,assign) int RechargeType;
@property (nonatomic,strong) NSNumber *FeeMoney;
@property (nonatomic,strong) NSString *UserName;
@property (nonatomic,strong) NSString *Marks;
@property (nonatomic,assign) int DetailsSource;
@property (nonatomic,strong) NSNumber *ThenBalance;
@property (nonatomic,strong) NSNumber *UseMoney;
@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *OrderID;
@property (nonatomic,strong) NSString *BankCode;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
