//
//  MCPaySelectedLotteryTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBaseSwipeTableViewCell.h"
#import "MCPaySelectedLotteryModel.h"

@interface MCPaySelectedLotteryTableViewCell : MGBaseSwipeTableViewCell

+(CGFloat)computeHeight:(id _Nullable )info;

@property (nonatomic,strong) MCPaySelectedCellModel* _Nullable dataSource;

@end

