//
//  MCMMForwordModel.m
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMForwordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCMMForwordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCMMForwordModel

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
    
    return @"web-api/api/v4/transfer_to_sub";
}


- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{@"TransferMoney":self.TransferMoney,@"subUserID":self.TargetUserID,@"subUseName":self.TargetUserName,@"Password":self.Password,@"Mark":self.Mark};
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
        self.callBackSuccessBlock(manager);
    }
    
    
}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSDictionary *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager, errorCode);
    }
}
@end
