//
//  MCGameRecordModel.h
//  TLYL
//
//  Created by miaocai on 2017/8/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGameRecordModel : NSObject
{
@public
    NSString *_sourceCode;
    NSString *_lotteryCode;
    BOOL _isHistory;
    NSString *_insertTimeMin;
    NSString *_insertTimeMax;
    NSString *_currentPageIndex;
    NSString *_currentPageSize;
    NSString *_subUserName;
    NSString *_subUserID;
    
}
@property (nonatomic,strong) NSString *AwardMoney;
@property (nonatomic,strong) NSString *BetContent;
@property (nonatomic,strong) NSString *BetInfo_ID;
@property (nonatomic,strong) NSString *BetMode;
@property (nonatomic,strong) NSString *BetMoney;
@property (nonatomic,strong) NSString *BetMultiple;
@property (nonatomic,strong) NSString *BetTb;
@property (nonatomic,strong) NSString *CdrawTime;
@property (nonatomic,strong) NSString *ChaseOrderID;//订单号
@property (nonatomic,strong) NSString *DrawTime;
@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *OrderID;//流水号
@property (nonatomic,strong) NSString *OrderState;
@property (nonatomic,strong) NSString *PlayCode;
@property (nonatomic,strong) NSString *UserName;
@property (nonatomic,strong) NSString *User_ID;
@property (nonatomic,strong) NSString *IssueNumber;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@end
