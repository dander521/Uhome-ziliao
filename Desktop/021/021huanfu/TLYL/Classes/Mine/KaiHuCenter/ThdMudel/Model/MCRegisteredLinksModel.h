//
//  MCRegisteredLinksModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRegisteredLinksModel : NSObject

@property (nonatomic,strong) NSString *UserID;

@property (nonatomic,strong) NSString *RegistUrl;
@property (nonatomic,strong) NSString *CreateTime;
@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int Rebate;
@property (nonatomic,assign) int RegisteredNum;
@property (nonatomic,assign) int UserType;
@property (nonatomic,assign) int Status;
@property (nonatomic,strong) NSString *TeamName;
@property (nonatomic,strong) NSString *QQ;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
