//
//  MCMyBonusContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MGBaseSwipeTableViewCell.h"
#import "MCMyXiaJiBonusContractListModel.h"

@interface MCMyBonusContractTableViewCell : MGBaseSwipeTableViewCell

+(CGFloat)computeHeight:(id _Nullable )info;

@property (nonatomic,strong)MCMyXiaJiBonusContractListDeatailDataModel * _Nullable dataSource;

@end


