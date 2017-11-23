//
//  MCDataTool.h
//  TLYL
//
//  Created by MC on 2017/6/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBasePWFModel.h"
//用户选择的彩种
#define MCHomePageLotteryCategoryData @"MCHome_Lottery_CategoryData"


@interface MCDataTool : NSObject

/*
 * 存储数组
 */
+(void)MC_SaveMarr:(NSMutableArray *)marr withID:(NSString *)IDStr;

/*
 * 获取数组
 */
+(NSMutableArray *)MC_GetMarr_withID:(NSString *)IDStr;
    
/*
 * 获取LotteryJSON_CZHelper.json的字典
 */
+(NSDictionary *)MC_GetDic_CZHelper;
    
/*
 * 获取LotteryJSON_CZ.json的字典
 */
+(NSDictionary *)MC_GetDic_CZ;
    
/*
 * 获取LotteryJSON_WFHelper.json的字典
 */
+(NSDictionary *)MC_GetDic_WFHelper;

/*
 * 获取省份列表
 */
+(NSDictionary *)MC_GetDic_Province;

/*
 * 获取城市列表
 */
+(NSDictionary *)MC_GetDic_City;


/*
 * 获取银行列表
 */
+(NSDictionary *)MC_GetDic_Bank;

/*
 * 获取充值银行名称列表
 */
+(NSDictionary *)MC_GetDic_Recharge;


/*
 * 获取返点数组
 */
+(NSMutableArray * )GetShowBetRebateMarryWithModel:(MCBasePWFModel *)WFModel;
@end



































