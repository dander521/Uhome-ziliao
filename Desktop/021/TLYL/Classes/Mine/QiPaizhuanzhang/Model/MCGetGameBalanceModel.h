//
//  MCGetGameBalanceModel.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
//获取棋牌余额
//web-api/api/v4/get_game_balance

@interface MCGetGameBalanceModel : NSObject
singleton_h(MCGetGameBalanceModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic,strong)NSString *DsBalance;
//DsBalance    Number    棋牌余额

@end
