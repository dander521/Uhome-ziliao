//
//  MCLotteryRecordModel.m
//  TLYL
//
//  Created by MC on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryRecordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCLotteryRecordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCLotteryRecordModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
-(BOOL)isShowHud{
    return YES;
}
- (BOOL)isShowError{
    return NO;
}
- (BOOL)isShowNoNet{
    return NO;
}
- (BOOL)isShowNodata{
    return NO;
}
- (enum ManagerRequestMethod)requestMethod{
    
    return ManagerRequestMethodRequestMethodRestPOST;
}

- (enum APIResponseDataType)responseDataType{
    
    return APIResponseDataTypeJson;
}
- (void)refreashDataAndShow{
    
    ApiBaseManager *baseManager = [[ApiBaseManager alloc] initWithUrlProvider:self];
    baseManager.apiCallBackDelegate = self;
    baseManager.requestCustomizeDelegate = self;
    NSNumber *number = [baseManager loadData];
    
}

- (NSDictionary<NSString *,NSString *> *)headerForManagerWithManager:(ApiBaseManager *)manager{
    
    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    if (_type == MMCBET) {
        return @"web-api/api/v4/get_mmc_issue";
    }
    return @"web-api/api/v4/get_history_issue";
   
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic = nil;
    if (_type == MMCBET) {
        dic =@{
               @"LotteryCode":@"mmc的id",
               @"CurrentPageSize":@"当前也大小",
               @"CurrentPageIndex":@"当前页下标",
               @"BeginTime":@"开始时间",
               @"EndTime":@"结束时间"
               };

    } else {
        dic =@{
               @"LotteryCode":@(_LotteryCode),
               @"Size":@(_Size),
               @"Page":@(_Page)
               };

    }
   
    
      NSString *jsonStr = [dic convertToJsonData];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    
    [BKIndicationView dismiss];
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    NSLog(@"er=----%@",[NSString stringWithFormat:@"%@",errorCode]);
}


@end













































