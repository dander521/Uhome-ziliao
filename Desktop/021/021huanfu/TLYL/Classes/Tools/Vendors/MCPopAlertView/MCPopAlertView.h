//
//  MCPopAlertView.h
//  MC弹出框封装
//
//  Created by MC on 2017/10/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRechargeModel.h"
#import "MCUserAccountRecordModel.h"
#import "MCMyDayWagesThreeRdListDataModel.h"
#import "MCGetDaywagesThreeRdRecordModel.h"
#import "MCContractMgtTool.h"
#import "MCGetDividentsListModel.h"

typedef NS_ENUM(NSInteger, MCPopAlertType){
    MCPopAlertTypeTZRequest_Success=0,           //投注结果成功
    MCPopAlertTypeTZRequest_Faild,               //投注结果失败
    MCPopAlertTypeCZRequest_Confirm,             //充值确认
    MCPopAlertTypeTZRequest_Confirm,             //投注确认
    MCPopAlertTypeZhangBian_Record,              //帐变明细
    MCPopAlertTypeContractMgt_DayWageRules,      //日工资规则
    MCPopAlertTypeContractMgt_DayWageDeatil,     //日工资详情
    MCPopAlertTypeContractMgt_BonusRecordDeatil  //分红记录详情
};

typedef void(^AlertResult)(NSInteger index);

@interface MCPopAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;
#pragma mark-投注结果成功/失败/投注确认
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title message:(NSString *)message leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle;

#pragma mark-充值确认
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle RechargeModel:(MCRechargeModel *)rechargeModel;

#pragma mark-帐变明细
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle AccountRecordDetailDataModel:(MCUserAccountRecordDetailDataModel *)model;

#pragma mark-日工资规则
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  MyDayWagesThreeRdListDataModel:(MCMyDayWagesThreeRdListDataModel *)model;

#pragma mark-日工资详情
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  DaywagesThreeRdRecordDetailDataModel:(MCGetDaywagesThreeRdRecordDetailDataModel *)model;

#pragma mark-分红记录详情
- (instancetype)initWithType:(MCPopAlertType)type Title:(NSString *)title leftBtn:(NSString *)leftTitle rightBtn:(NSString *)rightTitle  MCGetDividentsListDeatailDataModel:(MCGetDividentsListDeatailDataModel *)model;

- (void)showXLAlertView;


@end






@interface MCDayWageContractRulesTableViewCell : UITableViewCell

@property (nonatomic,strong)MCMyDayWagesThreeRdDayRuleDataModel *  dataSource;

+(CGFloat)computeHeight:(id)info;


@end




























