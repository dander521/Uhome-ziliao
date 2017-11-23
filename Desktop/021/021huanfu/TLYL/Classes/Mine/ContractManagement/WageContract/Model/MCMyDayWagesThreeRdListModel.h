//
//  MCMyDayWagesThreeRdListModel.h
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//查看 当前登录用户 的日工资数据列表（日工资3）
@interface MCMyDayWagesThreeRdListModel : NSObject
//UserID    是    String    当前登录用户 ID
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end




