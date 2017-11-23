//
//  MCMyDayWagesThreeRdListDataModel.m
//  TLYL
//
//  Created by MC on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMyDayWagesThreeRdListDataModel.h"


@implementation MCMyDayWagesThreeRdListDataModel
+(NSDictionary *)objectClassInArray
{
    return @{
             @"Before_DayWagesRules" : [MCMyDayWagesThreeRdDayRuleDataModel class],
              @"After_DayWagesRules" : [MCMyDayWagesThreeRdDayRuleDataModel class],
              @"InitDayWagesRules" : [MCMyDayWagesThreeRdDayRuleDataModel class]
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

};


@end


@implementation MCMyDayWagesThreeRdDayRuleDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

};


@end












