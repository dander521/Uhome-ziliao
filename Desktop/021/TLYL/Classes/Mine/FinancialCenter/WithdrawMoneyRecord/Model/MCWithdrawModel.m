//
//  MCWithdrawModel.m
//  TLYL
//
//  Created by miaocai on 2017/7/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWithdrawModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"



@interface MCWithdrawModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCWithdrawModel


-(BOOL)isShowHud{
    return YES;
}
- (BOOL)isShowError{
    return YES;
}
- (BOOL)isShowNoNet{
    return YES;
}
- (BOOL)isShowNodata{
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
    
    return @"web-api/api/v4/user_withdraw_record";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{@"DrawingsState":_drawingsState,@"BeginDate":_beginDate,@"EndDate":_endDate,@"CurrentPageIndex":_currentPageIndex,@"CurrentPageSize":_currentPageSize};
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
    NSLog(@"er=----%@",errorCode);
}

@end
