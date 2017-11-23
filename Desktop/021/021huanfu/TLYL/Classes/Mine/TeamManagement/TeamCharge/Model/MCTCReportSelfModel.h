//
//  MCTCReportSelfModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCTCReportSelfModel : NSObject

@property (nonatomic,strong)NSNumber *FeeMoneyTotal;
@property (nonatomic,strong)NSNumber *DailywageTotal;
@property (nonatomic,strong)NSNumber *RebateTotal;
@property (nonatomic,strong)NSNumber *RechargeTotal;
@property (nonatomic,strong)NSNumber *DrawingsTotal;
@property (nonatomic,strong)NSNumber *BuyTotal;
@property (nonatomic,strong)NSNumber *WinningTotal;
@property (nonatomic,strong)NSNumber *GainTotal;
@property (nonatomic,strong)NSNumber *OtherTotal;


//RebateType    是    Int    固定值：1
//ISself    是    Int    固定值：1
//UserID    是    Int    固定值：-1
//BeginTime    是    String    开始时间 （格式：年月日 时分秒，如 2017/07/21 00:00:00）
//EndTime
@property (nonatomic,assign) BOOL allTeam;

@property (nonatomic,assign)int RebateType;
@property (nonatomic,assign)int ISself;
@property (nonatomic,assign)int UserID;
@property (nonatomic,strong)NSString *BeginTime;
@property (nonatomic,strong)NSString *EndTime;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
