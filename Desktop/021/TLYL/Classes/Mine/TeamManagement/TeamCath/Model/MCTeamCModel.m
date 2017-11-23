

//
//  MCTeamCModel.m
//  TLYL
//
//  Created by miaocai on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamCModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCTeamCModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCTeamCModel
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
    
    return @"web-api/api/v4/team_account_record";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
    NSDictionary *dic =nil;
    if ([self.ThisUserName isEqualToString:@""]||self.ThisUserName == nil) {
         dic=@{@"IsHistory":[NSNumber numberWithBool:self.IsHistory],@"Source":[NSNumber numberWithInt:self.Source],@"InsertTimeMin":self.InsertTimeMin,@"InsertTimeMax":self.InsertTimeMax,@"CurrentPageIndex":[NSNumber numberWithInt:self.CurrentPageIndex],@"CurrentPageSize":[NSNumber numberWithInt:self.CurrentPageSize]};
    } else {
        dic=@{@"IsHistory":[NSNumber numberWithBool:self.IsHistory],@"Source":[NSNumber numberWithInt:self.Source],@"InsertTimeMin":self.InsertTimeMin,@"InsertTimeMax":self.InsertTimeMax,@"CurrentPageIndex":[NSNumber numberWithInt:self.CurrentPageIndex],@"CurrentPageSize":[NSNumber numberWithInt:self.CurrentPageSize],@"ThisUserName":self.ThisUserName};
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
    
    NSLog(@"%@-------",manager.ResponseRawData);
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSDictionary *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
    NSLog(@"er=----%@",errorCode);
}

@end
