//
//  MCGetLotteryCustomModel.h
//  TLYL
//
//  Created by MC on 2017/8/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGetLotteryCustomModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;



@end
