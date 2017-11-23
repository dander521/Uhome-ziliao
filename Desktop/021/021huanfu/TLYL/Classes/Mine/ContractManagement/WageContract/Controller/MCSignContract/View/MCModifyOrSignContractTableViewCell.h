//
//  MCModifyOrSignContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubDayWagesThreeModel.h"
@interface MCModifyOrSignContractTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(MCGetMyAndSubDayWagesThreeDataModel *)info;

@property (nonatomic,strong)MCGetMyAndSubDayWagesThreeDataModel *dataSources;

@property (nonatomic,strong)MCMyDayWagesThreeRdDayRuleDataModel * modifyOrSign_selectedModel;

@property (nonatomic,assign) int begin_T;

@property (nonatomic,assign) int end_T;

@end



