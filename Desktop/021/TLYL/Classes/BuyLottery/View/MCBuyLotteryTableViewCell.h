//
//  MCBuyLotteryTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

@protocol MCBuyLotteryCellDelegate <NSObject>
@required

- (void)cellDidSelectWithModel:(MCUserDefinedLotteryCategoriesModel *)model;
@end
@interface MCBuyLotteryTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic, weak) id<MCBuyLotteryCellDelegate>delegate;

@property (nonatomic,strong) NSMutableArray *  dataSource;

@property (nonatomic,strong) UILabel* maintitleLab;
@end
