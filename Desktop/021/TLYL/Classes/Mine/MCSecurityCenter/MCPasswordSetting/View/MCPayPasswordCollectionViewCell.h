//
//  MCPayPasswordCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCPayPasswordBlock)(NSDictionary *dic);
@interface MCPayPasswordCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong) id dataSource;
@property (nonatomic,copy)  MCPayPasswordBlock block;

@end
