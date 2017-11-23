//
//  MCStakeUntits.h
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBasePWFModel.h"
typedef NS_ENUM(NSInteger, Type_CCorAA) {
    MC_CC=0,//CC
    MC_AA,//AA
    
};
typedef NS_ENUM(NSInteger, Type_Rule) {
    MC_Add=0,//加法
    MC_Multip,//乘法
    
};

/*
 * 返回球的注数、金额等
 */
@interface MCBallPropertyModel : NSObject

/**注数*/
@property (nonatomic,assign) int stakeNumber;

@end

@interface MCStakeUntits : NSObject

/*
 * 计算彩票注数
 */
+(MCBallPropertyModel *)GetBallPropertyWithWFModel:(MCBasePWFModel *)WFmodel;


@end























