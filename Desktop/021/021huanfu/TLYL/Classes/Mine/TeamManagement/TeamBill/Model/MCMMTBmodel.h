//
//  MCMMTBmodel.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMMTBmodel : NSObject

@property (nonatomic,strong) NSString *LotteryCode;
@property (nonatomic,assign) BOOL IsHistory;
@property (nonatomic,strong) NSString *insertTimeMin;
@property (nonatomic,strong) NSString *insertTimeMax;
@property (nonatomic,strong) NSString *LikeUserName;
@property (nonatomic,assign) int CurrentPageIndex;
@property (nonatomic,assign) int CurrentPageSize;


@property (nonatomic,assign) int BetInfo_ID;
@property (nonatomic,strong) NSString *UserName;
@property (nonatomic,assign) int User_ID;
@property (nonatomic,assign) int OrderState;
@property (nonatomic,assign) int AwardMoney;
@property (nonatomic,strong) NSString *ChaseOrderID;
@property (nonatomic,assign) int BetTb;
@property (nonatomic,strong) NSString *OrderID;
@property (nonatomic,assign) int BetMultiple;
@property (nonatomic,assign) int PlayCode;
@property (nonatomic,assign) int BetMode;
@property (nonatomic,assign) int BetMoney;
@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *IssueNumber;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
