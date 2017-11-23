//
//  MCGetplayawardModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwardAmountModel : NSObject

@property(nonatomic,strong) NSString *AwardAmount;

@end



@interface MCGetplayawardModel : NSObject

@property (nonatomic,assign) int lotteryNumber;

@property(nonatomic,strong) NSString *PlayCode;

@property(nonatomic,strong) NSArray *AwardLevelInfo;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);



- (void)refreashDataAndShow;

@end
