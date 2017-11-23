//
//  MCBonusJieSuanQiYueTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetDividendSettlementModel.h"
#import "MCMyXiaJiBonusContractListModel.h"

@interface MCBonusJieSuanQiYueTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(MCGetDividendSettlementDataModel *)info;

@property (nonatomic,strong)MCGetDividendSettlementDataModel  *  dataSource;
@property (nonatomic,strong)MCMyXiaJiBonusContractListDeatailDataModel * models;

@end









