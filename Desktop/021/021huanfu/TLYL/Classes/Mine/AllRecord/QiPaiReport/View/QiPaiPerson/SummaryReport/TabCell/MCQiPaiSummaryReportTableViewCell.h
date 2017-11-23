//
//  MCQiPaiSummaryReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGamePersonalReportModel.h"

@interface MCQiPaiSummaryReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGamePersonalReportCommModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end
