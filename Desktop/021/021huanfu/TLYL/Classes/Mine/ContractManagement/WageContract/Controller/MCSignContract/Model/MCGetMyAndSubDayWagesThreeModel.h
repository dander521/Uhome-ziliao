//
//  MCGetMyAndSubDayWagesThreeModel.h
//  TLYL
//
//  Created by MC on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMyDayWagesThreeRdListDataModel.h"

//获取自己和下级的日工资契约 （日工资3）
@interface MCGetMyAndSubDayWagesThreeModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface MCGetMyAndSubDayWagesThreeDataModel : NSObject

@property(nonatomic,strong) NSString * SuperiorDayWageStandard;
@property(nonatomic,strong) NSString * SuperiorUserDayWages;
@property(nonatomic,strong) NSString * MaxdDayWagesProportion;
@property(nonatomic,strong) NSArray  * SubordinateDayWagesThree;
@property(nonatomic,strong) NSArray  * InitDayWagesRules;
@property(nonatomic,strong) NSArray  * MyDayWagesThree;
@property(nonatomic,strong) NSString * RuleID;

@end



