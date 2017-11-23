//
//  MCModifyUserInfoModel.m
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyUserInfoModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCModifyUserInfoModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCModifyUserInfoModel
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

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
    
    return @"web-api/api/v4/modify_user_info";
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSString *UserID=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        UserID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    
    
//    if (!_EMail||_EMail==nil) {
//       _EMail=@"";
//    }
//    if (!_QQ||_QQ==nil) {
//        _QQ=@"";
//    }
//    if (!_MobilePhone||_MobilePhone==nil) {
//        _MobilePhone=@"";
//    }
//    if (!_Province||_Province==nil) {
//        _Province=@"";
//    }
//    if (!_City||_City==nil) {
//        _City=@"";
//    }
   
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setObject:UserID forKey:@"UserID"];
    if (_EMail.length>0) {
        [dic setObject:_EMail forKey:@"EMail"];
    }
    if (_MobilePhone.length>0) {
        [dic setObject:_MobilePhone forKey:@"MobilePhone"];
    }
    [dic setObject:@"3" forKey:@"MerchantType"];
    
//    NSDictionary *dic =@{
//                         @"UserID":UserID,
//                         @"EMail":_EMail,
//                         @"QQ":_QQ,
//                         @"MobilePhone":_MobilePhone,
//                         @"Province":_Province,
//                         @"City":_City,
//                         @"MerchantType":@3
//                         
//                         };

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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
    NSLog(@"er=-modify_user_info---%@",errorCode);
}


@end
