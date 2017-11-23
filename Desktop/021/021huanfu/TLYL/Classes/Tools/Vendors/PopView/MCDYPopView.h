//
//  MCDYPopView.h
//  TLYL
//
//  Created by miaocai on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTopUpRecordModel.h"
#import "MCZhuanRecordModel.h"
#import "MCWithdrawModel.h"
@interface MCDYPopView : UIView
@property (nonatomic,strong) MCTopUpRecordModel *dataSource;
@property (nonatomic,strong) MCWithdrawModel *dataSourceD;
@property (nonatomic,strong) MCZhuanRecordModel *dataSourceZ;
@property (nonatomic,strong) NSArray *arrData;
@property (nonatomic,strong) void(^cancelBtnBlock)();
@property (nonatomic,strong) void(^continueBtnBlock)();

- (void)show;
- (void)hidden;
@end
