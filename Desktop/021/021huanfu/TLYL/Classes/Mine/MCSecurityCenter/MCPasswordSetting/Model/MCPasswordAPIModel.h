//
//  MCPasswordAPIModel.h
//  TLYL
//
//  Created by MC on 2017/7/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MCPasswordAPIModel : NSObject
typedef NS_ENUM(NSInteger, Type_APIPwd) {
    ModifyLoginPwd=0,
    ModifyPayPwd,
};
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithType:(Type_APIPwd )type;

//        LogPassword	是	String	旧密码
//        NewPassword	是	String	新密码
@property (nonatomic,strong)NSString *LogPassword;
@property (nonatomic,strong)NSString *NewPassword;


@end

















