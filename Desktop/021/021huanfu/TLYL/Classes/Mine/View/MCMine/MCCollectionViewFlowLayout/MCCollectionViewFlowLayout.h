//
//  MCCollectionViewFlowLayout.h
//  TLYLSF
//
//  Created by Canny on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置section的背景色
@protocol MCCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section;

@end

@interface MCCollectionViewFlowLayout : UICollectionViewFlowLayout

@end
