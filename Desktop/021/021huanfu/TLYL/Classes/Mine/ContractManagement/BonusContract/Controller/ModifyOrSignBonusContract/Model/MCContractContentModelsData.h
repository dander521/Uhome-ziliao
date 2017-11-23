//
//  MCContractContentModelsData.h
//  TLYL
//
//  Created by MC on 2017/11/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
#import "MCGetMyAndSubSignBounsContractModel.h"

@interface MCContractContentModelsData : NSObject
singleton_h(MCContractContentModelsData)

@property (nonatomic,strong)NSMutableArray <MCGetMyAndSubSignBounsContractDetailDataModel *>* dataSource;

/*
 * 增
 */
-(void)addDataSourceModel:(MCGetMyAndSubSignBounsContractDetailDataModel  *)model;

/*
 * 删
 */
-(void)deleteDataSourceModel:(MCGetMyAndSubSignBounsContractDetailDataModel  *)model;

/*
 * 清空
 */
-(void)removeDataSource;

/*
 * 添加初始化的Model
 */
-(void)addInitModel;

@end
