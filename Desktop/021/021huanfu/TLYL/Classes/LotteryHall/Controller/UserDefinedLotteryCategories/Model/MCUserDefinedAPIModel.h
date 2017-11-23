//
//  MCUserDefinedAPIModel.h
//  TLYL
//
//  Created by MC on 2017/7/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"


//时时彩
#define sscArry @[@"12", @"58", @"66", @"75", @"74", @"56", @"71", @"14", @"86", @"73", @"76",@"90",@"43",@"44",@"48",@"49"]

//竞速彩
#define  jscArry @[@"50",@"51",@"53",@"55"]

//快乐彩
#define   klcArry @[@"26",@"82",@"83",@"15",@"10",@"9",@"79",@"80",@"81"]

//低频彩
#define   dpcArry @[@"19",@"84",@"17",@"18"]

//11选5
#define   esfArry @[@"61",@"63",@"85",@"4",@"78",@"16",@"5",@"77"]

#define MCSaleCZIDArry  @"MC_ALLSale_CZID_Arry"


@interface MCUserDefinedAPIModel : NSObject
singleton_h(MCUserDefinedAPIModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
@property(nonatomic,assign) int BetRebate;
@property(nonatomic,assign) int LotteryCode;
@property(nonatomic,assign) int MaxRebate;
@property(nonatomic,assign) int SaleState;

- (void)refreashDataAndShow;

+(void)saveSaleCZIDArry:(NSMutableArray *)marr;

+(NSMutableArray *)getSaleCZIDArry;

+(NSMutableArray *)getGameRecordMarr;
@end
