//
//  MCQiPaiPersonSlideView.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQiPaiDailyReportCollectionViewCell.h"
#import "MCQiPaiSummaryReportCollectionViewCell.h"
#import "MCMineHeader.h"
@interface MCQiPaiPersonProperty : NSObject
singleton_h(MCQiPaiPersonProperty)
@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;

@end

@interface MCQiPaiPersonSlideView : UIView

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *selectedTitleArray;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *SlideSelectedColor;

+(MCQiPaiPersonSlideView *)segmentControlViewWithFrame:(CGRect)frame;

-(void)btnTouch:(UIButton *)sender;

@property (nonatomic, weak)MCQiPaiDailyReportCollectionViewCell *dailyCell;
@property (nonatomic, weak)MCQiPaiSummaryReportCollectionViewCell *summaryCell;

@end





















