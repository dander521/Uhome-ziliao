//
//  NSObject+MCLotteryIDHelper.m
//  TLYL
//
//  Created by miaocai on 2017/6/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryID.h"
#import "MCDataTool.h"

static NSDictionary *_instanceCZ;
static NSDictionary *_instanceWF;
static NSDictionary *_instanceCZHelper;

@implementation MCLotteryID : NSObject


    /*
     *从jsondata中获取CZ对象
     */
+ (NSDictionary *)getLotteryCZJsonDataInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LotteryJSON_CZ" ofType:@"json"];
        NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
        _instanceCZ = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:nil];

    });
    return _instanceCZ;
}
//1.增加401/407跳转登陆页面
//2.
//+ (NSString *)getLotteryFullIDByName:(NSString *)FullName{
//    
//}
    /*
     *从jsondata中获取WF对象
     */
+ (NSDictionary *)getLotteryWFJsonDataInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LotteryJSON_WF" ofType:@"json"];
        NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
        _instanceWF = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:nil];
        
    });
    return _instanceWF;
}
    
+ (NSDictionary *)getLotteryWFHelperJsonDataInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LotteryJSON_WFHelper" ofType:@"json"];
        NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
        _instanceWF = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:nil];
        
    });
    return _instanceWF;
}

    /*
     *从jsondata中获取CZHelper对象
     */
+ (NSDictionary *)getLotteryCZHelperJsonDataInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LotteryJSON_CZHelper" ofType:@"json"];
        NSData *dataJson = [NSData dataWithContentsOfFile:filePath];
        _instanceCZHelper = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:nil];
        
    });
    return _instanceCZHelper;
}
    
+ (NSString *)getLotteryFullNameByID:(NSString *)FullID {
    NSString *lcID = @"";

    if (FullID.length == 3) {
        lcID = [FullID substringToIndex:1];

    } else {
        lcID = [FullID substringToIndex:2];

    }
    return  [self getLotteryCategoriesTypeNameByID:lcID];
}
    /*
     *根据彩票id找彩票type
     */
+ (NSString *)getLotteryCategoriesTypeNameByID:(NSString *)categoriesID{
    
    NSDictionary *dic = [self getLotteryCZHelperJsonDataInstance];
    
    return dic[categoriesID][@"type"];
}
    
    /*
     *根据彩票id找彩票种类名称
     */
+ (NSString *)getLotteryCategoriesNameByID:(NSString *)categoriesID{
    
   NSDictionary *dic = [self getLotteryCZHelperJsonDataInstance];
    
    return dic[categoriesID][@"name"];
}
    
    /*
     *根据彩票id找彩票玩法名称
     */
+ (NSString *)getLotteryWFNameByID:(NSString *)categoriesID{
    
    NSDictionary *dic = [self getLotteryWFJsonDataInstance];
    
    return dic[categoriesID][@"name"];
}
    /*
     *根据彩票type找彩票玩法列表
     */
+ (NSDictionary *)getLotteryWFType:(NSString *)categoriesType{
    
    NSDictionary *dic = [self getLotteryWFHelperJsonDataInstance];
    
    return dic[categoriesType];
}
    /*
     *根据彩票id找到彩票的名称玩法
     */
+ (NSString *)getLotteryFullNameByPlayCode:(NSString *)PlayCode andLotteryCode:(NSString *)LotteryCode  andBetMode:(int)BetMode {
//    "21": "江苏骰宝",
//    "87": "吉林骰宝",
//    "88": "安徽骰宝",
//    "89": "湖北骰宝",
    if([LotteryCode isEqualToString:@"21"]||[LotteryCode isEqualToString:@"87"]||[LotteryCode isEqualToString:@"88"]||[LotteryCode isEqualToString:@"89"]){
        NSString * TB_WF_code = [PlayCode substringFromIndex:2];
        NSString * WF_name=@"";
        if([TB_WF_code isEqualToString:@"10"]){
            WF_name=@"和值_和值";
        }else if ([TB_WF_code isEqualToString:@"11"]){
            WF_name=@"三同号_单选";
            
        }else if ([TB_WF_code isEqualToString:@"12"]){
            WF_name=@"三同号_通选";
        }else if ([TB_WF_code isEqualToString:@"13"]){
            WF_name=@"二同号_复选";
        }else if ([TB_WF_code isEqualToString:@"14"]){
            WF_name=@"二不同号_二不同号";
        }else if ([TB_WF_code isEqualToString:@"15"]){
            WF_name=@"猜一个号_猜一个号";
        }else if ([TB_WF_code isEqualToString:@"16"]){
            WF_name=@"和值_大小";
        }else if ([TB_WF_code isEqualToString:@"17"]){
            WF_name=@"和值_单双";
        }
        
        return WF_name;
      
    }

    NSDictionary * dicCZHelper=[MCDataTool MC_GetDic_CZHelper];
    NSDictionary * dicCZ=dicCZHelper[LotteryCode];
//    "type": "ssc",
    NSString * type = dicCZ[@"type"];
    
    NSDictionary * dicWFHelper = [MCDataTool MC_GetDic_WFHelper];
    NSDictionary * dicCZ_WF = dicWFHelper[type];
    
    NSDictionary *dicPlayMethod=dicCZ_WF[@"playMethod"];
    NSArray *dicKeyArr = dicPlayMethod.allValues;
    NSMutableArray * marrrry=[[NSMutableArray alloc]init];
    
    for (NSArray * aa in dicKeyArr) {
        for (NSDictionary *tt in aa) {
            [marrrry addObject:tt];
        }

    }
    NSInteger length=LotteryCode.length;
    
//    NSString * methodId =[PlayCode stringByReplacingOccurrencesOfString:LotteryCode withString:@""];
    NSString * methodId = [PlayCode substringFromIndex:length];
    //1515  15
    if (methodId.length<1) {
        methodId=LotteryCode;
    }

    NSMutableArray * marr= [[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in marrrry) {
        if ([dic[@"methodId"] isEqualToString:methodId]) {
            NSDictionary * dd=@{
                                @"typeName":dic[@"typeName"],
                                @"name":dic[@"name"],
                                @"BetMode":dic[@"BetMode"]
                                };
            [marr addObject:dd];
        }
    }
    
    NSString * typeName= marr[0][@"typeName"];
    NSString * name=marr[0][@"name"];
    if (marr.count>1) {
        
        int betMode = [MCLotteryID getBetMode:BetMode];
        for (NSDictionary * dic in marr) {
            if ([dic[@"BetMode"] intValue] == betMode) {
                typeName=dic[@"typeName"];
                name=dic[@"name"];
            }
        }
    }
    return [NSString stringWithFormat:@"%@_%@",typeName,name];;

}


+(int)getBetMode:(int)betMode{
    if((betMode&1)==1)
        return 1;
    else if((betMode&16)==16){
        return 16;
    }else if((betMode&8)==8){
        return 8;
    }else{
        return 0;
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {return nil;}
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}
    
+ (NSMutableDictionary *)getWFIDByLotteryCategoriesID:(NSString *)categoriesID groupName:(NSString *)groupName{
//    if (_dict !=nil) {
//        return _dict;
//    }
    NSString *lcID = @"";
    NSString *wcID = @"";
    if (categoriesID.length == 3) {
        lcID = [categoriesID substringToIndex:1];
        wcID = [categoriesID substringWithRange:NSMakeRange(1, categoriesID.length - 1)];
    } else {
        lcID = [categoriesID substringToIndex:2];
        wcID = [categoriesID substringWithRange:NSMakeRange(2, categoriesID.length - 2)];
    }
    NSString *type = [self getLotteryCategoriesTypeNameByID:lcID];

    NSMutableDictionary *dic = [self getPlayMethodByType:type groupName:groupName categoriesID:wcID];

    return dic;
}


+ (NSMutableDictionary *)getPlayMethodByType:(NSString *)type groupName:(NSString *)groupName categoriesID:(NSString *)categoriesID{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDictionary *dic = [self getLotteryWFHelperJsonDataInstance];
    NSDictionary *lotteryDic = dic[type];
    NSDictionary *dicM = lotteryDic[@"playMethod"];
    
    NSArray *arr = dicM[groupName];
    for (NSDictionary *dic in arr) {
        if ([dic[@"methodId"] isEqualToString:categoriesID]) {
            [dict setDictionary:dic];
        }
    }
    return dict;
}
@end
