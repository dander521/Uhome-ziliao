//
//  MCDataTool.m
//  TLYL
//
//  Created by MC on 2017/6/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCDataTool.h"
#import "MCUserDefinedLotteryCategoriesModel.h"

@implementation MCDataTool

+(void)MC_SaveMarr:(NSArray *)marr withID:(NSString *)IDStr{
    
    //将模型数组转化为字典数组
    NSMutableArray *array=[NSMutableArray array];
    for (int i=0; i<marr.count; i++) {
        MCUserDefinedLotteryCategoriesModel *cellModel=marr[i];
        NSDictionary *dict=cellModel.mj_keyValues;
        [array addObject:dict];
    }
    //保存数组在本地
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString * fileName = [docDir stringByAppendingPathComponent:IDStr];
    
    [array writeToFile:fileName atomically:YES];

    
}

+(NSMutableArray *)MC_GetMarr_withID:(NSString *)IDStr{
    //取出本地的字典数组
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString * fileName = [docDir stringByAppendingPathComponent:IDStr];
    NSArray * models = [NSArray arrayWithContentsOfFile:fileName];
    //将取出来的字典数组转化为模型数组
    NSMutableArray *arrayModel=[NSMutableArray array];
    for (int i=0; i<models.count; i++) {
        
        NSDictionary *dict=models[i];
        //字典转模型
        MCUserDefinedLotteryCategoriesModel *cellModel=[MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues:dict];
        [arrayModel addObject:cellModel];
    }

    return arrayModel;
    
}
/*
 * 获取LotteryJSON_CZHelper.json的字典
 */
+(NSDictionary *)MC_GetDic_CZHelper{
    NSData *JSONData_CZHelper = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LotteryJSON_CZHelper.json" ofType:nil ]];
    NSDictionary*dic_CZHelper = [NSJSONSerialization JSONObjectWithData:JSONData_CZHelper options:NSJSONReadingAllowFragments error:nil];
    return dic_CZHelper;
}
    
/*
 * 获取LotteryJSON_CZ.json的字典
 */
+(NSDictionary *)MC_GetDic_CZ{
    NSData *JSONData_CZ = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LotteryJSON_CZ.json" ofType:nil ]];
    NSDictionary*dic_CZ = [NSJSONSerialization JSONObjectWithData:JSONData_CZ options:NSJSONReadingAllowFragments error:nil];
    return dic_CZ;
}
    
/*
 * 获取LotteryJSON_WFHelper.json的字典
 */
+(NSDictionary *)MC_GetDic_WFHelper{
    NSData *JSONData_WF = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LotteryJSON_WFHelper.json" ofType:nil ]];
    
    NSDictionary*dic_WFHelper = [NSJSONSerialization JSONObjectWithData:JSONData_WF options:NSJSONReadingAllowFragments error:nil];
   
    return dic_WFHelper;
}

/*
 * 获取省份列表
 */
+(NSDictionary *)MC_GetDic_Province{
    NSData *JSONData_Province = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvinceSelectedJSON_Helper.json" ofType:nil ]];
    
    NSDictionary*dic_Province = [NSJSONSerialization JSONObjectWithData:JSONData_Province options:NSJSONReadingAllowFragments error:nil];
    
    return dic_Province;
}

/*
 * 获取城市列表
 */
+(NSDictionary *)MC_GetDic_City{
    NSData *JSONData_City = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CitySelectedJSON_Helper.json" ofType:nil ]];
    
    NSDictionary*dic_City = [NSJSONSerialization JSONObjectWithData:JSONData_City options:NSJSONReadingAllowFragments error:nil];
    
    return dic_City;
}


/*
 * 获取银行列表
 */
+(NSDictionary *)MC_GetDic_Bank{
    NSData *JSONData_Bank = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BankJSON_Helper.json" ofType:nil ]];
    
    NSDictionary*dic_Bank = [NSJSONSerialization JSONObjectWithData:JSONData_Bank options:NSJSONReadingAllowFragments error:nil];
    
    return dic_Bank;
}

/*
 * 获取充值银行名称列表
 */
+(NSDictionary *)MC_GetDic_Recharge{
    NSData *JSONData_Recharge = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RechargeJSON_Helper.json" ofType:nil ]];
    
    NSDictionary*dic_Recharge = [NSJSONSerialization JSONObjectWithData:JSONData_Recharge options:NSJSONReadingAllowFragments error:nil];
    
    return dic_Recharge;
}

+(NSMutableArray * )GetShowBetRebateMarryWithModel:(MCBasePWFModel *)WFModel{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    /*
     * 商户返点
     */
    int  shangHuRebate = [WFModel.shangHuRebate intValue];
    
    /*
     * 用户注册返点
     */
    int userRegisterRebate = [WFModel.userRegisterRebate intValue];
    
    /*
     * 具体彩种返点
     */
    int czRebate = [WFModel.czRebate intValue];
    
    
    /*
     * 彩种投注返点
     */
    int czTZRebate = [WFModel.czTZRebate intValue];
    
    
    /*
     * 商户最小值
     */
    int shangHuMinRebate = [WFModel.shangHuMinRebate intValue];
    
    /*
     * 列表间隔
     */
    int XRebate = [WFModel.XRebate intValue];
    
#pragma mark-计算
    
    //差值= 商户返点 - 用户注册返点
    int  dValue = shangHuRebate-userRegisterRebate;
    
    /*
     * 用户该彩种返点 = 具体彩种返点 - 差值
     */
    int userCZRebate = czRebate-dValue;
    
    /*
     * 列表中最大的值
     */
    int maxListRebate;
    if (userCZRebate>czTZRebate) {
        maxListRebate=czTZRebate;
    }else{
        maxListRebate=userCZRebate;
    }

    
    /*
     * 列表中最小的值
     */
    int minListRebate =shangHuMinRebate;
    
    int count=(maxListRebate-minListRebate)/XRebate;
    for (int i=0 ; i<=count ; i++  ) {
        MCShowBetModel * model=[[MCShowBetModel alloc]init];
        
        /**列表中选择的返点【左边的数值】*/
        model.BetRebate = [NSString stringWithFormat:@"%d",minListRebate+XRebate*i];
        
        //投注时所选
        float tzSelectedRebate=minListRebate+XRebate*i;

        /*
         *      用户该彩种 - 投注时所选
         * 如实=—————————————————————— X 100%
         *             2000
         */
        model.realRebate = [NSString stringWithFormat:@"%.1f", ((userCZRebate - tzSelectedRebate)/2000.0*100.0)];
        

        /*
         *      列表中第一个值 - 投注时所选
         * 虚拟=—————————————————————— X 100%
         *             2000
         */
        model.virtualRebate = [NSString stringWithFormat:@"%.1f", ((maxListRebate - tzSelectedRebate)/2000.0*100.0)];
        
        model.showRebate = [NSString stringWithFormat:@"%@,%@",model.BetRebate,model.realRebate];
        
        [marr addObject:model];
    }
    NSMutableArray * marry=[[NSMutableArray alloc]init];
    
    [marry addObject:marr[marr.count-1]];
    [marry addObject:marr[0]];
    return marry;
}

@end






/*
 
 A  ->  (get_lottery_list)获取商户所有彩种列表
 
 ①MaxRebate	Int	当前彩种可投注的最大返点
 ②BetRebate	Int	商户的投注返点
 
 B  ->  (get_user_detail)获取商户所有彩种列表
 
 ①MyRebate	Int	我（当前登录用户）的返点
 
 
 C  ->  (get_merchant_info)获取商户信息
 
 ① MaxRebate	Int	商户允许投注的最大返点
 ② MinRebate	Int	商户允许投注的最小返点
 ③ XRebate	Int	相邻返点差值
 
 计算：
      
      商户返点率：C①     用户注册返点：B①
               差值Sub= C① - B①
 
      具体彩种返点：A①
 
      彩种投注返点：A②     用户该彩种返点：A①-Sub
 

      选项表中的最小值：C②
      选项表中的最大值：将彩种投注返点（A② ）  和 用户该彩种返点（A①-Sub） 进行比较  取最小值
 
 
             用户该彩种（A①-Sub） - 投注时所选
     如实 = ———————————————————————————————————————— X 100%
                         2000
 

 
           列表中第一个值（选项表中的最大值） - 投注时所选
     虚拟 = ———————————————————————————————————————— X 100%
                         2000
 

 */
















