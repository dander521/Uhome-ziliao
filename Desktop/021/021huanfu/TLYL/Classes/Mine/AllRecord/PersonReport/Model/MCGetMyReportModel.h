//
//  MCGetMyReportModel.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGetMyReportModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCGetMyReportDataModel : NSObject
@property (nonatomic,strong)NSString * PageCount;//:1,
@property (nonatomic,strong)NSString * DataCount;//":1,
@property (nonatomic,strong)NSArray  * Reportlst;//":
@property (nonatomic,strong)NSArray  * ReportComm;

@end


@interface MCGetMyReportlstModel : NSObject

@property (nonatomic,strong)NSString * BetMoney;// = 0;
@property (nonatomic,strong)NSString * Dailywage;// = 0;
@property (nonatomic,strong)NSString * Drawings;// = 0;
@property (nonatomic,strong)NSString * DrawingsMoney;// = 0;
@property (nonatomic,strong)NSString * GainMoney;// = 0;
@property (nonatomic,strong)NSString * HisTime;// = "2017-10-20 00:00:00";
@property (nonatomic,strong)NSString * OtherDrawings;// = 0;
@property (nonatomic,strong)NSString * OtherMoney;// = 0;
@property (nonatomic,strong)NSString * OtherRecharge;// = 0;
@property (nonatomic,strong)NSString * PersonDrawings;// = 0;
@property (nonatomic,strong)NSString * PersonRecharge;// = 0;
@property (nonatomic,strong)NSString * Recharge;// = 0;
@property (nonatomic,strong)NSString * RechargeMoney;// = 0;
@property (nonatomic,strong)NSString * SelfRebateMoney;// = 0;
@property (nonatomic,strong)NSString * SubRebateMoney;// = 0;
@property (nonatomic,strong)NSString * UserID;// = 17225;
@property (nonatomic,strong)NSString * WinMoney;// = 0;



@end



@interface MCGetMyReportCommModel : NSObject
@property (nonatomic,strong)NSString * BuyTotal;// = 0;
@property (nonatomic,strong)NSString * Category;// = 0;
@property (nonatomic,strong)NSString * ChildNum;// = 0;
@property (nonatomic,strong)NSString * DailywageTotal;// = 0;
@property (nonatomic,strong)NSString * DlGainTotal ;//= 0;
@property (nonatomic,strong)NSString * Drawings ;//= 0;
@property (nonatomic,strong)NSString * DrawingsTotal;// = 0;
@property (nonatomic,strong)NSString * FeeMoneyTotal;// = 0;
@property (nonatomic,strong)NSString * GainTotal;// = 0;
@property (nonatomic,strong)NSString * HyGainTotal ;//= 0;
@property (nonatomic,strong)NSString * OtherDrawings ;//= 0;
@property (nonatomic,strong)NSString * OtherRecharge;// = 0;
@property (nonatomic,strong)NSString * OtherTotal;// = 0;
@property (nonatomic,strong)NSString * PersonDrawings;// = 0;
@property (nonatomic,strong)NSString * PersonRecharge;// = 0;
@property (nonatomic,strong)NSString * RebateTotal ;//= 0;
@property (nonatomic,strong)NSString * Recharge ;//= 0;
@property (nonatomic,strong)NSString * RechargeTotal ;//= 0;
@property (nonatomic,strong)NSString * SelfRebateTotal ;//= 0;
@property (nonatomic,strong)NSString * SubRebateTotal ;//= 0;
@property (nonatomic,strong)NSString * TeamNum ;//= 0;
@property (nonatomic,strong)NSString * Uptotal ;//= 0;
@property (nonatomic,strong)NSString * UserID ;//= 17225;
@property (nonatomic,strong)NSString * UserName ;//= "<null>";
@property (nonatomic,strong)NSString * WinningTotal ;//= 0;
@property (nonatomic,strong)NSString * YxGainTotal;// = 0;


@end






















