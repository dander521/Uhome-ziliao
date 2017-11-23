
//
//  MCZhuanRecordModel.m
//  TLYL
//
//  Created by miaocai on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuanRecordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCZhuanRecordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCZhuanRecordModel
-(BOOL)isShowHud{
    return YES;
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
    NSString * Token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]) {
        Token=[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    }
    return @{@"Token":Token,@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/user_transfer_record";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
    NSDictionary *dic =@{@"UserID":_UserID,@"Source":[NSNumber numberWithInt:0],@"IsHistory":[NSNumber numberWithBool:_IsHistory],@"TransferType":[NSNumber numberWithInt:_TransferType1],@"InsertTimeMin":_InsertTimeMin,@"InsertTimeMax":_InsertTimeMax,@"CurrentPageIndex":[NSNumber numberWithInt:_CurrentPageIndex],@"CurrentPageSize":[NSNumber numberWithInt:_CurrentPageSize]};
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSDictionary *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }

}

@end
