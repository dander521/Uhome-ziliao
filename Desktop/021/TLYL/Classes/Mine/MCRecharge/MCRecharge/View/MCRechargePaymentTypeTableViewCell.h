//
//  MCRechargePaymentTypeTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGroupPaymentModel.h"
@protocol MCRechargePaymentTypeDelegate <NSObject>
@required
/*
 * 选择付款方式
 */
-(void)celldidSelectPaymentType:(MCPaymentModel *)type;
@end

@interface MCRechargePaymentTypeTableViewCell : UITableViewCell

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic, weak) id<MCRechargePaymentTypeDelegate>delegate;

+(CGFloat)computeHeight:(NSUInteger)info;

@property (nonatomic,strong) id dataSource;

@end
