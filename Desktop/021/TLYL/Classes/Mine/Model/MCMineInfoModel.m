
//
//  MCLotteryHallModel.m
//  TLYL
//
//  Created by miaocai on 2017/7/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineInfoModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCMineInfoModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end

@implementation MCMineInfoModel

singleton_m(MCMineInfoModel)




- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
-(BOOL)isShowHud{
    return NO;
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
    
    return @"web-api/api/v4/get_user_detail";
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    NSString *timeString = [NSString getCurrentTimestamp];
    NSString *UserID=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        UserID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    NSDictionary *dic =@{@"UserID":UserID};
    NSString *jsonStr = [dic convertToJsonData];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",jsonStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],timeString];
    return @{@"params":jsonStr,
             @"sign":[sign MD5],
             @"timestamp":timeString
             };
}

- (void)managerCallAPIDidSuccessWithManager:(ApiBaseManager *)manager{
    [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"ChildCount"] forKey:@"ChildCount"];
    [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"TeamMemberCount"] forKey:@"TeamMemberCount"];
    [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"UserRealName"] forKey:@"UserNameMMC"];
     [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"MyRebate"] forKey:@"MyRebate"];
    [[NSUserDefaults standardUserDefaults] setObject:manager.ResponseRawData[@"UserLevel"] forKey:@"UserLevel"];
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
