//
//  MCMyselfWageContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyDayWagesThreeRdListDataModel.h"

typedef void(^popDayWageRuleBlock)();
@interface MCMyselfWageContractTableViewCell : UITableViewCell

@property (nonatomic,strong)MCMyDayWagesThreeRdDayRuleDataModel *  dataSource;

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,copy)popDayWageRuleBlock dayWageRuleBlock;

@end
