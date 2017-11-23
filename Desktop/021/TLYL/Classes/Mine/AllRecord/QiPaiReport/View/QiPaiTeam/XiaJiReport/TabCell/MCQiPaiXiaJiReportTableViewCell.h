//
//  MCQiPaiXiaJiReportTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQiPaiXiaJiReportModel.h"

@interface MCQiPaiXiaJiReportTableViewCell : UITableViewCell

@property (nonatomic,strong)MCQiPaiXiaJiReportCommModel * dataSource;

+(CGFloat)computeHeight:(id)info;


@end
