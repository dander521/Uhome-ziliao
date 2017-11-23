//
//  MCUrStatusModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUrStatusModel : NSObject

@property (nonatomic,strong)NSArray *UserIDList;

@property (nonatomic,assign)int OperationTypeEnum;
@property (nonatomic,strong)NSString *LoginTime;
@property (nonatomic,strong)NSString *LoginIP;
@property (nonatomic,assign)int UserID;
@property (nonatomic,assign)int PlatformCodeEnum;
//OperationTypeEnum = 1;
//PlatformCodeEnum = 0;
//UserID = 0;
//"UserLoginLog_ID" = 0;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
