//
//  MCRechargeOrderReminderModel.h
//  TLYL
//
//  Created by MC on 2017/8/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRechargeOrderReminderModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;


@property (nonatomic,strong)NSString * PayRealName	 ;//是	String	真实姓名
@property (nonatomic,strong)NSString * TransferAmount;//是	String	转账金额
@property (nonatomic,strong)NSString * TransferTime	 ;//是	String	转账时间
@property (nonatomic,strong)NSString * ReceiveName	 ;//是	String	收款人
@property (nonatomic,strong)NSString * ReceiveBank	 ;//是	String	收款银行
@property (nonatomic,strong)NSString * ReceiveCardNumber;//是	String	收款卡号
@property (nonatomic,strong)NSString * OrderNumber	 ;//是	String	订单号
@property (nonatomic,strong)NSString * PayCarNumber	 ;//是	String	固定值：传空字符串

@end
