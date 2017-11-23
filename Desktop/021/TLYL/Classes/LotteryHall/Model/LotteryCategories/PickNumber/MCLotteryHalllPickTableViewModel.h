//
//  MCLotteryHalllPickTableViewModel.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBallCollectionModel.h"
#import "MCBasePWFModel.h"

@interface MCLotteryHalllPickTableViewModel : NSObject


/** info*/
@property (nonatomic,strong) NSString *info;

/** ballCount*/
@property (nonatomic,assign) int ballCount;

/** index*/
@property (nonatomic,assign) int index;

@end
