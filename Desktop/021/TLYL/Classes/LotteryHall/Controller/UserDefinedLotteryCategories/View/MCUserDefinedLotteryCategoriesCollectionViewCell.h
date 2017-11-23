//
//  MCUserDefinedLotteryCategoriesCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "MCUserDefinedLotteryCategoriesModel.h"

@interface MCUserDefinedHadSelectedCZCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MCUserDefinedLotteryCategoriesModel * dataSource;


@end

@interface MCUserDefinedLotteryCategoriesCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MCUserDefinedLotteryCategoriesModel * dataSource;

-(void)setCellSelected:(BOOL)selected;
@end
