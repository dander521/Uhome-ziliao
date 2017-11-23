//
//  MCSummaryReportCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyReportModel.h"
@interface MCSummaryReportCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MCGetMyReportDataModel * Rmodel;
@property(nonatomic, strong)UITableView *tableView;

@end
