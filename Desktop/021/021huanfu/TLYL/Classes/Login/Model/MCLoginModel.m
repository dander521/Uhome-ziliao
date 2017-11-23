//
//  MCLoginModel.m
//  TLYL
//
//  Created by miaocai on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLoginModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCLoginModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>{
    //_userNamet 用户名
    NSString *_userNamet;
    //_passWord 密码
    NSString *_passWord;
}
//userId 用户id
@property (nonatomic,strong) NSString *userId;
//userName 用户名
@property (nonatomic,strong) NSString *userName;

@end

@implementation MCLoginModel
-(BOOL)isShowHud{
    return YES;
}
- (instancetype)initWithUserName:(NSString *)userName passWord:(NSString *)passWord{

    if (self = [super init]) {
        _userNamet = userName;
        _passWord = passWord;
    }
    return self;
    
}

- (enum ManagerRequestMethod)requestMethod{
    
    return ManagerRequestMethodRequestMethodRestPOST;
}

- (enum APIResponseDataType)responseDataType{
    
    return APIResponseDataTypeJson;
}
- (void)refreashDataAndShow{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *cookie_id=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"cookie_id"]) {
        cookie_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie_id"];
    }
    [cookieProperties setObject:cookie_id forKey:@"cookie_id"];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    ApiBaseManager *baseManager = [[ApiBaseManager alloc] initWithUrlProvider:self];
    baseManager.apiCallBackDelegate = self;
    baseManager.requestCustomizeDelegate = self;
    [baseManager loadData];
    
}

- (NSDictionary<NSString *,NSString *> *)headerForManagerWithManager:(ApiBaseManager *)manager{

    return @{@"Token":@"",@"platformCode":@"2",@"userId":@""};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/login";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic = nil;
    if (self.authCode == nil&&self.authCode == nil) {
        dic =@{@"UserLoginName":_userNamet,@"UserPassWord":_passWord};
    }
    if (self.authCode != nil && self.GACode == nil) {
        dic =@{@"UserLoginName":_userNamet,@"UserPassWord":_passWord,@"SecCode":self.authCode};
    }
     if (self.authCode != nil && self.GACode != nil) {
        dic =@{@"UserLoginName":_userNamet,@"UserPassWord":_passWord,@"SecCode":self.authCode,@"GACode":self.GACode,@"GAKey":self.GAKey};
    }
     if (self.authCode == nil && self.GACode != nil) {
        dic =@{@"UserLoginName":_userNamet,@"UserPassWord":_passWord,@"GACode":self.GACode,@"GAKey":self.GAKey};
    }
    [[NSUserDefaults standardUserDefaults] setObject:_userNamet forKey:@"UserName"];
    NSString *jsonStr = [dic convertToJsonData];
     NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,@"",timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    if (manager.ResponseHeader[@"Token"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseHeader[@"Token"] forKey:@"Token"];
    }
    if (manager.ResponseHeader[@"token"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseHeader[@"token"] forKey:@"Token"];
    }
    if (manager.ResponseRawData[@"userId"]) {
        [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"userId"] forKey:@"userId"];
    }
    
    [BKIndicationView dismiss];
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager.ResponseRawData);
    }
    

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }
//    NSLog(@"er=--web-api/api/v4/login--%@",errorCode);
}


@end
