//
//  MCGetSelfContractStateModel.h
//  TLYL
//
//  Created by MC on 2017/11/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//简要描述：
//查看 当前登录用户 是否有新的分红契约
//请求URL：
///web-api/api/v4/get_self_contract
@interface MCGetSelfContractStateModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
