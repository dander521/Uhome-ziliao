//
//  MCGetSecurityStateModel.m
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetSecurityStateModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"


//查询是否已设置密保问题
#define GetSecurityStateStr  @"web-api/api/v4/get_security_state"


@interface MCGetSecurityStateModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>



@end

@implementation MCGetSecurityStateModel
singleton_m(MCGetSecurityStateModel)
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
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
    NSString *Token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]) {
        Token=[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    }
    
    return @{@"Token":Token,@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return GetSecurityStateStr;
    
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
//    UserID	是	String	用户 ID
//    FlagType	是	Int	类型（1：密保，2：提示语；这里传固定值1）
    
    NSDictionary *dic= @{
                         @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
                         @"FlagType":@1
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
        self.callBackSuccessBlock(manager.ResponseRawData);
    }

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }

}


@end








































