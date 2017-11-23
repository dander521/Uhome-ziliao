//
//  MCPersonReportSlideView.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSummaryReportCollectionViewCell.h"
#import "MCDailyReportCollectionViewCell.h"


@protocol MCSlideDelegate <NSObject>

@required



@end


@interface MCPersonReportSlideView : UIView

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *selectedTitleArray;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *SlideSelectedColor;

+(MCPersonReportSlideView *)segmentControlViewWithFrame:(CGRect)frame;

-(void)btnTouch:(UIButton *)sender;

@property (nonatomic, weak) id<MCSlideDelegate>delegate;

@property (nonatomic, weak)MCDailyReportCollectionViewCell *dailyCell;
@property (nonatomic, weak)MCSummaryReportCollectionViewCell *summaryCell;


@end





















