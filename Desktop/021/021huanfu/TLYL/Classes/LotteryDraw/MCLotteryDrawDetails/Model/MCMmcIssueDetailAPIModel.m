//
//  MCMmcIssueDetailAPIModel.m
//  TLYL
//
//  Created by MC on 2017/8/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMmcIssueDetailAPIModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

#define History_Issue  @"web-api/api/v4/get_mmc_issue"


@interface MCMmcIssueDetailAPIModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>



@end

@implementation MCMmcIssueDetailAPIModel
singleton_m(MCMmcIssueDetailAPIModel)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};
-(BOOL)isShowHud{
    return YES;
}
- (BOOL)isShowError{
    return YES;
}
- (BOOL)isShowNoNet{
    return YES;
}
- (BOOL)isShowNodata{
    return YES;
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
    
    return History_Issue;
    
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
//    LotteryCode	是	String	彩种编码
//    CurrentPageSize	是	String	当前页大小
//    CurrentPageIndex	是	Int	当前页下标
    
    NSDictionary *dic= @{
                         @"CurrentPageSize":@"20",
                         @"LotteryCode":_LotteryCode,
                         @"CurrentPageIndex":@(_Page)
                         };
    
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
    NSLog(@"er=-get_history_issue(获取某彩种历史开奖号)---%@",[NSString stringWithFormat:@"%@",errorCode]);
}


@end








































