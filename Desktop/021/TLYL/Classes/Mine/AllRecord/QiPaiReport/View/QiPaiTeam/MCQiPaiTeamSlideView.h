//
//  MCQiPaiTeamSlideView.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCQiPaiXiaJiReportCollectionViewCell.h"
#import "MCQiPaiMyselfReportCollectionViewCell.h"
#import "MCQiPaiTeamReportCollectionViewCell.h"
#import "MCMineHeader.h"
@interface MCQiPaiTeamProperty : NSObject
singleton_h(MCQiPaiTeamProperty)
@property(nonatomic, strong) NSString * statTime;
@property(nonatomic, strong) NSString * endTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, assign) BOOL IsHistory;
@property(nonatomic, strong) NSString * GetUserType;//下级类型（0：全部，1：会员，2：代理）
@property(nonatomic, strong) NSString * UserName;//默认传空串，当搜索用户名时传所搜用户名

@end

@interface MCQiPaiTeamSlideView : UIView

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *selectedTitleArray;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *SlideSelectedColor;

+(MCQiPaiTeamSlideView *)segmentControlViewWithFrame:(CGRect)frame;

-(void)btnTouch:(UIButton *)sender;

@property (nonatomic, weak)MCQiPaiXiaJiReportCollectionViewCell *xiaJiCell;
@property (nonatomic, weak)MCQiPaiMyselfReportCollectionViewCell *myselfCell;
@property (nonatomic, weak)MCQiPaiTeamReportCollectionViewCell *teamCell;

@end





















