//
//  MCEmailAllModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEmailAllModel : NSObject

@property (nonatomic,assign) BOOL selected;

@property (nonatomic,strong) NSString *UserID;
//当前下级的 ID 值
@property (nonatomic,assign) int User_ID;
//当前下级的用户名称
@property (nonatomic,strong) NSString *ChildUserName;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;

@end
