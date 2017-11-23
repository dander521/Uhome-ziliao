//
//  MCUserDefinedLotteryCategoriesTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

typedef void(^UserDefinedLotteryCategoriesBlock)(MCUserDefinedLotteryCategoriesModel * model);

@interface MCUserDefinedLotteryCategoriesTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;
@property (nonatomic,strong) id dataSource;

@property (nonatomic,copy)UserDefinedLotteryCategoriesBlock block;
/*
 * 选中图标
 */
@property(nonatomic,strong)UIButton * selectedBtn;

@end
