//
//  MCLotteryHalllPickTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/6/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLotteryHalllPickTableViewModel.h"
#import "MCBasePWFModel.h"
#import "MCPickNumberHeaderView.h"
#import "NSString+Helper.h"
#import "MCTextView.h"
typedef NS_ENUM(NSInteger, MCLotterCategories) {
    MCLotterCategoriesCQ11Xuan5,//默认从0开始 11选5
    MCLotterCategoriesCQSSC,
};


@interface MCLotteryHalllPickTableViewCell : UITableViewCell

/** collectionview中号码球个数数据源*/
@property (nonatomic,strong) NSMutableArray *ballArray;
@property (nonatomic,strong) MCPickNumberHeaderView * view_selectedCard;
@property (nonatomic,strong) MCBasePWFModel *baseWFmodel;

/** 每行球的数据模型*/
@property (nonatomic,strong) MCItemModel *dataSource;
/** 选中的球数组*/
@property (nonatomic,strong) NSMutableArray *selectedBallArray;
/** 选中号码球数据源模型*/
@property (nonatomic,strong) MCBaseSelectedModel *baseSlectedModel;
/** 随机数*/
@property (nonatomic,strong) NSNumber *randomNumber;

/** 彩种类型（暂时未用到）*/
@property (nonatomic,strong) NSString *lotteriesType;

/** 彩球*/
@property (nonatomic,weak) UICollectionView *ballColletionView;
/** 彩种类型*/
@property (nonatomic,strong) void(^slectedBallBlock)( NSMutableArray *selectedBall);

/*
 * 单式  添加号码 调用检测
 */
-(BOOL)danShiaddNumber:(BOOL)isShow;

/*
 * 清空输入框
 */
-(void)danShiClear;

/*
 * 失去焦点  和  点击选项卡  进行注数计算
 */
-(void)caculateStakeNumber;
-(void)becomeFirstResp;
@property (nonatomic,strong)MCArryModel*AModel;
/** 单式textView 上一次的文本内容*/
@property (nonatomic,strong) NSString *lastNumberString;
/** 单式textView*/
@property (nonatomic,weak) MCTextView *mcTextView;
#pragma mark-点击去错处理
- (MCArryModel*)delWrongNumber:(BOOL)isShowHud;
@end
