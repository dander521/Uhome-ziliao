//
//  MCModifyOrSignBonusContractCellView.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MCGetMyAndSubSignBounsContractModel.h"

@interface MCModifyOrSignBonusContractCellView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong)MCGetMyAndSubSignBounsContractDetailDataModel * dataSouce;

@end
