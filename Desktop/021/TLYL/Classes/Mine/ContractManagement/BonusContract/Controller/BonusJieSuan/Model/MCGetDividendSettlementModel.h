//
//  MCGetDividendSettlementModel.h
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取下级分红结算数据
//请求URL：
///web-api/api/v4/get_dividend_settlement
@interface MCGetDividendSettlementModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCGetDividendContractListModel : NSObject

@property(nonatomic,strong) NSString * Expenditure;
@property(nonatomic,strong) NSString * LossAmount;
@property(nonatomic,strong) NSString * ActivePeopleNum;
@property(nonatomic,strong) NSString * DividendRatio;


@end

@interface MCGetBonusPreviewModelsModel : NSObject

@property(nonatomic,strong) NSString * TotalBets;
@property(nonatomic,strong) NSString * GrossProfit;
@property(nonatomic,strong) NSString * ActivePeopleNum;
@property(nonatomic,strong) NSString * DividendRatio;
@property(nonatomic,strong) NSString * DeservedDividend;

@end

@interface MCGetDividendSettlementDataModel : NSObject

@property(nonatomic,strong) NSString * DividendCycle;
@property(nonatomic,strong) NSArray * GetDividendContractList;
@property(nonatomic,strong) MCGetBonusPreviewModelsModel * GetBonusPreviewModels;

@end






























