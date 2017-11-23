//
//  MCCancleLotteryModel.h
//  TLYL
//
//  Created by miaocai on 2017/8/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCancleLotteryModel : NSObject
{
@public
    NSString *_code;
    NSString *_orderID;
}
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;
@end
