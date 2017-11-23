//
//  MCModifyUserInfoModel.h
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCModifyUserInfoModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property(nonatomic,strong) NSString *EMail;//	是	String	用户邮箱
@property(nonatomic,strong) NSString *QQ;//	是	String	用户 QQ号码
@property(nonatomic,strong) NSString *MobilePhone;//	是	String	用户手机号码
@property(nonatomic,strong) NSString *Province;//	是	String	用户所在省份编码（如：1，代表北京市）
@property(nonatomic,strong) NSString *City;//	是	String	用户所在城市编码（如：100，代表东城区，具体数字参考自己的配置）




@end
