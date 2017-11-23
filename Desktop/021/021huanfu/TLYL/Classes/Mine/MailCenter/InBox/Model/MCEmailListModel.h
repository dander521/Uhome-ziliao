//
//  MCEmailListModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCEmailListModel : NSObject

@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,assign) int CurrentPageSize;
@property (nonatomic,assign) int CurrentPageIndex;

@property (nonatomic,assign) int ID;

@property (nonatomic,strong) NSString *Title;
@property (nonatomic,strong) NSString *Content;

@property (nonatomic,strong) NSString *SendDateTime;
@property (nonatomic,assign) int SendPersonLevel;

@property (nonatomic,strong) NSString *SendPerson;
@property (nonatomic,assign) int ReceiveUserID;

@property (nonatomic,strong) NSString *ReceivePerson;
@property (nonatomic,assign) int EmailState;



@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
