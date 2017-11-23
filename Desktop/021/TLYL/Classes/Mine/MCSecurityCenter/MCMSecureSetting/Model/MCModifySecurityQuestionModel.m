//
//  MCModifySecurityQuestionModel.m
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifySecurityQuestionModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"


//修改已设置的密保问题
#define ModifySecurityQuestionStr  @"web-api/api/v4/modify_security_question"


@interface MCModifySecurityQuestionModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    
    NSDictionary * _dic;
}


@end

@implementation MCModifySecurityQuestionModel
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
    
    return ModifySecurityQuestionStr;
    
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
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
    NSLog(@"er=-%@---%@",ModifySecurityQuestionStr,[NSString stringWithFormat:@"%@",errorCode]);
}


@end








































