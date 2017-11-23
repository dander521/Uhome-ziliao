//
//  MCModifyOrSignBonusContractHeaderView.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubSignBounsContractModel.h"

@interface MCModifyOrSignBonusContractHeaderView : UIView

+(CGFloat)computeHeight:(MCGetMyAndSubSignBounsContractDataModel *)info;

@property (nonatomic,strong)MCGetMyAndSubSignBounsContractDataModel * dataSource;

@property (nonatomic,strong)UILabel * lab2;

@end

