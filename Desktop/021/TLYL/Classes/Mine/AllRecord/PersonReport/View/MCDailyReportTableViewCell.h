//
//  MCDailyReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyReportModel.h"
@interface MCDailyReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGetMyReportlstModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end

