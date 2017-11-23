//
//  MCMineAddBankCardViewController.h
//  TLYL
//
//  Created by miaocai on 2017/7/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineBaseViewController.h"
#import "MCBankModel.h"
typedef NS_ENUM(NSInteger, MCPasswordAndCardType) {
    
    NOPasswordAndNOCard=1,//无资金密码  无默认银行卡
    HasPasswordAndNOCard,//有资金密码  无默认银行卡
    
};
typedef void(^MCMineAddBankCardBlock)(MCBankModel * model);

@interface MCMineAddBankCardViewController : MCMineBaseViewController

@property (nonatomic,copy)MCMineAddBankCardBlock block;

@property (nonatomic,assign)MCPasswordAndCardType type;

@end
