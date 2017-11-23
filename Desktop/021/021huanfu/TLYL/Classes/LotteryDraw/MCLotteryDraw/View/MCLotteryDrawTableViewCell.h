//
//  MCLotteryDrawTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"
@interface MCLotteryDrawTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) MCUserDefinedLotteryCategoriesModel * dataSource;

@end
