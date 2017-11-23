//
//  MCRechargePayMoneyTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGroupPaymentModel.h"

@protocol MCRechargePayMoneyDelegate <NSObject>
@required
/*
 * 选择金额
 */
-(void)celldidSelectChooseMoney:(id)money;

@end

@interface MCRechargePayMoneyTableViewCell : UITableViewCell

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic, weak) id<MCRechargePayMoneyDelegate>delegate;

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) id dataSource;
@property (nonatomic,strong) UITextField * textField;


/*
 * 根据选择不同的充值方式  变化充值金钱的范围
 */
-(void)setRangeOfMoney:(MCPaymentModel *)model;

@end
