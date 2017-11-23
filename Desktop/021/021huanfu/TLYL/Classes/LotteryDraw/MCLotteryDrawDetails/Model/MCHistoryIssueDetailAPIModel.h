//
//  MCHistoryIssueDetailAPIModel.h
//  TLYL
//
//  Created by MC on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
@interface MCHistoryIssueDetailAPIModel : NSObject
singleton_h(MCHistoryIssueDetailAPIModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@property (nonatomic,strong)NSString *LotteryCode;//彩种编码值
//Size	是	Int	期号条数
@property (nonatomic,assign)int Page;//	否	Int	当前页码

@property (nonatomic,assign)BOOL isNeedUpdate;

@end
