//
//  MCRechargeCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGroupPaymentModel.h"

@interface MCRechargeCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) MCPaymentModel * dataSource;


@end
