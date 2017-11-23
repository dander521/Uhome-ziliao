//
//  MCMyBonusContractListModel.h
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//查看我的分红契约列表
@interface MCMyBonusContractListModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCMyBonusContractListDataModel : NSObject

@property (nonatomic,strong)NSArray * ContractContentModels;//数据列表
@property (nonatomic,strong)NSString *DataCount;//数据总条数
@property (nonatomic,strong)NSString *PageCount;//总页码数

@end


@interface MCMyBonusContractListDeatailDataModel : NSObject

@property (nonatomic,strong)NSString *ActivePersonNum;//活跃人数
@property (nonatomic,strong)NSString *BetMoneyMax;//最大消费额（前端暂不显示此字段）
@property (nonatomic,strong)NSString *BetMoneyMin;//消费额
@property (nonatomic,strong)NSString *DividendRatio;//分红比例（前端显示需乘以100，并加 %）
@property (nonatomic,strong)NSString *IsHistoryData;//判断是已同意还是未同意列表的数据（0：已同意，1：未同意）
@property (nonatomic,strong)NSString *LossMoneyMax;//最大亏损额（前端暂不显示此字段）
@property (nonatomic,strong)NSString *LossMoneyMin;//亏损额

@end





