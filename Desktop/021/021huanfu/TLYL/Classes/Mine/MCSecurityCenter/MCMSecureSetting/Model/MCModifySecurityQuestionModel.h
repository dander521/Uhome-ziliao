//
//  MCModifySecurityQuestionModel.h
//  TLYL
//
//  Created by MC on 2017/8/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
//修改已设置的密保问题
@interface MCModifySecurityQuestionModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//UserID	是	String	用户 ID
//UserName	是	String	用户名称
//SecurityQuestionModels	是	Array	数据列表
//ID	是	Int	当前问题的ID值
//Question	是	String	当前问题 所填答案
//KeyID	是	Int	当前问题的标识
// 请求体格式
/*
{
    "UserID":16524,
    "UserName":"adminx",
    "SecurityQuestionModels":[
                              {
                                  "ID":3,
                                  "Question":"1111",
                                  "KeyID":274
                              },
                              {
                                  "ID":2,
                                  "Question":"1234",
                                  "KeyID":275
                              }
                              ]
}
*/































