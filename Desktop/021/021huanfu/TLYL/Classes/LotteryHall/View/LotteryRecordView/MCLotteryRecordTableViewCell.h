//
//  MCLotteryRecordTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

@interface MCLotteryRecordTableViewCell : UITableViewCell

@property (nonatomic,strong) id dataSource;
@property (nonatomic,strong)MCUserDefinedLotteryCategoriesModel * model;//




+(CGFloat)computeInteritemSpacing:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W;
   
    
+(CGFloat)computeWidth:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W;


+(CGFloat)computeHeight:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W;

+(CGFloat)computeLineSpacing:(MCUserDefinedLotteryCategoriesModel *)info andWidth:(CGFloat)S_W;


@end
