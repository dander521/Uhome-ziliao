//
//  MCSetSecurityQuestionModel.h
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//第一次设置密保问题
@interface MCSetSecurityQuestionModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
- (instancetype)initWithDic:(NSDictionary *)dic;


//UserID	是	String	用户 ID
//UserName	是	String	用户名称
//SecurityQuestionModels	是	Array	数据列表
//ID	是	Int	当前问题的ID值
//Question	是	String	当前问题 所填答案

// 请求体格式
/*
{
    "UserID":16524,
    "UserName":"adminx",
    "SecurityQuestionModels":[
                              {
                                  "ID":3,
                                  "Question":"1111"
                              },
                              {
                                  "ID":2,
                                  "Question":"1234"
                              }
                              ]
}
 */

@end




































