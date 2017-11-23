//
//  MCModifyOrSignBonusContractTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubSignBounsContractModel.h"

@interface MCModifyOrSignBonusContractTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGetMyAndSubSignBounsContractDetailDataModel * dataSource;

+(CGFloat)computeHeight:(id )info;

@property (nonatomic,assign)NSInteger row;

@end
