//
//  MCQiPaiSummaryReportCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCQiPaiSummaryReportCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;

- (void)refreashData;
- (void)refreashQiPaiPersonProperty;

@end
