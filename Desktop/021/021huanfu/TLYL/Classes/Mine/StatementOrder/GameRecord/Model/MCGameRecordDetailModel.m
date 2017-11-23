//
//  MCGameRecordDetailModel.m
//  TLYL
//
//  Created by miaocai on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGameRecordDetailModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@implementation MCGameRecordDetailBetModel
@end

@interface MCGameRecordDetailModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end


@implementation MCGameRecordDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (id)valueForUndefinedKey:(NSString *)key{
    return @"";
}
+ (NSDictionary *)objectClassInArray
{
    
    return @{@"Bet" : [MCGameRecordDetailBetModel class]
 
             };
    
}
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
    
    return @"web-api/api/v4/user_bet_record_detail";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
    NSDictionary *dic =@{@"InsertTime":_InsertTime,@"LotteryCode":_LotteryCode,@"IsHistory":[NSNumber numberWithBool:_IsHistory],@"OrderID":_OrderID};
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
    NSLog(@"er=----%@",errorCode);
}

@end
