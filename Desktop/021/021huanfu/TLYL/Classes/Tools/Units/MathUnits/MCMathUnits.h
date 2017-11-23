//
//  MCMathUnits.h
//  TLYL
//
//  Created by miaocai on 2017/6/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPaySelectedLotteryModel.h"
#define MC_MAXCOUNT 170

/**n的阶乘*/
#define MC_FACTORIAL(N) \
({\
int temp = N;\
if(N<0){\
temp = 0;\
}\
double result = 1;\
for (int i = 1; i<=temp; i++) {\
result = result * i;\
}\
(result);\
})\

/**n的和*/
#define MC_SUM(N)\
({\
if (N > MC_MAXCOUNT) {\
NSLog(@"数字溢出");\
}\
double result = 0;\
for (int i = 1; i<=N; i++) {\
result = result + i;\
}\
(result);\
})\

/**n到m的乘积n<m*/
#define MC_DIFFERENT(N,M)\
({\
if (M > MC_MAXCOUNT) {\
NSLog(@"数字溢出");\
}\
(MC_FACTORIAL(M)/MC_FACTORIAL(N-1));\
})\

/**n到m的排列n<m*/
#define MC_ACOMBINATION(M,N)\
({\
if (M > MC_MAXCOUNT) {\
NSLog(@"数字溢出");\
}\
(MC_FACTORIAL(M)/MC_FACTORIAL(M-N));\
})\

/**n到m的组合n<m*/
#define MC_CCOMBINATION(M,N)\
({\
if (M > MC_MAXCOUNT) {\
NSLog(@"数字溢出");\
}\
(MC_FACTORIAL(M)/(MC_FACTORIAL((M)-(N))*MC_FACTORIAL(N)));\
})\
/**随机*/
#define MC_RANDOM 0

#define GetRealFloatNum(num) [MCMathUnits removeFloatAllZero:num]
#define GetRealSNum(Snum) [MCMathUnits GetRealNumWithStr:Snum]
#define MCGetBouns(AwardAmount,userSelectedRebate,yuanJiaoFen,multiple,payMoney)  [MCMathUnits GetBounsWithAwardAmount:AwardAmount andUserSelectedRebate:userSelectedRebate andYuanJiaoFen:yuanJiaoFen andMultiple:multiple andPayMoney:payMoney]
@interface MCMoneyModel : NSObject
//奖金
@property (nonatomic ,strong)NSString * bouns;
//盈利
@property (nonatomic ,strong)NSString * yinli;
@end


@interface MCMathUnits : NSObject

/*
 * 根据玩法Model 获取标准格式
 */
+(MCPaySelectedCellModel *)GetFormatWithWFModel:(MCBasePWFModel *)WFmodel;

//*******************************************************
//个人中心：数字转汉字
//*******************************************************
+(NSString *)tzContentToChinese:(NSString *)lotteryCategories andMethodId:(NSString *)methodId andContent:(NSString * )content;
+(NSString *)tzContentToNum:(MCBasePWFModel *)WFmodel andContent:(NSString * )content;
/*
 * 银行卡号码  每隔四位添加空格
 */
+(NSString *)GetBankCardShowNum:(NSString *)num;


/*
 * 金钱   每隔三位加一个“,”
 */
+(NSString *)GetMoneyShowNum:(NSString *)num;

/*
 * 获取真实的小数点位  1.080000-》1.08  1.000-》1
 */
+(NSString*)removeFloatAllZero:(double)num;



+(double)GetNum:(double)num andWei:(int)wei;

+(MCMoneyModel *)GetBounsWithAwardAmount:(NSString *)AwardAmount andUserSelectedRebate:(NSString*)userSelectedRebate andYuanJiaoFen:(float)yuanJiaoFen andMultiple:(int)multiple andPayMoney:(double)payMoney;

+(NSString *)GetRealNumWithStr:(NSString *)Snum;
+(BOOL)isNeedCut:(NSString *)ID;
+(NSArray *)arraySortASC:(NSArray *)array;
+(NSInteger)getBallCountWithCZType:(NSString *)str;
@end
























