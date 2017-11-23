//
//  MCBandRealNameModel.m
//  TLYL
//
//  Created by MC on 2017/8/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBandRealNameModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCBandRealNameModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCBandRealNameModel
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

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
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/band_real_name";
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSString *UserID=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        UserID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    NSDictionary *dic =@{@"UserID":UserID,@"RealName":_RealName};
    
    NSString *jsonStr = [dic convertToJsonData];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    
    
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }
    
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
    NSLog(@"er=--band_real_name--%@",errorCode);
}


@end
