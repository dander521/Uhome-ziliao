//
//  MCGetplayawardModel.m
//  TLYL
//
//  Created by miaocai on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//  玩法奖金

#import "MCGetplayawardModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@implementation AwardAmountModel
@end

@interface MCGetplayawardModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>


@end


@implementation MCGetplayawardModel

+ (NSDictionary *)objectClassInArray
{
    
    return @{@"AwardAmount" : [AwardAmountModel class]
             };
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (id)valueForUndefinedKey:(NSString *)key{
    return @"";
}
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
    
    return @"web-api/api/v4/get_play_award";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{@"LotteryCode":@(self.lotteryNumber)};
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
        self.callBackFailedBlock(manager.ResponseRawData, errorCode);
    }

}

@end
