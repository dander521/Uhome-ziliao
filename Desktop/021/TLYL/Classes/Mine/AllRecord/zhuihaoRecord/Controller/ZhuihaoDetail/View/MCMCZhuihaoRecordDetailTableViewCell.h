//
//  MCMCZhuihaoRecordDetailTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserChaseRecordDetailModel.h"
#import "MCUserChaseRecordModel.h"

typedef void (^CancelOrderOneTimeBlock)(void);
typedef void(^GoToDetailBlock)(MCUserChaseRecordDetailSubDataModel * model,MCUserChaseRecordDetailDataModel * Amodel);

@interface MCMCZhuihaoRecordDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)MCUserChaseRecordDetailDataModel * dataSource;

@property (nonatomic,strong)MCUserChaseRecordDataModel *dataContent;

+(CGFloat)computeHeight:(MCUserChaseRecordDetailDataModel *)dataSource;

@property (nonatomic, copy) CancelOrderOneTimeBlock cancelBlock;

@property (nonatomic, copy) GoToDetailBlock   goToBlock;

@end
