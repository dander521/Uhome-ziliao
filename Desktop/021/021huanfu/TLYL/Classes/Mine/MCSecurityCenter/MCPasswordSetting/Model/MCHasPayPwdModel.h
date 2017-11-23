//
//  MCHasPayPwdModel.h
//  TLYL
//
//  Created by MC on 2017/7/31.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"



@interface MCHasPayPwdModel : NSObject
singleton_h(MCHasPayPwdModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property (nonatomic,strong)NSString *PayOutPassWord;//	Int	是否设置资金密码（1：已设置，0：未设置）


@end
