//
//  MCUserDefinedAPIModel.m
//  TLYL
//
//  Created by MC on 2017/7/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedAPIModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"
#import "MCUserDefinedLotteryCategoriesModel.h"

#define  LotteryListURL  @"web-api/api/v4/get_lottery_list"
@interface MCUserDefinedAPIModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCUserDefinedAPIModel
singleton_m(MCUserDefinedAPIModel)
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
    
    return LotteryListURL;
    
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic =@{};
    
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

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSDictionary *)errorCode{
    [BKIndicationView dismiss];
    NSLog(@"er=--%@--%@",LotteryListURL,errorCode);
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
}


+(void)saveSaleCZIDArry:(NSMutableArray *)marr{

    [MCDataTool MC_SaveMarr:marr withID:MCSaleCZIDArry];
}

+(NSMutableArray *)getSaleCZIDArry{
    
    NSMutableArray * SaleCZIDArry = [MCDataTool MC_GetMarr_withID:MCSaleCZIDArry];

    
    return SaleCZIDArry;
    
}

+(NSMutableArray *)getGameRecordMarr{
    NSMutableArray * SaleCZIDArry = [MCDataTool MC_GetMarr_withID:MCSaleCZIDArry];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    [marr addObject:@{
                      @"name": @"全部彩种",
                      @"lotteryId": @""
                      }
     ];
    NSDictionary * dic_CZHelper =[MCDataTool MC_GetDic_CZHelper];
    for (MCUserDefinedLotteryCategoriesModel * model in SaleCZIDArry) {
        [marr addObject:@{
                          @"name": dic_CZHelper[model.LotteryID][@"name"],
                          @"lotteryId": model.LotteryID
                          }
         ];
    }
    return marr;
}
@end





/*
{
    "code": 200,
    "message": "成功",
    "data":
    [
     {
         "SaleState": 1,
         "MaxRebate": 1956,
         "LotteryID": 4,
         "BetRebate": 1956
     },
     {
         "SaleState": 1,
         "MaxRebate": 1956,
         "LotteryID": 5,
         "BetRebate": 1956
     }
     ......
     ]
}
 */
