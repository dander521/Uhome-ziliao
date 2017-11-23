//
//  MCRechargeModel.m
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

/*
 * 添加充值信息
 */
#import "MCRechargeModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
/*
 * 开户行的显示规则是这样的：在 add_recharge_info 这个接口中，会返回 PayBank 这个字段，这个字段可能有3种情况，一种为空（针对在线充值类），一种只包含“收款银行”，一种同时包含了“收款银行”和“开户银行”。
 举例如下： PayBank:"工商银行,安徽阜阳"，逗号前为收款银行，逗号后为开户银行。
 程序中逻辑为：①判断是否有逗号，有则用逗号分隔，无则直接赋值为“收款银行”；②有逗号，则分隔后取下标为0的作为“收款银行”；③下标为1的判断是否有值，有则显示到“开户银行”，无则不显示。（因为有的时候会返回“工商银行, ”这样的字段）
 */
@interface MCRechargeModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    
    NSDictionary * _dic;
}
@end

@implementation MCRechargeModel

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
    
    return @"web-api/api/v4/add_recharge_info";
    
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
    NSLog(@"er=----%@",errorCode);
}



@end























