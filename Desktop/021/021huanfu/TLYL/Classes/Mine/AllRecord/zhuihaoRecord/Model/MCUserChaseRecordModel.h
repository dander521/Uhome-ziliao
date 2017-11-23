//
//  MCUserChaseRecordModel.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 查询个人追号记录
 */
@interface MCUserChaseRecordModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface MCUserChaseRecordDataModel : NSObject

//PageCount	Int	总页数
//DataCount	Int	总条数
//OrderSumMoney	Number（包含 Int 和 Float）	订单总金额
//WinningSumMoney	Number	中奖总金额
//BtnInfo	Array	数据列表
//
//OrderID	String
//BetTb	Int	彩种 ID
//CountQS	Int	总期数
//CountSY	Int	剩余期数 见备注1
//SumBetMoney	Number	投注金额
//OrderState	Int	中奖状态
//SumAwardMoney	Number	中奖金额
//InsertTime	String	交易时间


@property (nonatomic,strong)NSString * BetInfo_ID;// = 0;
@property (nonatomic,strong)NSString * BetTb;//  = 10;
@property (nonatomic,strong)NSString * CountQS;//  = 10;
@property (nonatomic,strong)NSString * CountSY;//  = 10;
@property (nonatomic,strong)NSString * InsertTime;//  = "2017-10-18 08:51:26";
@property (nonatomic,strong)NSString * OrderID;// 订单号 BGIeO8lQHNOWL5e;
@property (nonatomic,strong)NSString * OrderState;//  = 0;
@property (nonatomic,strong)NSString * SumAwardMoney;//  = 0;
@property (nonatomic,strong)NSString * SumBetMoney;//  = 20;
@property (nonatomic,strong)NSString * UserName;//  = canny;
@property (nonatomic,strong)NSString * User_ID;// = 17225;


@end
