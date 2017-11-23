//
//  MCBetModel.m
//  TLYL
//
//  Created by MC on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBetModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCMaxbonusModel.h"

@interface MCBetModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    NSDictionary * _dic;

}

@end

@implementation MCBetModel
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

    return @"web-api/api/v4/lottery_bet";
}

- (NSDictionary<NSString *,id> *)parametersForManagerWithManager:(ApiBaseManager *)manager{
    
    NSString *timeString = [NSString getCurrentTimestamp];
    NSDictionary *dic = nil;
    dic = _dic;

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
    
//    if (_firstResbanderZhuiHaoView == NO) {
//        
//        NSLog(@"er=-投注接口---%@",[NSString stringWithFormat:@"%@",errorCode]);
//
//    }else{
//        NSLog(@"er=-追号接口---%@",[NSString stringWithFormat:@"%@",errorCode]);
//
//    }
}


@end











/*
"params":{
    "LotteryCode":12,
    "Bet":[
           {
               "BetContent":"2|0|7",
               "BetCount":"1",
               "PlayCode":"1203",
               "IssueNumber":"20170719064",
               "BetRebate":"1956",
               "BetMoney":"2",
               "BetMultiple":"1",
               "BetMode":0
           }
           ]
}
 LotteryCode	是	Int	彩种编码
 Bet	是	Array	投注实体，一个Object代表一单
 BetContent	是	String	投注内容
 BetCount	是	String	投注注数
 PlayCode	是	String	玩法编码
 IssueNumber	是	String	投注期号
 BetRebate	是	String	投注返点
 BetMoney	是	String	投注金额
 BetMultiple	是	String	投注倍数
 BetMode	是	Int	投注模式
*/






























