//
//  MCBonusContractHeaderView.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MCMyBonusContractListModel.h"
typedef void(^SettleAccountsBlock)();
typedef void(^GoToNewContractBlock)();
@interface MCBonusContractHeaderView : UIView

+(CGFloat)computeHeight:(MCMyBonusContractListDataModel *)info andLockState:(NSString *)LockState;

@property (nonatomic,strong)MCMyBonusContractListDataModel * dataSource;
@property (nonatomic,strong)NSString * lockState;
@property (nonatomic,copy)SettleAccountsBlock settleBlock;
@property (nonatomic,copy)GoToNewContractBlock goToContractBlock;

-(void)setNewState:(BOOL)isState;
@end
