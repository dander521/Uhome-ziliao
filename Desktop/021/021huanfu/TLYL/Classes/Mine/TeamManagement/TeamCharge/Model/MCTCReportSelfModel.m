

//
//  MCTCReportSelfModel.m
//  TLYL
//
//  Created by miaocai on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTCReportSelfModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCTCReportSelfModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCTCReportSelfModel

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
    
    return @"web-api/api/v4/get_team_report";
}


- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic = nil;
    if (self.allTeam) {
         dic =@{@"RebateType":[NSNumber numberWithInt:1],@"ISself":[NSNumber numberWithInt:1],@"UserID":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"BeginTime":_BeginTime,@"EndTime":_EndTime};
    } else {
        dic =@{@"RebateType":[NSNumber numberWithInt:1],@"ISself":[NSNumber numberWithInt:0],@"BeginTime":_BeginTime,@"EndTime":_EndTime};
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSDictionary *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
}
@end
