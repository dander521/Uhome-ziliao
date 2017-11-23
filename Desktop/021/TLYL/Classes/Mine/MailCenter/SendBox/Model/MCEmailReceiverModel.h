//
//  MCEmailReceiverModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEmailReceiverModel : NSObject
@property (nonatomic,strong) NSString *Sendid;
@property (nonatomic,assign) int CurrentPageIndex;
@property (nonatomic,assign) int CurrentPageSize;
//是否已读（1：已读，2：未读）
@property (nonatomic,assign) int EmailState;
//收件人名称
@property (nonatomic,strong) NSString *ReceivePerson;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
