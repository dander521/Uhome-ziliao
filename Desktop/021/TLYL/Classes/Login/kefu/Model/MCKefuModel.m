//
//  MCKefuModel.m
//  TLYL
//
//  Created by miaocai on 2017/8/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKefuModel.h"
#import "NSDictionary+helper.h"

@interface MCKefuModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCKefuModel
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
    
    return @{@"Token":@"",@"platformCode":@"2",@"userId":@""};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/online_service_url";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    NSDictionary *dic =@{};
    NSString *jsonStr = [dic convertToJsonData];
    return @{@"params":jsonStr
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
 
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }
    

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
    NSLog(@"er=----%@",errorCode);
}


@end
