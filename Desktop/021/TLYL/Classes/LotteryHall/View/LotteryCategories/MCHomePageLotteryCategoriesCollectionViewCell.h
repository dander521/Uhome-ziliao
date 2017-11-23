//
//  MCHomePageLotteryCategoriesCollectionViewCell.h
//  Uhome
//
//  Created by miaocai on 2017/5/27.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCUserDefinedLotteryCategoriesModel;
@interface MCHomePageLotteryCategoriesCollectionViewCell : UICollectionViewCell
//菜种图片
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
//名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)MCUserDefinedLotteryCategoriesModel * dataSource;
    
    
@end
