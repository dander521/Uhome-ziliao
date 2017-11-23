//
//  MCRecordTool.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCDatePickerView.h"
#import "MCInputView.h"
#import "DatePickerView.h"
#import "MCSignalPickView.h"
#import "MCNaviSelectedPopView.h"
#import "MCPopAlertView.h"
#import "MCGroupPaymentModel.h"
#import "MCNaviButton.h"

@interface MCRecordTool : NSObject

+(NSDate *)getDateWithStr:(NSString *)birthdayStr;
+ (BOOL)bissextile:(int)year;

#pragma mark-帐变记录
+(NSArray *)getSourceCodeArray;
+(NSDictionary *)getSourceCodeDic;
+(NSDictionary *)getCode_SourceDic;
+(MCUserARecordModel *)getAccountType:(MCUserAccountRecordDetailDataModel *)dataSource;

#pragma mark-设置你需要增加或减少的年、月、日即可获得新的日期，上述的表示获取mydate日期前一个月的日期，如果该成+1，则是一个月以后的日期，以此类推都可以计算。
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


+ (NSArray *)GetMonthFirstAndLastDay;
@end





















