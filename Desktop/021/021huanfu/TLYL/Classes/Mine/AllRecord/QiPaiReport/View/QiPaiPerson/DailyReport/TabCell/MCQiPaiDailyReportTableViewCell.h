//
//  MCQiPaiDailyReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGamePersonalReportModel.h"

@interface MCQiPaiDailyReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGamePersonalReportlstModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end
