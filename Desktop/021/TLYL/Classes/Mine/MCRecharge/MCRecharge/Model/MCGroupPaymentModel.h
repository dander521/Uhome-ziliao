//
//  MCGroupPaymentModel.h
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
@interface MCPaymentModel : NSObject

@property (nonatomic,strong)NSString * PayName	;//String	充值方式名称
@property (nonatomic,strong)NSString * SortNum	;//String	充值方式排序
@property (nonatomic,strong)NSString * minRecMoney	;//String	此充值方式最低充值额
@property (nonatomic,strong)NSString * maxRecMoney	;//String	此充值方式最高充值额
@property(nonatomic, strong)NSString *RechargeType	;//充值方式编码
@property(nonatomic, strong)NSString *BankCode	;//是	String	银行名称
@property(nonatomic, strong)NSString *RechargeMoney	;//是	String	充值金额

/*
 * 用来存放快捷支付选择的
 */
@property(nonatomic, strong)NSArray * arr_FastPayment;

//1-> 支付宝  2->微信 3->QQ 4->银行  5->快捷
@property(nonatomic, strong)NSString * logoType;

@property(nonatomic, assign)BOOL isSelected;
@end


@interface MCGroupPaymentModel : NSObject
singleton_h(MCGroupPaymentModel)
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property (nonatomic,strong)NSArray * allRecType;
@property (nonatomic,strong)NSArray * payInType;

@property (nonatomic,strong) NSString *Pay;
@property (nonatomic,strong) NSString *PayName;
@property (nonatomic,strong) NSString *SortNum;


@property (nonatomic,strong)NSMutableArray <MCPaymentModel *>* payMentArr;

-(void)setPayMentArrWithData:(NSDictionary *)dic;

@end



//allRecType	Array	所有充值方式列表
//Pay	String	充值方式编码
//PayName	String	充值方式名称
//SortNum	String	充值方式排序
//payInType	Array	后台打开的充值方式列表
//id	String	充值方式编码
//minRecMoney	String	此充值方式最低充值额
//maxRecMoney	String	此充值方式最高充值额
