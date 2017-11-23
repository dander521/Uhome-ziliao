//
//  MCAddSubDayWageContractModel.h
//  TLYL
//
//  Created by MC on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

//添加下级的日工资契约 （日工资3）
@interface MCAddSubDayWageContractModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
