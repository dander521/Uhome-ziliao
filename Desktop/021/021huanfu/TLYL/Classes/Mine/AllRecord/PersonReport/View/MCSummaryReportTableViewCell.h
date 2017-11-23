//
//  MCSummaryReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyReportModel.h"

@interface MCSummaryReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGetMyReportCommModel * dataSource;

+(CGFloat)computeHeight:(id)info;


@end
