//
//  MCMyDayWagesThreeRdListDataModel.h
//  TLYL
//
//  Created by MC on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMyDayWagesThreeRdListDataModel : NSObject

@property(nonatomic,strong) NSString * UserName;
@property(nonatomic,strong) NSString * EditTime;
@property(nonatomic,strong) NSArray * Before_DayWagesRules;
@property(nonatomic,strong) NSArray * After_DayWagesRules;
@property(nonatomic,strong) NSArray * InitDayWagesRules;

@end

@interface MCMyDayWagesThreeRdDayRuleDataModel : NSObject

@property(nonatomic,strong) NSString * DayWageStandard;
@property(nonatomic,strong) NSString * DayWagesProportion;
@property(nonatomic,strong) NSString * DaySales;
@property(nonatomic,strong) NSString * ActiveNumber;
@property(nonatomic,strong) NSString * ID;



@end

