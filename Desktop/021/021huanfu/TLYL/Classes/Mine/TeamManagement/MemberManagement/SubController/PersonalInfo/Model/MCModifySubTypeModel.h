//
//  MCModifySubTypeModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCModifySubTypeModel : NSObject
@property (nonatomic,assign)int subUserID;
@property (nonatomic,assign)int Type;
//OperationTypeEnum = 1;
//PlatformCodeEnum = 0;
//UserID = 0;
//"UserLoginLog_ID" = 0;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
