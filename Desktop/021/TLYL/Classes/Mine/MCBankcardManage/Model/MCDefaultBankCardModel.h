//
//  MCDefaultBankCardModel.h
//  TLYL
//
//  Created by MC on 2017/8/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDefaultBankCardModel : NSObject
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property(nonatomic,strong)NSString *BankCardId;//	是	Int	银行卡 ID
@property(nonatomic,strong)NSString *CardNumber;//	是	String	银行卡号


@end
