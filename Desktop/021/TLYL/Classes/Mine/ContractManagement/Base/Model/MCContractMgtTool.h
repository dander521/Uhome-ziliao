//
//  MCContractMgtTool.h
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCContractMgtTool : NSObject

//小数转成百分数【带%】
+(NSString *)getPercentNumber:(NSString *)decimals;

//小数转成百分数【不带%】
+(NSString *)getNPercentNumber:(NSString *)decimals;

//百分数转变成小数
+(NSString *)getDecimalsNumber:(NSString *)percent;

+(BOOL)GetNetworkStatus;
@end







