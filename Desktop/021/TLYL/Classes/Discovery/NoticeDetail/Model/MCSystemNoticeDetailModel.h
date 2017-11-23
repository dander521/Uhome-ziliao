//
//  MCSystemNoticeDetailModel.h
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSystemNoticeDetailModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property(nonatomic,strong)NSString * NewsID;

@property(nonatomic,strong)NSString * NewsTitle;//": "Welcome",
@property(nonatomic,strong)NSString * InsertTime;//": "2017/6/13 20:15:08",
@property(nonatomic,strong)NSString * NewsContent;//":"消息主体内容"
@end
