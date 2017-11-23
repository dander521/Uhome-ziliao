//
//  MCBankModel.h
//  TLYL
//
//  Created by MC on 2017/7/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBankModel : NSObject
//创建时间
@property (nonatomic,strong)NSString *CreateTime;
//用户姓名
@property (nonatomic,strong)NSString *userName;

//银行
@property (nonatomic,strong)NSString *bankName;

//银行ID
@property (nonatomic,strong)NSString *bankId;

//省份ID
@property (nonatomic,strong)NSString * provinceId;

//市区ID
@property (nonatomic,strong)NSString * cityId;

//省份名称
@property (nonatomic,strong)NSString * provinceName;

//市区名称
@property (nonatomic,strong)NSString * cityName;

//支行名称
@property (nonatomic,strong)NSString * subBankName;

//卡号/**[1234 2345 4321 7788]*/
@property (nonatomic,strong)NSString * bankNumer;
/**[**** **** **** 7788]*/
@property (nonatomic,strong)NSString * showBankNumber;
//"北京市":{
//    "id": "1",
//    "text": "北京市",
//    "city": [
//             {
//                 "id": "100",
//                 "text": "东城区"




@property (nonatomic,strong)NSString * bankLogo;

//"icbc" : {"name":"中国工商银行","logo":"images/bank/icbc.png"},

//是否是默认银行卡  1 是  0 不是
@property (nonatomic,strong)NSString * Isdefault;

@property (nonatomic,strong)NSString * BankCode;//BankCode = comm;

@end


//BankCode = comm;
//BranchName = "\U4ea4\U901a\U94f6\U884c\U897f\U5b89\U79d1\U6280\U8def\U652f\U884c";
//CardNumber = 6222600810020865911;
//City = "\U897f\U5b89\U5e02";
//CreateTime = "2017-07-21 17:09:19";
//ID = 3466;
//Isdefault = 1;
//Province = "\U9655\U897f\U7701";
//Reserve1 = "<null>";
//Reserve2 = "<null>";
//Reserve3 = "<null>";
//UserName = kai;
//"User_ID" = 0;
















