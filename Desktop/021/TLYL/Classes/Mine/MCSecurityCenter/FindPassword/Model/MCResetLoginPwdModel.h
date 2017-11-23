//
//  MCResetLoginPwdModel.h
//  TLYL
//
//  Created by MC on 2017/10/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCResetLoginPwdModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end




