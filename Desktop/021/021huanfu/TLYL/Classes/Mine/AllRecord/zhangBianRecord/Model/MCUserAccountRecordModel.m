//
//  MCUserAccountRecordModel.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserAccountRecordModel.h"
#import "NSDictionary+helper.h"
#import "NSString+Helper.h"
#import "MCDataTool.h"

@implementation MCUserARecordModel
@end

@interface MCUserAccountRecordModel ()<ApiManagerCallBackProtocol,ApiManagerProvider,ApiManagerProtocol>
{
    
    NSDictionary * _dic;
}
@end

@implementation MCUserAccountRecordModel

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
    
    return @"web-api/api/v4/user_account_record";
    
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


@implementation MCUserAccountRecordDataModel
+(NSDictionary *)objectClassInArray
{
    return @{
             @"UfInfo" : [MCUserAccountRecordDetailDataModel class]
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};


@end


@implementation MCUserAccountRecordDetailDataModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

/**
 * 备注详情
 * DetailsSource
 *
 */
+(NSString *)getMarksDetail:(MCUserAccountRecordDetailDataModel *)model{
    NSString *Marks = model.Marks;
    int DetailsSource = [model.DetailsSource intValue];
    NSDictionary * Dic_CZHelper = [MCDataTool MC_GetDic_CZHelper];
    if(DetailsSource==1){
        NSString * czName = Dic_CZHelper[Marks][@"name"];
        return [NSString stringWithFormat:@"购买%@",czName];//此时 Marks 为彩种ID，可依此转换为彩种名称
    }else if(DetailsSource==10){
        return @"用户撤单";
    }else if(DetailsSource==11){
        return @"管理员撤单";
    }else if(DetailsSource==12){
        return @"追号中奖撤单";
    }else if(DetailsSource==13){
        return @"系统撤单";
    }else if(DetailsSource==20){
        NSString * czName = Dic_CZHelper[Marks][@"name"];
        return [NSString stringWithFormat:@"%@出票",czName]; //此时 Marks 为彩种ID，可依此转换为彩种名称
    }else if(DetailsSource==30){
        return @"自身投注返点";
    }else if(DetailsSource==40){
        return [NSString stringWithFormat:@"%@向上级返点",Marks];
    }else if(DetailsSource==50){
        return @"系统派奖";
    }else if(DetailsSource==60){
        return @"管理员撤奖";
    }else if(DetailsSource==70){
        return @"申请提款，扣除余额";
    }else if(DetailsSource==90){
        return @"提款拒绝，返还账户";
    }else if(DetailsSource==100){
        return @"用户提款";
    }else if(DetailsSource==110){
        return @"用户提款";
    }else if(DetailsSource==120){
        return @"用户提款";
    }else if(DetailsSource==140){
        return @"申请充值";
    }else if(DetailsSource==150 || DetailsSource==8  || DetailsSource==14 || DetailsSource==15){
        return @"用户充值";
    }else if(DetailsSource==170){
        return @"钱包中心转入彩票";
    }else if(DetailsSource==180){
        return @"彩票转入钱包中心";
    }else if(DetailsSource==190){
        return [NSString stringWithFormat:@"给%@",Marks];
    }else if(DetailsSource==200){
        if ([Marks containsString:@"]"]) {
            NSArray * arr=[Marks componentsSeparatedByString:@"]"];
            return [NSString stringWithFormat:@"来自上级的%@",arr[1]];
        }else{
            return [NSString stringWithFormat:@"来自上级%@",Marks];
            
        }
        
        //        if(Marks.indexOf(']') != -1){  //判断 Marks 中是否含有']' 这个字符
        //            return "来自上级的" + Marks.split("]")[1];  //如果有']'，则按']'切分为数组，获取下标为1的值.
        //        }else{
        //            return "来自上级" + Marks;  //如果没有']'，则直接返回 <‘来自上级’ + Marks> 拼接起来的字符串.
        //        }
    }else if(DetailsSource==210){
        return @"系统分红";
    }else if(DetailsSource==220){
        return @"开户送礼";
    }else if(DetailsSource==230){
        return @"充值送礼";
    }else if(DetailsSource==231){
        return [NSString stringWithFormat:@"%@的充值佣金",Marks];
        
    }else if(DetailsSource==240){
        return @"投注送礼";
    }else if(DetailsSource==241){
        return [NSString stringWithFormat:@"%@的投注佣金",Marks];
        
    }else if(DetailsSource==251){
        return @"满就送";
    }else if(DetailsSource==252){
        return @"亏损补贴";
    }else if(DetailsSource==253){
        return [NSString stringWithFormat:@"%@的亏损佣金",Marks];
        
    }else if(DetailsSource==254){
        return [NSString stringWithFormat:@"%@的满就送佣金",Marks];
        
    }else if(DetailsSource==255){
        return @"消费拿红包";
    }else if(DetailsSource==256){
        return @"土豪签到";
    }else if(DetailsSource==257){
        return @"转盘活动";
    }else if(DetailsSource==261){  //按比例发放日工资
        return Marks;
    }else if(DetailsSource==262){  //按阶梯发放日工资
        return Marks;
    }else if(DetailsSource==263){  //来自上级的日工资
        return Marks;
    }else if(DetailsSource==264){  //发给下级的日工资
        return Marks;
    }else if(DetailsSource==265){  //人工添加日工资
        return Marks;
    }else if(DetailsSource==266){  //人工扣除日工资
        return Marks;
    }else if(DetailsSource==267){  //来自系统的分红
        return @"来自系统的分红";
    }else if(DetailsSource==268){  //来自上级的分红
        return @"来自上级的分红";
    }else if(DetailsSource==290){  //从彩票向棋牌转账
        return Marks;
    }else if(DetailsSource==300){  //从棋牌向彩票转账
        return Marks;
    }else if(DetailsSource==301){  //消费日工资
        return @"消费日工资";
    }else if(DetailsSource==302){  //亏损日工资
        return @"亏损日工资";
    }else{
        return Marks;
    }
}

@end











