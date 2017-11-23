//
//  MCUserMoneyModel.h
//  TLYL
//
//  Created by MC on 2017/7/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
@interface MCUserMoneyModel : NSObject

singleton_h(MCUserMoneyModel)
@property (nonatomic,assign)BOOL isNeedLoad;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;


@property (nonatomic,strong)NSString *LotteryMoney;//	String	用户余额
@property (nonatomic,strong)NSString *FreezeMoney	;//String	冻结金额


@end
