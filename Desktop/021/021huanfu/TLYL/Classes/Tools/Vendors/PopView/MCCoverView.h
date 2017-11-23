//
//  MCCoverView.h
//  TLYL
//
//  Created by miaocai on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTopUpRecordModel.h"
#import "MCTeamCModel.h"
#import "MCWithdrawModel.h"
#import "MCZhuanRecordModel.h"

@interface MCCoverView : UIView
@property (nonatomic,strong) MCTopUpRecordModel *dataSource;
@property (nonatomic,strong) MCWithdrawModel *dataSourceD;
@property (nonatomic,strong) MCZhuanRecordModel *dataSourceZ;
@property (nonatomic,strong) MCTeamCModel *teamModel;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) void (^coverViewBlock)();
@property (nonatomic,strong) void (^cancelBlock)();
- (void)show;
- (void)hidden;
@end
