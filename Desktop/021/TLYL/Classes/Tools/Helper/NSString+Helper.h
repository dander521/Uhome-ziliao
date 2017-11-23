//
//  NSString+Helper.h
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MCArryModel :NSObject
@property (nonatomic,strong)NSArray *arr_Wrong;
@property (nonatomic,strong)NSArray *arr_Repart;
@property (nonatomic,strong)NSArray *arr_Result;
@property (nonatomic,assign)BOOL Do_Wrong;
@property (nonatomic,assign)BOOL Do_Repart;
@end
@interface NSString (Helper)
//所有去重复处理
- (MCArryModel *)MC_delRepartLottoryNumberInStringmodel:(MCBasePWFModel *)model;
//所有玩法去错处理
- (MCArryModel *)MC_delWrongLottoryNumberWithWF:(MCBasePWFModel *)model andShow:(BOOL)isShow;
- (BOOL)isValidateMobile;
- (BOOL)isEmailAddress;

+ (NSMutableArray *)splitStringByDiffrentSplitMarkInString:(NSString *)str andModel:(MCBasePWFModel *)model;
+ (BOOL) isEmpty:(NSString *) str ;
/*
 * 将输入框校验成标准的字符
 */
+(NSString *)GetFormatStr:(NSString*)str WithModel:(MCBasePWFModel *)model;
/*
 * 字符串   每隔3位加一个逗号
 */
+(NSString *)MCcountNumChangeformat:(NSString *)num;
/**
 *   获取字符宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat )font;

- (NSString *)MD5;
+(NSString*)getCurrentTimestamp;
+ (BOOL)judgePassWordLegal:(NSString *)pass;
@end
