//
//  MCGameRecordDetailViewController.h
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MCCancleLotteryModel.h"
#import "MCGameRecordModel.h"

@interface MCGameRecordDetailViewController : UIViewController

@property (nonatomic,strong) MCGameRecordModel *dataSource;

@property (nonatomic,assign) BOOL isHistory;

@property (nonatomic,strong) NSString *PlayCode;

//流水编号
@property (nonatomic,strong) UILabel *liuShuiLabelDetail;
//订单编号
@property (nonatomic,strong) UILabel *dingDanDetailLabel;

//彩种名字
@property (nonatomic,strong) UILabel *czNameLabel;
//彩种logo
@property (nonatomic,strong) UIImageView * czLogoImgV;
//玩法名称
@property (nonatomic,strong) UILabel *wfNameLabel;
//期号
@property (nonatomic,strong) UILabel *dateTitleLabel;
//状态
@property (nonatomic,strong) UILabel *statusTitleLabel;
//投注详情
@property (nonatomic,strong) UILabel *touzhuXianQingLabelDetail;
//投注时间
@property (nonatomic,strong) UILabel *dateDetailLabel;
//奖金模式
@property (nonatomic,strong) UILabel *moshiLabelDatail;
//投注金额
@property (nonatomic,strong) UILabel *touZhujinELabelDetail;
//中奖注数
@property (nonatomic,strong) UILabel *zhongjiangZhuShuLabelDetail;
//中奖金额
@property (nonatomic,strong) UILabel *zhongjiangLabelDetail;

//开奖号码
@property (nonatomic,strong) UILabel *haoDetailLabel;
//开奖号码文本滑动的ScrollView
@property (nonatomic,strong) UIScrollView *bgview;

//touzhu-beijing
@property (nonatomic,strong) UIImageView *bgImg;

//撤单
@property (nonatomic,strong) UIButton *chedanBtn;

//继续投注
@property (nonatomic,strong) UIButton *contnueBtn;
//返回记录
@property (nonatomic,strong) UIButton *backBtn;



@property (nonatomic,strong) MCCancleLotteryModel *cancelModel;
//打底的ScrollView
@property (nonatomic,weak) UIScrollView *baseScrollView;


//开奖号码
@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *collectionViewArray;
@property (nonatomic,strong) NSString *OrderID;
@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *BetTb;
- (void)loadDataAndShow;
@end

