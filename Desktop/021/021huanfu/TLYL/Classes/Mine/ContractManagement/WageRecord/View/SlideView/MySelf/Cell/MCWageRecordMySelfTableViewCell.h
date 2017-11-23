//
//  MCWageRecordMySelfTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetDaywagesThreeRdRecordModel.h"

@interface MCWageRecordMySelfTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGetDaywagesThreeRdRecordDetailDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end
