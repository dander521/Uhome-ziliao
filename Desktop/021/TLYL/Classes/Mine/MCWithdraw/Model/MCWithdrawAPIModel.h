//
//  MCWithdrawAPIModel.h
//  TLYL
//
//  Created by MC on 2017/7/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCWithdrawAPIModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property (nonatomic,strong)NSArray * allRecType;
@property (nonatomic,strong)NSArray * payInType;
- (instancetype)initWithDic:(NSDictionary *)dic;


//UserRealName	是	String	用户真实姓名
//DrawingsMoney	是	String	提款金额
//PayPassWord	是	String	提款密码（资金密码）

@end
