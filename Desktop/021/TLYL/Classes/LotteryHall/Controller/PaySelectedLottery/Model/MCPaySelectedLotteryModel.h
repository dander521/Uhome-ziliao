//
//  MCPaySelectedLotteryModel.h
//  TLYL
//
//  Created by miaocai on 2017/6/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//
// ## : 连接字符串和参数

#import "MCMineHeader.h"
#import <Foundation/Foundation.h>

@interface MCPaySelectedLotteryModel : NSObject

//@property (nonatomic,strong) MCBasePWFModel *baseModel;
//
//@property (nonatomic,strong) NSArray *payArray;
//
//@property (nonatomic,strong) NSArray *shoppingCarArray;


@end



@interface MCPaySelectedCellModel : NSObject

@property(nonatomic,strong) MCBasePWFModel * WFModel;
/**拼接号码(展示的格式)*/
@property (nonatomic,strong) NSString * haoMa;

/**拼接号码*/
@property (nonatomic,strong) NSMutableArray * haoMaArry;

/**拼接号码(投注的格式)*/
@property (nonatomic,strong) NSString * tz_haoMa;

/**玩法名称*/
@property (nonatomic,strong) NSString * WFName;

/**奖励金额*/
@property (nonatomic,strong) NSString * bonus;

/**注数*/
@property (nonatomic,strong) NSString * stakeNumber;

/**倍数*/
@property (nonatomic,strong) NSString * multiple;

/**购买金额*/
@property (nonatomic,strong) NSString * payMoney;

/**投注期号*/
@property (nonatomic,strong) NSString * IssueNumber;

/**玩法模式*/
@property (nonatomic,strong) NSString * BetMode;

/**玩法编码*/
@property (nonatomic,strong) NSString * PlayCode;

/**BetRebate*/
@property (nonatomic,strong) NSString * BetRebate;

/**是否能进行利润率追号*/
@property (nonatomic,assign) BOOL isCanProfitChase;

/**利润率追号专用奖金*/
@property (nonatomic,strong) NSString * profitChaseAwardAmount;

/**元角分模式*/
@property (nonatomic,strong) NSString * yuanJiaoFen;

/**返点和如实、虚拟*/
@property (nonatomic,strong) NSString * showRebate;

//是否能够机选
@property (nonatomic,strong) NSString * isMachineSelectEnabled;

@end


@interface MCPaySLBaseModel : NSObject
singleton_h(MCPaySLBaseModel)
/**数据源*/
@property (nonatomic,strong) NSMutableArray<MCPaySelectedCellModel *> *dataSource;

/**总注数*/
@property (nonatomic,strong)NSString *stakeNumber;

/**金额*/
@property (nonatomic,strong)NSString *payMoney;

/**余额*/
@property (nonatomic,strong)NSString *balance;

/**追号专用基础金额*/
@property (nonatomic,strong)NSString * zhuihaoMoney;

/**彩种类型*/ //ssc
@property(nonatomic,strong) NSString *lotteryCategories;
@property(nonatomic,strong) NSString *czName;
@property(nonatomic,strong) NSString *LotteryID;

/**总倍数*/
@property (nonatomic,strong) NSString * allMultiple;

/*
 * 增
 */
-(void)addDataSourceWithModel:(MCBasePWFModel  *)model;

/*
 * 删
 */
-(void)deleteDataSourceWithModel:(MCPaySelectedCellModel  *)model;

/*
 * 清空
 */
-(void)removeDataSource;
@end

























