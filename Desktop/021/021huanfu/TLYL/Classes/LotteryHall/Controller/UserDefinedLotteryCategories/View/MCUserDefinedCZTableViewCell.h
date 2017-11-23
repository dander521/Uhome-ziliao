//
//  MCUserDefinedCZTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

typedef void(^MCUserDefinedCZBlock)(MCUserDefinedLotteryCategoriesModel * model);


@interface MCUserDefinedCZTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(NSMutableArray *)info;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,copy)MCUserDefinedCZBlock block;

@end
