//
//  MCSecurityAllQuestionModel.h
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
#import "MCSecurityQuestionTool.h"
//获取所有的密保问题

@interface MCSecurityAllQuestionModel : NSObject
singleton_h(MCSecurityAllQuestionModel)
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
@property (nonatomic,strong) NSArray <MCSecurityQuestionModel *>*dataSource;

@end
