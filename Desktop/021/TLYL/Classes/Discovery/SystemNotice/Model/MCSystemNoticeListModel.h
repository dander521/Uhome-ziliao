//
//  MCSystemNoticeListModel.h
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSystemNoticeListModel : NSObject
{
    @public
    int _currentPageIndex;
}
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property (nonatomic,assign) BOOL isHomePage;
@property (nonatomic,strong)NSString * ddUser;
@property (nonatomic,strong)NSString * InsertTime;
@property (nonatomic,strong)NSString * LastEditTime;
@property (nonatomic,strong)NSString * MerchantNews_ID;
@property (nonatomic,strong)NSString * Merchant_Code;
@property (nonatomic,strong)NSString * NewsContent;
@property (nonatomic,strong)NSString * NewsImages;
@property (nonatomic,strong)NSString * NewsState;
@property (nonatomic,strong)NSString * NewsTittle;
@property (nonatomic,strong)NSString * NewsType;
@end
//DataCount	Int	消息数量
//PageCount	Int	页码数
//NewsList	Array	消息列表
//NewsID	Int	消息 ID 值
//NewsTitle	String	消息标题
//InsertTime	String	消息创建时间

//ddUser = "<null>";
//InsertTime = "2017/8/7 10:50:16";
//LastEditTime = "<null>";
//"MerchantNews_ID" = 59;
//"Merchant_Code" = "<null>";
//NewsContent = "<null>";
//NewsImages = "<null>";
//NewsState = "<null>";
//NewsTittle = 123456;
//NewsType = "<null>";




















