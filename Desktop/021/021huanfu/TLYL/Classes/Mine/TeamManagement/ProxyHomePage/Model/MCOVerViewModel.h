//
//  MCOVerViewModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOVerViewModel : NSObject

@property (nonatomic,strong) NSString *_UserID;

@property (nonatomic,strong) NSString *TeamLotteryMoney;
@property (nonatomic,strong) NSNumber *TeamNum;
@property (nonatomic,strong) NSString *TeamRechargeMoney;
@property (nonatomic,strong) NSString *TeamDrawingsMoney;
@property (nonatomic,strong) NSString *TeamBetMoney;
@property (nonatomic,strong) NSNumber *TeamBetNum;
@property (nonatomic,strong) NSNumber *TeamNewAddNum;
@property (nonatomic,strong) NSNumber *TeamLoginNum;

@property(nonatomic,strong) void(^callBackSuccessBlock)(ApiBaseManager *manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(ApiBaseManager *manager,NSString *errorCode);
- (void)refreashDataAndShow;
@end
