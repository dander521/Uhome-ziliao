//
//  MCModifyNickNameModel.h
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCModifyNickNameModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property(nonatomic,strong) NSString *NickName;//	新的昵称


//必选	类型	说明
//IsShow	是	Int	固定值：0
//Type	是	Int	固定值：1
//NickName	是	String	新的昵称


@end
