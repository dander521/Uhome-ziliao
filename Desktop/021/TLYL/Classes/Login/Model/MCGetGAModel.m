


//
//  MCGetGAModel.m
//  TLYL
//
//  Created by miaocai on 2017/11/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetGAModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCGetGAModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end


@implementation MCGetGAModel



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
    
    return @{@"Token":@"",@"platformCode":@"4",@"userId":@""};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/get_GA_mode";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{@"UserName": self.UserName};
    NSString *jsonStr = [dic convertToJsonData];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,@"",timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
    

}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    [BKIndicationView dismiss];
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager);
    }
    
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    
     [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager, errorCode);
    }
}


@end
