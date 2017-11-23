//
//  MCGroupPaymentModel.m
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGroupPaymentModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

@implementation MCPaymentModel

@end

@interface MCGroupPaymentModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>

@end

@implementation MCGroupPaymentModel
singleton_m(MCGroupPaymentModel)


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
    
    return @"web-api/api/v4/get_group_payment";
    
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
    
//    [BKIndicationView dismiss];
    if (self.callBackSuccessBlock) {
        self.callBackSuccessBlock(manager);
    }

}

- (void)managerCallAPIDidFailedWithManager:(ApiBaseManager *)manager errorCode:(NSString *)errorCode{
//    [BKIndicationView dismiss];
    if (self.callBackFailedBlock) {
        self.callBackFailedBlock(manager,errorCode);
    }
    NSLog(@"er=----%@",errorCode);
}

-(void)setPayMentArrWithData:(NSDictionary *)dic{
    
    NSDictionary * dic_Recharge=[MCDataTool MC_GetDic_Recharge];
    
    self.allRecType=dic[@"allRecType"];
    self.payInType=dic[@"payInType"];
    self.payMentArr=[[NSMutableArray alloc]init];
    [self.payMentArr removeAllObjects];
    NSArray * arr = dic[@"payInType"];
    if (!arr||![arr isKindOfClass:[NSArray class]]) {
        return;
    }
    if ([arr count]<1) {
        return;
    }
    for (NSDictionary * temp in dic[@"payInType"]) {
        for (NSDictionary * item in dic[@"allRecType"]) {
            NSString * str_Pay=[NSString stringWithFormat:@"%@",item[@"Pay"]];
            NSString * str_id=[NSString stringWithFormat:@"%@",temp[@"id"]];
            if ([str_Pay isEqualToString:str_id]) {
                
                if ([dic_Recharge[temp[@"id"]][@"IsMobile"] intValue] ==1) {
                    
                    MCPaymentModel * model=[[MCPaymentModel alloc]init];
                    model.PayName=item[@"PayName"];//String	充值方式名称
                    model.SortNum=item[@"SortNum"];//String	充值方式排序
                    
                    
                    
                    model.RechargeType=dic_Recharge[temp[@"id"]][@"typeID"];//String	充值方式编码
                    
                    
                    model.minRecMoney=temp[@"minRecMoney"];//String	此充值方式最低充值额
                    model.maxRecMoney=temp[@"maxRecMoney"];//String	此充值方式最高充值额
                    
                    //    43 52 53 68 71 79 85 86 91 97
                    if ([model.RechargeType intValue]==43||[model.RechargeType intValue]==52||[model.RechargeType intValue]==53||[model.RechargeType intValue]==68||[model.RechargeType intValue]==71||[model.RechargeType intValue]==91||[model.RechargeType intValue]==79||[model.RechargeType intValue]==97||[model.RechargeType intValue]==85||[model.RechargeType intValue]==86) {
                        model.arr_FastPayment=dic_Recharge[temp[@"id"]][@"name"];
                        //快捷
                        model.logoType=@"5";
                        
                    }else{
                        model.BankCode=dic_Recharge[temp[@"id"]][@"name"];

                        NSString * BankCode=dic_Recharge[temp[@"id"]][@"name"];
                        if ([BankCode isEqualToString:@"alipay"]) {
                            
                            model.logoType=@"1";
                            
                        }else if ([BankCode isEqualToString:@"WECHAT"]||[BankCode isEqualToString:@"wechat"]){
                            
                            model.logoType=@"2";
                            
                        }else if ([BankCode isEqualToString:@"qqpay"]){
                            
                            model.logoType=@"3";
                            
                        }else{
                            model.logoType=@"4";
                        }
                    }
                    
                    
                    
                    [self.payMentArr addObject:model];
                    
                }
            }
        }
    }
}

@end























