//
//  MCHistoryIssueAPIModel.h
//  TLYL
//
//  Created by MC on 2017/7/31.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MCHistoryIssueAPIModel : NSObject
{
@public
    int _page;
}
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;



//IsSelf	是	Boolean	固定传 false
//reType	是	Int	固定传1
//CZID	是	String	彩种ID组成的字符串（如：”12,58,66,75,74,56”）
@end
