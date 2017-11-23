//
//  MCRechargeModel.h
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRechargeModel : NSObject
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property (nonatomic,strong)NSArray * allRecType;
@property (nonatomic,strong)NSArray * payInType;
- (instancetype)initWithDic:(NSDictionary *)dic;


@property (nonatomic,strong) NSString *PType;//	String	收款方式编码
@property (nonatomic,strong) NSString *PayBank;//	String	收款银行名称
@property (nonatomic,strong) NSString *PayBankAccount;//	String	收款卡号
@property (nonatomic,strong) NSString *PayMoney;//	String	充值金额
@property (nonatomic,strong) NSString *PayBankName;//	String	收款人
@property (nonatomic,strong) NSString *OrderID;//	String	订单号
@property (nonatomic,strong) NSString *BankUrl;//	String	收款银行 Url
@property (nonatomic,strong) NSString *MethodWay;//	String	请求方式
@property (nonatomic,strong) NSString *PayFuYan;//	String	附言
@property (nonatomic,strong) NSString *MValue;//	String	在线充值包含信息

@property (nonatomic,strong) NSString *PayTime;//下单时间
@property (nonatomic,strong) NSString *PayStatus;//付款状态



@property (nonatomic,strong) NSString * BankCode;//cmb
//        BankUrl = "http://www.cmbchina.com/";
//        MValue = "";
//        OrderID = LOTP153JBY0O4NPF088Q5RS0;
//        PType = 15;
//        PayBank = "\U62db\U5546\U94f6\U884c,";
//        PayBankAccount = 6214839570292151;
//        PayBankName = "\U5415\U6e2d\U743c";
//        PayFuYan = 15715;
//        PayMoney = 500;
//        explain = "";
//        video = "Decimal/cmb/cmb.swf";



/*
 * 用来存放快捷方式选择
 */
@property (nonatomic,strong)NSArray * arr_FastPayment;
@end





























