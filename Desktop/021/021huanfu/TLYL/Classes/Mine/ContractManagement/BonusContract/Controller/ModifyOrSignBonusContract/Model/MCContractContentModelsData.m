//
//  MCContractContentModelsData.m
//  TLYL
//
//  Created by MC on 2017/11/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCContractContentModelsData.h"

@implementation MCContractContentModelsData
singleton_m(MCContractContentModelsData)

-(void)addInitModel{
    
    MCGetMyAndSubSignBounsContractDetailDataModel  * model =  [[MCGetMyAndSubSignBounsContractDetailDataModel alloc]init];
    model.BetMoneyMin = @"0";
    model.LossMoneyMin = @"0";
    model.ActivePersonNum = @"0";
    model.DividendRatio = @"0";
    
    [self.dataSource addObject:model];
}

/*
 * 增
 */
-(void)addDataSourceModel:(MCGetMyAndSubSignBounsContractDetailDataModel  *)model{
    [self.dataSource addObject:model];
}

/*
 * 删
 */
-(void)deleteDataSourceModel:(MCGetMyAndSubSignBounsContractDetailDataModel  *)model{
    [self.dataSource removeObject:model];
}

/*
 * 清空
 */
-(void)removeDataSource{
    [self.dataSource removeAllObjects];
}

-(NSMutableArray<MCGetMyAndSubSignBounsContractDetailDataModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
