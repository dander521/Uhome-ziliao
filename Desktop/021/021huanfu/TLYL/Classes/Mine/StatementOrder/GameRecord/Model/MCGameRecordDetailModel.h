//
//  MCGameRecordDetailModel.h
//  TLYL
//
//  Created by miaocai on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGameRecordDetailBetModel:NSObject

@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *DrawContent;
@property (nonatomic,strong) NSString *OrderID;
@property (nonatomic,assign) int BetOrderState;
@property (nonatomic,strong) NSString *AwMoney;
@property (nonatomic,strong) NSString *AwContent;
@property (nonatomic,strong) NSString *ChaseOrderID;
@property (nonatomic,strong) NSString *PlayCode;
@property (nonatomic,strong) NSString *BetContent;
@property (nonatomic,assign) int BetCount;
@property (nonatomic,strong) NSString *IssueNumber;
@property (nonatomic,strong) NSString *BetMultiple;
@property (nonatomic,strong) NSString *BetMoney;
@property (nonatomic,assign) int BetMode;

@end
@interface MCGameRecordDetailModel : NSObject
{
    @public
    NSString *_InsertTime;
    NSString *_LotteryCode;
    BOOL _IsHistory;
    NSString *_OrderID;
    
//    NSString *_ChaseOrderID;
}
@property (nonatomic,strong) NSString *SumBetMoney;
@property (nonatomic,strong) NSString *LotteryCode;
@property (nonatomic,strong) NSString *BetRebate;
@property (nonatomic,assign) int OrderState;

@property (nonatomic,strong) NSArray <MCGameRecordDetailBetModel *>*Bet;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;
@end
