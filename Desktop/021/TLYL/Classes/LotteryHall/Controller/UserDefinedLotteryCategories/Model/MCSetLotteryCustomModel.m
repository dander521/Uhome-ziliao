//
//  MCSetLotteryCustomModel.m
//  TLYL
//
//  Created by MC on 2017/8/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSetLotteryCustomModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

#define  SetLotteryCustomURL  @"web-api/api/v4/set_lottery_custom"
@interface MCSetLotteryCustomModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCSetLotteryCustomModel
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
    
    return SetLotteryCustomURL;
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{
                         @"CustomItem":_CustomItem
                         };
    
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
    NSLog(@"%@---%@",SetLotteryCustomURL,manager.ResponseRawData);
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    NSLog(@"er=--%@--%@",SetLotteryCustomURL,errorCode);
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
}



@end





