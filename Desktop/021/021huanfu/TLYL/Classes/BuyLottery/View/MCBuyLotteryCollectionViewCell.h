//
//  MCBuyLotteryCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

@interface MCBuyLotteryCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) MCUserDefinedLotteryCategoriesModel*  dataSource;
+(CGFloat)computeHeight:(id)info;
@end
