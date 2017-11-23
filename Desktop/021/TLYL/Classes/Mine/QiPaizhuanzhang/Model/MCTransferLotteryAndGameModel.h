//
//  MCTransferLotteryAndGameModel.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

//彩票余额与棋牌余额互转
//web-api/api/v4/transfer_lottery_and_game
@interface MCTransferLotteryAndGameModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
