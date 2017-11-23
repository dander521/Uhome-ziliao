//
//  MCPasswordAPIModel.m
//  TLYL
//
//  Created by MC on 2017/7/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPasswordAPIModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCHasPayPwdModel.h"
//修改登录密码
#define ModifyLoginPwdStr   @"web-api/api/v4/modify_login_pwd"

//修改资金密码
#define ModifyPayPwdStr     @"web-api/api/v4/modify_pay_pwd"

@interface MCPasswordAPIModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    Type_APIPwd _type;
}

@end

@implementation MCPasswordAPIModel
- (instancetype)initWithType:(Type_APIPwd )type{
    
    if (self = [super init]) {
        _type = type;
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
    
    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    if (_type==ModifyLoginPwd){
        return ModifyLoginPwdStr;
    }
    return ModifyPayPwdStr;
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    MCHasPayPwdModel * hasPayPwdModel=[MCHasPayPwdModel sharedMCHasPayPwdModel];
    BOOL hasPassword = [hasPayPwdModel.PayOutPassWord intValue]==1?YES:NO;
    NSDictionary *dic;
    if (_type==ModifyLoginPwd){
        dic= @{
               @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
               @"LogPassword":_LogPassword==nil?@"":_LogPassword,
               @"NewPassword":_NewPassword==nil?@"":_NewPassword,
               @"Type":@(1)
               };

    }else{
        
        if (hasPassword) {
            dic= @{
                   @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
                   @"LogPassword":_LogPassword==nil?@"":_LogPassword,
                   @"NewPassword":_NewPassword==nil?@"":_NewPassword,
                   @"Type":@(1)
                   };
        }else{
            dic= @{
                   @"UserID":[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"],
                   @"NewPassword":_NewPassword==nil?@"":_NewPassword,
                   @"Type":@(1)
                   };
        }
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    if (_type==ModifyLoginPwd){
        NSLog(@"er=-%@---%@",ModifyLoginPwdStr,[NSString stringWithFormat:@"%@",errorCode]);
        
    }else{
        NSLog(@"er=-%@---%@",ModifyPayPwdStr,[NSString stringWithFormat:@"%@",errorCode]);
        
    }
    [BKIndicationView dismiss];
    if (manager.responseMessage) {
        [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
    }
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
    
}


@end








































