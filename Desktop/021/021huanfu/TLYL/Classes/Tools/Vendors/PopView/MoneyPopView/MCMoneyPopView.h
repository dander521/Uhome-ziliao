//
//  MCMoneyPopView.h
//  TLYL
//
//  Created by miaocai on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBasePWFModel.h"

@interface MCMoneyPopView : UIWindow

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) void(^MoneySelectRowBlock)(MCShowBetModel * model);


+ (instancetype)alertInstance;

- (void)showModelWindow;

- (void)hideModelWindow;

@end
