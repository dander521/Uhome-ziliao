//
//  MCGetMyAndSubSignBounsContractModel.h
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取我的和下级的已签约分红数据
@interface MCGetMyAndSubSignBounsContractModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCGetMyAndSubSignBounsContractDataModel : NSObject

@property(nonatomic,strong) NSArray * MyContract;//数据列表（我的分红契约数据）
@property(nonatomic,strong) NSArray * DownContract;//数据列表（下级分红契约数据）


@end

@interface MCGetMyAndSubSignBounsContractDetailDataModel : NSObject

@property(nonatomic,strong) NSString * BetMoneyMin;//消费额
@property(nonatomic,strong) NSString * LossMoneyMin;//亏损额
@property(nonatomic,strong) NSString * ActivePersonNum;//活跃人数
@property(nonatomic,strong) NSString * DividendRatio;//分红比例（前端需要乘以100，按 % 显示）
@property(nonatomic,strong) NSString * Percent_DividendRatio;//分红比例% 

@end


































