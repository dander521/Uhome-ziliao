//
//  MCWageRecordSlideView.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCWageRecordMySelfCollectionViewCell.h"
#import "MCWageRecordXiaJiCollectionViewCell.h"



@interface MCWageRecordSlideView : UIView

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *selectedTitleArray;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *SlideSelectedColor;

+(MCWageRecordSlideView *)segmentControlViewWithFrame:(CGRect)frame;

-(void)btnTouch:(UIButton *)sender;


@property (nonatomic, weak)MCWageRecordXiaJiCollectionViewCell *xiaJiCell;
@property (nonatomic, weak)MCWageRecordMySelfCollectionViewCell *mySelfCell;


@end





















