//
//  MCAgreeHigherOldBonusContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyBonusContractListModel.h"

@interface MCAgreeHigherOldBonusContractTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(NSMutableArray *)info;

@property (nonatomic,strong)NSMutableArray <MCMyBonusContractListDeatailDataModel *>*  dataSource;

@end
