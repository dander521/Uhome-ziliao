//
//  NSObject+MCLotteryIDHelper.h
//  TLYL
//
//  Created by miaocai on 2017/6/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCLotteryID: NSObject
    
+ (NSDictionary *)getLotteryWFJsonDataInstance;
/**根据彩票id找彩票自定义名称*/
+ (NSString *)getLotteryCategoriesNameByID:(NSString *)categoriesID;
/**根据彩票id找到彩票的名称玩法*/
//+ (NSString *)getLotteryFullNameByID:(NSString *)FullID BetMode:(int)BetMode;
+ (NSString *)getLotteryFullNameByPlayCode:(NSString *)PlayCode andLotteryCode:(NSString *)LotteryCode  andBetMode:(int)BetMode;

/**根据彩票名称玩法找到彩票id*/
//+ (NSString *)getLotteryFullIDByName:(NSString *)FullName;
/**根据彩票id找彩票type*/
+ (NSString *)getLotteryCategoriesTypeNameByID:(NSString *)categoriesID;
/**根据彩票id 和分组找彩票的玩法数据*/
+ (NSMutableDictionary *)getWFIDByLotteryCategoriesID:(NSString *)categoriesID groupName:(NSString *)groupName;

+ (NSString *)getLotteryFullNameByID:(NSString *)FullID;
@end

