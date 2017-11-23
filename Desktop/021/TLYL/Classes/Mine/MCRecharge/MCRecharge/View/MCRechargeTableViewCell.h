//
//  MCRechargeTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRechargeCollectionViewCell.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMineCellModel.h"

@protocol MCRechargeTypeDelegate <NSObject>

@required
/*
 * 选择付款方式
 */
-(void)celldidSelectPaymentType:(MCPaymentModel *)type;

@end

@interface MCRechargeTableViewCell : UITableViewCell


+(CGFloat)computeHeight:(NSUInteger)info;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property(nonatomic, strong)UITextField * textField;

@property (nonatomic, weak) id<MCRechargeTypeDelegate>delegate;

@end
