//
//  MCBasePWFModel.h
//  TLYL
//
//  Created by miaocai on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MCShowBetModel : NSObject

/**列表中选择的返点【左边的数值】*/
@property (nonatomic,strong) NSString *BetRebate;

/**如实*/
@property (nonatomic,strong) NSString *realRebate;

/**虚拟*/
@property (nonatomic,strong) NSString *virtualRebate;

@property (nonatomic,strong) NSString *showRebate;

@end

@interface MCItemModel : NSObject

@property (nonatomic,strong) NSString *maxBallNumber;

@property (nonatomic,strong) NSString *minBallNumber;

@property (nonatomic,strong) NSString *info;

@property (nonatomic,strong) NSString *danma;

@end




@interface MCBaseSelectedModel : NSObject

@property (nonatomic,strong) NSMutableArray <NSString *>*selectedArray;

@property (nonatomic,assign) int index;

@end



@interface MCBasePWFModel : NSObject

//@property (nonatomic,strong) NSString *BetRebate;
/**球总数*/
@property (nonatomic,strong) NSString *ballCount;
/**球开始数字*/
@property (nonatomic,strong) NSString *ballStartNumber;
/**球结束数字*/
@property (nonatomic,strong) NSString *ballEndNumber;
/**球颜色*/
@property (nonatomic,strong) NSString *ballColor;
/**球文本*/
@property (nonatomic,strong) NSString *ballText;
/**列数*/
@property (nonatomic,strong) NSString *columnCount;
/**提示语*/
@property (nonatomic,strong) NSString *info;
/**行数*/
@property (nonatomic,strong) NSString *lineCount;
/**最多选择球数*/
@property (nonatomic,strong) NSString *maxBallNumber;
/**玩法id*///有可能相同
@property (nonatomic,strong) NSString *methodId;
/**最少选择球数*/
@property (nonatomic,strong) NSString *minBallNumber;
/**互斥*/  //0 不互斥 1上下互斥  2只能选一个
@property (nonatomic,strong) NSString *mutex;
/**二级玩法*/
@property (nonatomic,strong) NSString *name;
/**玩法唯一标示*/
@property (nonatomic,strong) NSString *playOnlyNum;
/**一级玩法id*/
@property (nonatomic,strong) NSString *typeId;
/**一级玩法*/
@property (nonatomic,strong) NSString *typeName;
/**求数据源*/
@property (nonatomic,strong) NSArray<MCItemModel *>*item;
/**UI布局样式*/ // 0 无 1有 2 输入框
@property (nonatomic,strong) NSString *filterCriteria;
/**菜种*/// ef:ssc esf
@property(nonatomic,strong) NSString *lotteryCategories;
/**选中号码球数据源*/
@property(nonatomic,strong) NSMutableArray <MCBaseSelectedModel *>*baseSelectedModel;
/**行高*/
@property (nonatomic,assign) CGFloat lineH;
/**ssc选项卡个数*/
@property (nonatomic,strong) NSString *SelectedCardNumber;
/**ssc是否显示选项卡*/
@property (nonatomic,strong) NSString *isShowSelectedCard;
/**够选中的选项卡*/
@property (nonatomic,strong) NSMutableArray *selectedCardArray;
/**单式数据*/
@property (nonatomic,strong) NSArray *danShiArray;
/**随机按钮 1 显示 0 不显示*/
@property(nonatomic,strong) NSString *isMachineSelectEnabled;

/**k3是否tongxuan*/
@property (nonatomic,strong) NSString *tongxuan;
/**k8是否任选非1*/
@property (nonatomic,strong) NSString *filterCriteriaNotAll;
/**是否是定位胆*/
@property (nonatomic,strong) NSString *isDingWeiDan;
/**是否是胆拖*/
@property (nonatomic,strong) NSString *isDanTuo;
/**彩种名称*/ //极速秒秒彩
@property (nonatomic,strong) NSString *czName;
/**彩种ID*/ //
@property (nonatomic,strong) NSString *LotteryID;
/**圆角分模式*/
@property (nonatomic,assign)  float yuanJiaoFen;
/**倍数*/
@property (nonatomic,assign) int multiple;
/**奖金*/
@property (nonatomic,assign) double bonus;
/**盈利*/
@property (nonatomic,assign) double yinli;
/**金额*/
@property (nonatomic,assign) double payMoney;
/**注数*/
@property (nonatomic,assign) int stakeNumber;
/**需不需要补0*/  //@"1"->补0
@property (nonatomic,strong) NSString *isAddZero;
/**当前彩种是否开售（1：开售，0：未开售）*/
@property (nonatomic,strong) NSString *SaleState;
///**当前彩种的最大可投注返点*/
//@property (nonatomic,strong) NSString *MaxRebate;
///**当前彩种的投注返点*/
//@property (nonatomic,strong) NSString *BetRebate;
/**投注模式("0",   复式 ,"8",   单式,"16",  组合,"1",  胆拖)*/
@property (nonatomic,strong) NSString *BetMode;
/**投注期号*/
@property (nonatomic,strong) NSString * IssueNumber;

/** 元角分*/
@property (nonatomic,strong) NSString * Mode;

/**具体彩种返点  A1*/
@property (nonatomic,strong) NSString * czRebate;

/**彩种投注返点  A2*/
@property (nonatomic,strong) NSString * czTZRebate;

/**用户注册返点率 B1*/
@property (nonatomic,strong) NSString * userRegisterRebate;

/**商户返点率    C1*/
@property (nonatomic,strong) NSString * shangHuRebate;

/**商户最小值  C2*/
@property (nonatomic,strong) NSString * shangHuMinRebate;

/**列表间隔   C3*/
@property (nonatomic,strong) NSString * XRebate;


/**用户最终选择的返点*/
@property (nonatomic,strong) NSString * userSelectedRebate;
@property (nonatomic,strong) NSString *showRebate;

/**基础奖金（最大）*/
@property (nonatomic,strong) NSString * maxAwardAmount;
/**基础奖金（最小）*/
@property (nonatomic,strong) NSString * minAwardAmount;

/**利润率追号专用奖金*/
@property (nonatomic,strong) NSString * profitChaseAwardAmount;

@end





