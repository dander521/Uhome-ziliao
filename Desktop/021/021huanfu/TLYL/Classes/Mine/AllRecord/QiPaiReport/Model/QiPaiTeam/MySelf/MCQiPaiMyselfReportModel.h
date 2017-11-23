//
//  MCQiPaiMyselfReportModel.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCQiPaiMyselfReportModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface MCQiPaiMyselfReportDataModel : NSObject

@property (nonatomic,strong)NSString * UserName;//":"becky",用户名
@property (nonatomic,strong)NSString * GamePay;//":0,投注金额
@property (nonatomic,strong)NSString * GameGet;//":0,中奖金额
@property (nonatomic,strong)NSString * RoomFee;//":0,房费
@property (nonatomic,strong)NSString * PL;//":0,自身盈亏
@property (nonatomic,strong)NSString * PlayIncome;//":0,对战类盈亏
@property (nonatomic,strong)NSString * SystemIncome;//":0电子类盈亏
@end


