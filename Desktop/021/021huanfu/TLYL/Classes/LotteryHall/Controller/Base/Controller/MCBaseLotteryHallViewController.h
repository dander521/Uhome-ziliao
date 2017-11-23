//
//  MCBaseLotteryHallViewController.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBasePWFModel.h"
#import "MCStakeUntits.h"
#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCAlertView.h"
#define HEIGHTnoIssueView 40

typedef void(^Compelete)(BOOL result);

@interface MCBaseLotteryHallViewController : UIViewController

/**UITableView*/
@property (nonatomic,strong) UITableView *baseTableView;

#pragma mark - 子类需要重写以下方法

/*
 *获取随机数
 */
- (void)randomBtnClick;
/*
 *清空所有号码
 */
- (void)clearAllButtonClick;
/*
 *添加到购物车
 */
- (void)addNumberToShoppingCar:(BOOL)isShow;
/*
 *买单
 */
- (void)payTheSelectedNumbers;
/*
 * 每次重置菜种  在子类方法重写
 */
-(void)MC_PICKNUMBERVC_INIT;


-(void)KaiJiangClick;
#pragma mark - 子类需要重写以上方法

-(void)setBetListMarry;

/**时间*/
@property (nonatomic,assign) int time;
@property (nonatomic,strong) NSString * IssueNumber;
/** 传入的彩种类型*/
@property (nonatomic,strong) MCUserDefinedLotteryCategoriesModel *lotteriesTypeModel;
/**addItemLabel*/
@property (nonatomic,weak) UILabel *addItemLabel;

@property (nonatomic,weak) UIButton *addToShoppingCarBtn;

@property (nonatomic,strong) MCBasePWFModel *baseWFmodel;

@property (nonatomic,strong) NSArray *playModelArray;

/**万千百选项卡Array*/
@property (nonatomic,strong) NSMutableArray *selectedCardArray;

@property (nonatomic,strong) NSMutableArray *betRebateArray;

@property (nonatomic,strong) NSMutableArray *boModelArray;
//玩法ID
@property (nonatomic,strong) NSString * palyCode;
/**弹出视图*/
@property (nonatomic,weak) MCAlertView *alertView;
/**倒计时按钮*/
@property (nonatomic,weak) UILabel *btnDaojishi;
/**下拉按钮 玩法名称*/
@property (nonatomic,weak) UIButton *btnPCatergy;
/**近期开奖*/
@property (nonatomic,weak) UIButton *btnKaiJiang;
@property (nonatomic,assign) BOOL isShowFaildIssue;
-(void)openFailedIssue;
- (void)loadIssueData:(Compelete)compeletion;
//@property (nonatomic,assign) int uuuuuu;

/*
 * 2017年10月31日14:25:03
 * 此属性是判断是否是单式  【添加需求 单式情况下 参数面板一直显示】
 */
@property (nonatomic,assign)BOOL isDanShi;


@end



















