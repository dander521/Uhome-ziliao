//
//  MCBandRealNameModel.h
//  TLYL
//
//  Created by MC on 2017/8/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBandRealNameModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property(nonatomic,strong) NSString * RealName;
//RealName	是	String	真实姓名
//UserID	是	Int	用户 ID

@end
