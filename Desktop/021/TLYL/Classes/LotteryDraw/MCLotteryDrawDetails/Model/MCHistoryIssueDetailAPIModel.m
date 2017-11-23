//
//  MCHistoryIssueDetailAPIModel.m
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHistoryIssueDetailAPIModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

#define History_Issue  @"web-api/api/v4/get_history_issue"


@interface MCHistoryIssueDetailAPIModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>



@end

@implementation MCHistoryIssueDetailAPIModel
singleton_m(MCHistoryIssueDetailAPIModel)

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
//    IsSelf	是	Boolean	固定值：false
//    reType	是	Int	请求类型，传4有分页，传1请求固定条数但无分页
//    CZID	是	Int	彩种 ID
//    Size	是	Int	有分页：每页请求条数 / 无分页：单次请求条数
//    Page	是	Int	分页（从1开始为第一页，后边页码依次加1）
    
    NSDictionary *dic= @{
                         @"IsSelf":@false,
                         @"reType":@4,
                         @"CZID":_LotteryCode,
                         @"Size":@20,
                         @"Page":@(_Page)
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








































