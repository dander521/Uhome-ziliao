//
//  MCGetSecurityStateModel.h
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
//查询是否已设置密保问题
@interface MCGetSecurityStateModel : NSObject
singleton_h(MCGetSecurityStateModel)
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
@property (nonatomic,strong)NSString * hadSecurityState;
@end
