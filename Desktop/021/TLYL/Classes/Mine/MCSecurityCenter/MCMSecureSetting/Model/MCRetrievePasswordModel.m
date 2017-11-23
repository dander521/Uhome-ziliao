//
//  MCRetrievePasswordModel.m
//  TLYL
//
//  Created by MC on 2017/10/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRetrievePasswordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"


//验证密保答案是否正确
#define retrieve_password_securityStr  @"web-api/api/v4/retrieve_password"


@interface MCRetrievePasswordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    
    NSDictionary * _dic;
    
}



@end

@implementation MCRetrievePasswordModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        _dic = dic;
    }
    return self;
}


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
    
    return retrieve_password_securityStr;
    
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    //    UserID	是	String	用户 ID
    //    FlagType	是	Int	类型（1：密保，2：提示语；这里传固定值1）
    //    SecurityCount	是	Int	获取几个问题（一般为2~5）
    NSDictionary *dic= _dic;
    
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
}


@end









































