//
//  MCClickBonusSettlementModel.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//简要描述：
//分红结算
//请求URL：
///web-api/api/v4/bonus_settlement
@interface MCClickBonusSettlementModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
