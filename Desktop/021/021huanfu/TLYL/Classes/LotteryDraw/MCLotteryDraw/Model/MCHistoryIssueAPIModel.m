//
//  MCHistoryIssueAPIModel.m
//  TLYL
//
//  Created by MC on 2017/7/31.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHistoryIssueAPIModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"
#import "MCUserDefinedLotteryCategoriesModel.h"


#define History_Issue  @"web-api/api/v4/get_history_issue"


@interface MCHistoryIssueAPIModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>



@end

@implementation MCHistoryIssueAPIModel


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
    
    return History_Issue;
    
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    //IsSelf	是	Boolean	固定传 false
    //reType	是	Int	固定传1
    //CZID	是	String	彩种ID组成的字符串（如：”12,58,66,75,74,56”）
    NSArray * arr=[MCDataTool MC_GetMarr_withID:MCHomePageLotteryCategoryData];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (MCUserDefinedLotteryCategoriesModel * model in arr) {
        [marr addObject: model.LotteryID];
    }
    NSString * CZID = [marr componentsJoinedByString:@","];
    
    NSDictionary *dic= @{
                         @"IsSelf":@false,
                         @"reType":@1,
                         @"CZID":CZID,
                         @"Size":@20,
                         @"Page":@(_page)
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
    NSLog(@"er=-get_history_issue(获取各彩种开奖公告)---%@",[NSString stringWithFormat:@"%@",errorCode]);
}


@end








































