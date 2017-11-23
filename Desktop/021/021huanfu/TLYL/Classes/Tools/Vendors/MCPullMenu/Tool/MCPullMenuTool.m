//
//  MCPullMenuTool.m
//  TLYL
//
//  Created by MC on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPullMenuTool.h"

@implementation MCPullMenuTool


+(NSMutableArray *)GetSelectedWFMarrayWithCZID:(NSString *)LotteryID{
    
    NSString * UserID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString * KEY = [NSString stringWithFormat:@"%@_&_%@",UserID,LotteryID];
    NSMutableArray * marry=[[NSMutableArray alloc]init];
    marry=[MCPullMenuTool GetMarr_withID:KEY];
    return marry;
}

+(void)SaveSelectedWFMarrayWithCZID:(NSString *)LotteryID andMarray:(NSMutableArray *)marray{
    NSString * UserID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString * KEY = [NSString stringWithFormat:@"%@_&_%@",UserID,LotteryID];
    [MCPullMenuTool SaveMarr:marray withID:KEY];
}

+(void)SaveMarr:(NSMutableArray *)array withID:(NSString *)IDStr{
    
//    //将模型数组转化为字典数组
//    NSMutableArray *array=[NSMutableArray array];
//    for (int i=0; i<marr.count; i++) {
//        MCUserDefinedLotteryCategoriesModel *cellModel=marr[i];
//        NSDictionary *dict=cellModel.mj_keyValues;
//        [array addObject:dict];
//    }
    //保存数组在本地
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    
    NSString * fileName = [docDir stringByAppendingPathComponent:IDStr];
    
    [array writeToFile:fileName atomically:YES];
    
    
}

+(NSMutableArray *)GetMarr_withID:(NSString *)IDStr{
    //取出本地的字典数组
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString * fileName = [docDir stringByAppendingPathComponent:IDStr];
    NSArray * models = [NSArray arrayWithContentsOfFile:fileName];
    //将取出来的字典数组转化为模型数组
//    NSMutableArray *arrayModel=[NSMutableArray array];
//    for (int i=0; i<models.count; i++) {
//        
//        NSDictionary *dict=models[i];
//        //字典转模型
//        MCUserDefinedLotteryCategoriesModel *cellModel=[MCUserDefinedLotteryCategoriesModel mj_objectWithKeyValues:dict];
//        [arrayModel addObject:cellModel];
//    }
    NSMutableArray *arrayModel=[NSMutableArray arrayWithArray:models];
    return arrayModel;
    
}
@end
