//
//  MCHomeWageContractHeaderView.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyDayWagesThreeRdListDataModel.h"

typedef void(^HomeWageContractHeaderPopDayWageRuleBlock)();

@interface MCHomeWageContractHeaderView : UIView
@property (nonatomic,strong)MCMyDayWagesThreeRdDayRuleDataModel *  dataSource;

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,copy)HomeWageContractHeaderPopDayWageRuleBlock dayWageRuleBlock;

@end



