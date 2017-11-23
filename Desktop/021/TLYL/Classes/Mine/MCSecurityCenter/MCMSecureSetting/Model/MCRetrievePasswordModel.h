//
//  MCRetrievePasswordModel.h
//  TLYL
//
//  Created by MC on 2017/10/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
#import "MCSecurityQuestionTool.h"

//验证密保答案是否正确
@interface MCRetrievePasswordModel : NSObject
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
