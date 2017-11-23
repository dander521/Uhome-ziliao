//
//  MCQiPaiMyselfReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQiPaiMyselfReportModel.h"

@interface MCQiPaiMyselfReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCQiPaiMyselfReportDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;


@end
