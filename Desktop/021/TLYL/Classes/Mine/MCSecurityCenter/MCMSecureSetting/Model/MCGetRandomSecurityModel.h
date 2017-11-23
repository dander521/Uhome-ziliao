//
//  MCGetRandomSecurityModel.h
//  TLYL
//
//  Created by MC on 2017/10/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
#import "MCSecurityQuestionTool.h"

//获取所有的密保问题
@interface MCGetRandomSecurityModel : NSObject
singleton_h(MCGetRandomSecurityModel)
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
@property (nonatomic,strong) MCSecurityQuestionModel *dataSource;

@end
