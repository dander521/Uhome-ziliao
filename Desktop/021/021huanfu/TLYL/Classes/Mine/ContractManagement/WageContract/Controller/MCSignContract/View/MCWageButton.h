//
//  MCWageButton.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubDayWagesThreeModel.h"

@interface MCWageButton : UIButton

@property (nonatomic,retain)MCMyDayWagesThreeRdDayRuleDataModel *dataSource;

@property (nonatomic,assign)BOOL isSelected;


@end
