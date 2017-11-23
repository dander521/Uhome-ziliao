//
//  MCLotteryDrawDetailsViewController.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

@interface MCLotteryDrawDetailsViewController : UIViewController

@property(nonatomic,strong)NSString * fromClass;

@property(nonatomic,strong)NSString * LotteryCode;//彩种编码值

@property(nonatomic,strong)MCUserDefinedLotteryCategoriesModel *dataSource;

@end
