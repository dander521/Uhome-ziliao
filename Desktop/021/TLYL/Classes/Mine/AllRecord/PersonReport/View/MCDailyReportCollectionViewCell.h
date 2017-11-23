//
//  MCDailyReportCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyReportModel.h"
@interface MCDailyReportCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray <MCGetMyReportlstModel *>* dataMarray;

@end
