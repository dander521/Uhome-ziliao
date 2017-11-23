//
//  MCWithdrawModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCWithdrawModel : NSObject
{
@public
    NSString *_drawingsState;
    NSString *_beginDate;
    NSString *_endDate;
    NSString *_currentPageIndex;
    NSString *_currentPageSize;
    
}

@property (nonatomic,strong) NSString *BankCode;
@property (nonatomic,strong) NSString *CardNumber;
@property (nonatomic,strong) NSString *CreateServiceIP;
@property (nonatomic,strong) NSString *CreateTime;
@property (nonatomic,strong) NSString *DealTime;
@property (nonatomic,strong) NSString *DrawingsMark;
@property (nonatomic,strong) NSString *DrawingsMoney;
@property (nonatomic,strong) NSString *DrawingsOrder;
@property (nonatomic,strong) NSString *DrawingsState;
@property (nonatomic,strong) NSString *DrawingsType;
@property (nonatomic,strong) NSString *FlowPlatform;
@property (nonatomic,strong) NSString *ManagerID;
@property (nonatomic,strong) NSString *ManagerUserName;
@property (nonatomic,strong) NSString *RealName;
@property (nonatomic,strong) NSString *ThenBalance;
@property (nonatomic,strong) NSString *UserDrawingsInfo_ID;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *UserName;


@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;

@end
