//
//  MCBankCardListModel.h
//  TLYL
//
//  Created by MC on 2017/7/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBankCardListModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;




@property (nonatomic,strong) NSString *UserName;//	String	用户名称
@property (nonatomic,strong) NSString *ID	;//Int	银行卡 ID
@property (nonatomic,strong) NSString *BankCode	;//String	银行名称
@property (nonatomic,strong) NSString *CardNumber	;//String	银行卡号
@property (nonatomic,strong) NSString *Province	;//String	开户省份
@property (nonatomic,strong) NSString *City	;//String	开户市级
@property (nonatomic,strong) NSString *BranchName;//	String	支行名称
@property (nonatomic,strong) NSString *Isdefault;//	Int	是否为默认卡（1：是，0：否）
@property (nonatomic,strong) NSString *CreateTime;//	String	开户时间
@end


/*
{
    "code": 200,
    "message": "成功",
    "data": [
             {
                 "UserName":"kaka",
                 "ID":3173,
                 "BankCode":"icbc",
                 "CardNumber":"4568888666338888",
                 "Province":"2",
                 "City":"202",
                 "BranchName":"徐家汇支行1号",
                 "Isdefault":1,
                 "CreateTime":"2017-04-27 09:51:13"
             }
             ]
}
*/
