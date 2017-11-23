//
//  MCContractMgtTool.m
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCContractMgtTool.h"
#import "MCMathUnits.h"

@implementation MCContractMgtTool

//小数转成百分数【带%】
+(NSString *)getPercentNumber:(NSString *)decimals{

    float f = [decimals floatValue]*100;
    NSString * s = [NSString stringWithFormat:@"%.3f",f];
    s = GetRealSNum(s);
    s = [NSString stringWithFormat:@"%@%%",s];
    return s;
}

//小数转成百分数【不带%】
+(NSString *)getNPercentNumber:(NSString *)decimals{
    
    float f = [decimals floatValue]*100;
    NSString * s = [NSString stringWithFormat:@"%.3f",f];
    s = GetRealSNum(s);
    return s;
}

//百分数转变成小数
+(NSString *)getDecimalsNumber:(NSString *)percent{
    percent = [percent stringByReplacingOccurrencesOfString:@"%" withString:@""];
    double f = [percent doubleValue]*0.01;
    NSString * s = [NSString stringWithFormat:@"%.5f",f];
    s = [MCContractMgtTool GetRealNumWithStr:s];

    return s;
}
+(NSString *)GetRealNumWithStr:(NSString *)Snum{
    
    
    NSArray * numArr=[Snum componentsSeparatedByString:@"."];
    if (numArr.count<2) {
        return Snum;
    }
    
    NSString * xiaoshu=numArr[1];
    int index=0;
    for (int i=0; i<xiaoshu.length; i++) {
        NSString * c=[xiaoshu substringWithRange:NSMakeRange((xiaoshu.length-1-i),1)];
        if (![c isEqualToString:@"0"]) {
            
            index=(int)xiaoshu.length-i;
            xiaoshu=[xiaoshu substringWithRange:NSMakeRange(0,index)];
            if (xiaoshu.length>5) {
                xiaoshu=[xiaoshu substringToIndex:5];
            }
            return [NSString stringWithFormat:@"%@.%@",numArr[0],xiaoshu];
            
        }
        if (i==(xiaoshu.length-1)) {
            return numArr[0];
        }
    }
    
    return Snum;
    
}

+(BOOL)GetNetworkStatus{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    BOOL isOK=YES;
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            isOK=NO;
        }
    }
    if (isOK) {
        return YES;
    }
    switch (type) {
        case 1:
            
//            return @"2G";
            return YES;
            
            break;
            
        case 2:
            
//            return @"3G";
            return YES;
        case 3:
            
//            return @"4G";
            return YES;
        case 5:
            
//            return @"WIFI";
            return YES;
        default:
            
//            return @“NO-WIFI";//代表未知网络
            return NO;
            
            break;
    }
    return YES;
}
@end























