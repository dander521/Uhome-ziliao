//
//  MCRechargeOrderReminderModel.m
//  TLYL
//
//  Created by MC on 2017/8/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeOrderReminderModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCRechargeOrderReminderModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCRechargeOrderReminderModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
-(BOOL)isShowHud{
    return YES;
}
- (BOOL)isShowError{
    return NO;
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
    
    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/add_order_reminder";
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];

    NSDictionary *dic =@{
                             @"PayRealName":_PayRealName,
                             @"TransferAmount":_TransferAmount,
                             @"TransferTime":_TransferTime,
                             @"ReceiveName":_ReceiveName,
                             @"ReceiveBank":_ReceiveBank,
                             @"ReceiveCardNumber":_ReceiveCardNumber,
                             @"OrderNumber":_OrderNumber,
                             @"PayCarNumber":_PayCarNumber
                         };
    
    NSString *jsonStr = [dic convertToJsonData];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    
    
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager);
    }

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
    NSLog(@"er=---add_order_reminder---%@",errorCode);
}



@end























