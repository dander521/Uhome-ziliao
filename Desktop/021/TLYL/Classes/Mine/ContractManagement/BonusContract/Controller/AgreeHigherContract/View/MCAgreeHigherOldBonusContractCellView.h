//
//  MCAgreeHigherOldBonusContractCellView.h
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMyBonusContractListModel.h"

@interface MCAgreeHigherOldBonusContractCellView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong)MCMyBonusContractListDeatailDataModel * dataSouce;


@end
