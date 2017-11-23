//
//  MCGetMerchantInfoModel.m
//  TLYL
//
//  Created by miaocai on 2017/7/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetMerchantInfoModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"


@interface MCGetMerchantInfoModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end


@implementation MCGetMerchantInfoModel

singleton_m(MCGetMerchantInfoModel)
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
    NSString *Token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]) {
        Token=[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    }
    
    return @{@"Token":Token,@"platformCode":@"2"};
//    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/get_merchant_info";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSString *jsonStr = @"{}";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
    
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    if (manager.ResponseRawData[@"MaxRebate"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"MaxRebate"] forKey:MerchantMaxRebate];
    }
    if (manager.ResponseRawData[@"MinRebate"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"MinRebate"] forKey:MerchantMinRebate];
    }
    if (manager.ResponseRawData[@"Mode"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"Mode"] forKey:MerchantMode];
    }
    if (manager.ResponseRawData[@"XRebate"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"XRebate"] forKey:MerchantXRebate];
    }
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }
    

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }

}


-(void)clearData{
   
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MerchantMaxRebate];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MerchantMinRebate];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MerchantMode];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MerchantXRebate];

}
@end
