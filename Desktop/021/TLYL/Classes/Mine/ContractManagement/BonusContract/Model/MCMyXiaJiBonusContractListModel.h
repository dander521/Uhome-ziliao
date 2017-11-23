//
//  MCMyXiaJiBonusContractListModel.h
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取下级的分红契约列表
@interface MCMyXiaJiBonusContractListModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCMyXiaJiBonusContractListDataModel : NSObject

@property (nonatomic,strong)NSArray * ContractManagerModels;//数据列表
@property (nonatomic,strong)NSString *DataCount;//数据总条数
@property (nonatomic,strong)NSString *PageCount;//总页码数
@property (nonatomic,strong)NSString *LockState;//是否显示“一键结算”（1：显示，0：不显示）
@property (nonatomic,strong)NSString *State;//0：当前用户有新契约；1：当前用户没有新契约
@property (nonatomic,strong)NSString *UpdateDateTime;

@end


@interface MCMyXiaJiBonusContractListDeatailDataModel : NSObject

@property (nonatomic,strong)NSString *UserID;//Int    下级用户ID
@property (nonatomic,strong)NSString *UserName;//String    下级用户名
@property (nonatomic,strong)NSString *Rebate;//Int    下级返点
@property (nonatomic,strong)NSString *State;//Int    判断是否有“分红结算” 见备注1
@property (nonatomic,strong)NSString *DayWagesProportion;//分红比例

//@property (nonatomic,strong)NSString *LockState;


@end












