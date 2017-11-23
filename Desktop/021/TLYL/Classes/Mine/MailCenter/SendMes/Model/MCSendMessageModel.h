//
//  MCSendMessageModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSendMessageModel : NSObject



@property (nonatomic,strong) NSString *SendPserson;
//当前下级的 ID 值
@property (nonatomic,assign) int SendRange;
//当前下级的用户名称
@property (nonatomic,strong) NSString *ReceivePerson;

@property (nonatomic,strong) NSString *Title;

@property (nonatomic,strong) NSString *Content;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
