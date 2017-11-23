//
//  MCInboxDetailModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCInboxDetailModel : NSObject

@property (nonatomic,assign) int ID;
//标题
@property (nonatomic,strong) NSString *Title;
//内容
@property (nonatomic,strong) NSString *Content;
//发件人ID
@property (nonatomic,assign) int SendUserID;
//SendPerson
@property (nonatomic,strong) NSString *SendPerson;
//SendPersonLevel
@property (nonatomic,assign) int SendPersonLevel;
//发送时间
@property (nonatomic,strong) NSString *SendDateTime;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
