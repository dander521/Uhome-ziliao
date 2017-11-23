//
//  MCGetLotteryCustomModel.m
//  TLYL
//
//  Created by MC on 2017/8/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetLotteryCustomModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

#define  GetLotteryCustomURL  @"web-api/api/v4/get_lottery_custom"
@interface MCGetLotteryCustomModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCGetLotteryCustomModel
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
    [baseManager loadData];
    
}

- (NSDictionary<NSString *,NSString *> *)headerForManagerWithManager:(ApiBaseManager *)manager{
    
    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return GetLotteryCustomURL;
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{};
    
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
    NSLog(@"%@---%@",GetLotteryCustomURL,manager.ResponseRawData);
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    NSLog(@"er=--%@--%@",GetLotteryCustomURL,errorCode);
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
}


@end






