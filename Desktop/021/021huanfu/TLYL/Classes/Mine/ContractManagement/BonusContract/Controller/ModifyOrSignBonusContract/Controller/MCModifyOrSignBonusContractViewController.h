//
//  MCModifyOrSignBonusContractViewController.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyXiaJiBonusContractListModel.h"
#import "MCMineBaseViewController.h"

typedef void(^MCModifyOrSignBonusContractViewControllerGoBackBlock)();
typedef NS_ENUM(NSInteger, MCModifyOrSignBonusContractType){
    MCModifyOrSignBonusContractType_Sign=0,           //签订契约
    MCModifyOrSignBonusContractType_Modify,           //修改契约
};

@interface MCModifyOrSignBonusContractViewController : MCMineBaseViewController

@property (nonatomic,strong)MCMyXiaJiBonusContractListDeatailDataModel *models;

@property (nonatomic,assign)MCModifyOrSignBonusContractType Type;

@property (nonatomic,copy)MCModifyOrSignBonusContractViewControllerGoBackBlock goBackBlock;

@end
