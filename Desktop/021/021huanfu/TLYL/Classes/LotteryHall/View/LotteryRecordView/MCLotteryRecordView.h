//
//  MCLotteryRecordView.h
//  TLYL
//
//  Created by MC on 2017/6/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLotteryRecordTableViewCell.h"

@protocol MCLotteryRecordDelegate <NSObject>
@required
/*
 *  查看完整期号
 */
-(void)MCLookAllLotteryRecord;
/*
 *  查看开奖走势
 */
-(void)MCLookKaiJiangZouShi;
@end

@interface MCLotteryRecordView : UIView

@property (nonatomic, weak) id<MCLotteryRecordDelegate>delegate;
@property (nonatomic,strong) id dataSource;
@property (nonatomic,assign) NSString * LotteryCode;
@property (nonatomic,strong)MCUserDefinedLotteryCategoriesModel * model;//

+(CGFloat)computeHeight:(id)info;
- (instancetype)initWithFrame:(CGRect)frame andModel:(MCUserDefinedLotteryCategoriesModel *)model;

//上半部分
@property(nonatomic, strong)UIView * upView;
@end

