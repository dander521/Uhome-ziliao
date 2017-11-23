//
//  MCPeiEDModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPeiEDModel : NSObject
//返点值
@property (nonatomic,assign) int Rebate;

@property (nonatomic,strong) NSArray *UserName;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
