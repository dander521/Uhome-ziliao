//
//  MCModifyUserImgVCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCModifyUserImgVModel.h"

@interface MCModifyUserImgVCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MCUserImgVModel *  dataSource;

+(CGFloat)computeHeight:(id)info;

@end
