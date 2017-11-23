//
//  MCLotteryDrawDetailsCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCLotteryDrawDetailsCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) id dataSource;

+(CGFloat)computeHeight:(id)info;

@end
