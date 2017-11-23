//
//  MCPaySelectedLotteryModel.m
//  TLYL
//
//  Created by miaocai on 2017/6/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPaySelectedLotteryModel.h"
#import "MCBallCollectionModel.h"
#import "MCUserMoneyModel.h"
@implementation MCPaySelectedLotteryModel

@end
@implementation MCPaySelectedCellModel

@end
@implementation MCPaySLBaseModel
singleton_m(MCPaySLBaseModel)

/*
 * 增
 */
-(void)addDataSourceWithModel:(MCBasePWFModel  *)model{
    MCPaySelectedCellModel * Smodel = [MCMathUnits GetFormatWithWFModel:model];
//    [self.dataSource addObject:Smodel];
    [self.dataSource insertObject:Smodel atIndex:0];
    self.lotteryCategories=model.lotteryCategories;
    self.LotteryID=model.LotteryID;
    self.czName=model.czName;
    
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    self.balance=GetRealSNum(userMoneyModel.LotteryMoney);//余额
    
    self.stakeNumber=[NSString stringWithFormat:@"%d",[self.stakeNumber intValue]+model.stakeNumber];

    self.payMoney=GetRealFloatNum(([self.payMoney doubleValue]+model.payMoney));

    self.allMultiple=GetRealFloatNum(([self.allMultiple intValue]+model.multiple));
    
    [self caculateZhuihaoMoney];
    
}

/*
 * 删
 */
-(void)deleteDataSourceWithModel:(MCPaySelectedCellModel  *)model{
    
    [self.dataSource removeObject:model];
    
    self.stakeNumber=[NSString stringWithFormat:@"%d",[self.stakeNumber intValue]-[model.stakeNumber intValue]];

    self.payMoney=GetRealFloatNum([self.payMoney floatValue]-[model.payMoney floatValue]);
    
    self.allMultiple=GetRealFloatNum(([self.allMultiple intValue]-[model.multiple intValue]));

    [self caculateZhuihaoMoney];
}

-(void)caculateZhuihaoMoney{
    double money=0.0;
    for (MCPaySelectedCellModel * model in self.dataSource) {
        money = money + [model.payMoney doubleValue]/[model.multiple intValue];
    }
    self.zhuihaoMoney=GetRealFloatNum(money);
}

/*
 * 清空
 */
-(void)removeDataSource{
    [self.dataSource removeAllObjects];
    self.dataSource=nil;
    self.stakeNumber=@"0";
    self.payMoney=@"0";
    self.allMultiple=@"0";
    [self caculateZhuihaoMoney];
}


-(NSMutableArray<MCPaySelectedCellModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end













