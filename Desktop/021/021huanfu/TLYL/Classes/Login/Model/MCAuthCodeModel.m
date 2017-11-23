//
//  MCAuthCodeModel.m
//  TLYL
//
//  Created by miaocai on 2017/9/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCAuthCodeModel.h"

#import "NSDictionary+helper.h"

@interface MCAuthCodeModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end


@implementation MCAuthCodeModel



- (enum ManagerRequestMethod)requestMethod{
    
    return ManagerRequestMethodRequestMethodRestPOST;
}

- (enum APIResponseDataType)responseDataType{
    
    return APIResponseDataTypeRawData;
}
- (void)refreashDataAndShow{
    
    ApiBaseManager *baseManager = [[ApiBaseManager alloc] initWithUrlProvider:self];
    baseManager.apiCallBackDelegate = self;
    baseManager.requestCustomizeDelegate = self;
    [baseManager loadData];
    
}

- (NSDictionary<NSString *,NSString *> *)headerForManagerWithManager:(ApiBaseManager *)manager{
    
    return @{@"Token":@"",@"platformCode":@"2",@"userId":@""};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/get_auth_code";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    return @{};
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    
    
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
}


@end
