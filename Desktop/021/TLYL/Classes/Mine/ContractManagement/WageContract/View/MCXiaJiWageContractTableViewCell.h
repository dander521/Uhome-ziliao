//
//  MCXiaJiWageContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBaseSwipeTableViewCell.h"
#import "MCMyXiaJiDayWagesThreeRdListModel.h"
#define StateDic  @{ @"0":@[@"待确认",@"修改契约"], @"1":@[@"已签约",@"修改契约"], @"2":@[@"未签约",@"签订契约"], @"3":@[@"已拒绝",@"修改契约"] }
@interface MCXiaJiWageContractTableViewCell : MGBaseSwipeTableViewCell

+(CGFloat)computeHeight:(id _Nullable )info;

@property (nonatomic,strong) MCMyXiaJiDayWagesThreeListModelsDataModel* _Nullable dataSource;

@end
