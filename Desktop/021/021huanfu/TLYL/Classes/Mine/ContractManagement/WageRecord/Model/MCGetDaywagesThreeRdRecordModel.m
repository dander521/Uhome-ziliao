//
//  MCGetDaywagesThreeRdRecordModel.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetDaywagesThreeRdRecordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"

@interface MCGetDaywagesThreeRdRecordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    
    NSDictionary * _dic;
}
@end

@implementation MCGetDaywagesThreeRdRecordModel

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
    
    return @{@"Token":[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"],@"platformCode":@"2"};
}

- (NSString *)urlPathComponentForManagerWithManager:(ApiBaseManager *)manager{
    
    return @"web-api/api/v4/get_daywages_3rd_record";
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    
    NSDictionary *dic =_dic;
    
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
    NSLog(@"er=--web-api/api/v4/get_daywages_3rd_record--%@",errorCode);
}



@end


@implementation MCGetDaywagesThreeRdRecordDataModel
+(NSDictionary *)objectClassInArray
{
    return @{
             @"GetWayWagesList" : [MCGetDaywagesThreeRdRecordDetailDataModel class]
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};


@end


@implementation MCGetDaywagesThreeRdRecordDetailDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

+(NSString *)GetFaFangType:(NSString *)DetailSource{
    NSString * type = @"";
    NSInteger t = [DetailSource integerValue];
    switch (t) {
        case -1:
            type = @"全部";
            break;
        case 301:
            type = @"系统发放";
            break;
        case 263:
            type = @"来自上级的日工资";
            break;
        case 264:
            type = @"发给下级的日工资";
            break;
        case 265:
            type = @"人工添加日工资";
            break;
        case 266:
            type = @"人工扣除日工资";
            break;
        default:
            break;
    }
    
    return type;
}



//发放类型（DetailSource）说明：
//-1:全部，
//301:系统发放，
//263:来自上级的日工资，
//264:发给下级的日工资，
//265:人工添加日工资，
//266:人工扣除日工资.


@end

@implementation MCDayagesRecordProperty

singleton_m(MCDayagesRecordProperty)

@end








