//
//  MCPeiEFModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPeiEFModel : NSObject
//返点值
@property (nonatomic,assign) int Rebate;
//人数限制（-1：无限制；其他数字：是几就显示几）
@property (nonatomic,assign) int Capacity;
//已注册人数
@property (nonatomic,assign) int RegisNum;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
