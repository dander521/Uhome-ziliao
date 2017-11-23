


//
//  MCMMTBmodel.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMTBmodel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCMMTBmodel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCMMTBmodel
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
    
    return @"web-api/api/v4/team_bet_record";
}


- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic = nil;
    if ([self.LikeUserName isEqualToString:@""]||self.LikeUserName == nil) {
        dic =@{@"SourceCode":[NSNumber numberWithInt:1],@"LotteryCode":self.LotteryCode,@"IsHistory":[NSNumber numberWithBool:false],@"OrderState":[NSNumber numberWithInt:self.OrderState],@"insertTimeMin":self.insertTimeMin,@"insertTimeMax":self.insertTimeMax,@"CurrentPageIndex":[NSNumber numberWithInt:self.CurrentPageIndex],@"CurrentPageSize":[NSNumber numberWithInt:self.CurrentPageSize]};
    } else {
        dic =@{@"SourceCode":[NSNumber numberWithInt:1],@"LotteryCode":self.LotteryCode,@"IsHistory":[NSNumber numberWithBool:false],@"OrderState":[NSNumber numberWithInt:self.OrderState],@"insertTimeMin":self.insertTimeMin,@"insertTimeMax":self.insertTimeMax,@"CurrentPageIndex":[NSNumber numberWithInt:self.CurrentPageIndex],@"CurrentPageSize":[NSNumber numberWithInt:self.CurrentPageSize],@"LikeUserName":self.LikeUserName};
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
