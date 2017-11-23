//
//  MCQiPaiXiaJiReportModel.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCQiPaiXiaJiReportModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCQiPaiXiaJiReportDataModel : NSObject

@property (nonatomic,strong)NSString *DataCount;//":45,总数据条数
@property (nonatomic,strong)NSString *PageCount;//":3,总页数
@property (nonatomic,strong)NSArray  *ReportComm;//":[数据列表

@end




@interface MCQiPaiXiaJiReportCommModel : NSObject


@property (nonatomic,strong)NSString * UserName;//":"nancy",下级用户名
@property (nonatomic,strong)NSString * GamePay;//":0,投注金额
@property (nonatomic,strong)NSString * GameGet;//":0,中奖金额
@property (nonatomic,strong)NSString * RoomFee;//":0,房费
@property (nonatomic,strong)NSString * PL;//":0,盈亏
@property (nonatomic,strong)NSString * UserID;//":16602,下级ID值
@property (nonatomic,strong)NSString * Category;//":16, Category & 64 = 64，则为 会员，否则为 代理
@property (nonatomic,strong)NSString * ChildNum;//":"0",ChildNum > 0 ,则有下级团队，否则无
@property (nonatomic,strong)NSString * PlayIncome;//":0,对战类盈亏
@property (nonatomic,strong)NSString * SystemIncome;//":0

@end

