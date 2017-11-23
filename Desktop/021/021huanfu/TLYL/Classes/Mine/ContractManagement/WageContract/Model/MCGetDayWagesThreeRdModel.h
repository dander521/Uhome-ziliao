//
//  MCGetDayWagesThreeRdModel.h
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//查看 当前登录用户 是否有新的日工资契约（日工资3）
//UserName    是    String    当前登录用户名
//DayWagesState    是    Int    固定值：-1
//UserType    是    Int    固定值：0
//AgentLevel    是    Int    固定值：0
//CurrentPageIndex    是    Int    当前页下标（第一页为1，后续页码依次加1）
//CurrentPageSize    是    Int    请求条目数
@interface MCGetDayWagesThreeRdModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
