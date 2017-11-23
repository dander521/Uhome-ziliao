//
//  MCTCReportSubModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCTCReportSubModel : NSObject
@property (nonatomic,strong)NSString *User_Name;
@property (nonatomic,strong)NSNumber *FeeMoneyTotal;
@property (nonatomic,strong)NSNumber *DailywageTotal;
@property (nonatomic,strong)NSNumber *RebateTotal;
@property (nonatomic,strong)NSNumber *RechargeTotal;
@property (nonatomic,strong)NSNumber *DrawingsTotal;
@property (nonatomic,strong)NSNumber *BuyTotal;
@property (nonatomic,strong)NSNumber *WinningTotal;
@property (nonatomic,strong)NSNumber *GainTotal;
@property (nonatomic,strong)NSNumber *OtherTotal;

@property (nonatomic,assign)int UserID;
@property (nonatomic,assign)int Category;
@property (nonatomic,assign)int ChildNum;
@property (nonatomic,assign)int TeamNum;

@property (nonatomic,assign)int RebateType;
@property (nonatomic,assign)int GetUserType;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSNumber *LotteryMoney;
@property (nonatomic,assign)int CurrentPageIndex;
@property (nonatomic,strong)NSString *User_ID;
@property (nonatomic,assign)int CurrentPageSize;
@property (nonatomic,strong)NSString *BeginTime;
@property (nonatomic,strong)NSString *EndTime;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
