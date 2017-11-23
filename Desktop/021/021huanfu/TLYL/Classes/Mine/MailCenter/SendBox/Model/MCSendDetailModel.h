//
//  MCSendDetailModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSendDetailModel : NSObject

@property (nonatomic,assign) int ID;

@property (nonatomic,strong) NSString *Title;
@property (nonatomic,strong) NSString *Content;
@property (nonatomic,strong) NSString *SendPerson;
@property (nonatomic,assign) int SendPersonLevel;
@property (nonatomic,strong) NSString *SendDateTime;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;

@end
